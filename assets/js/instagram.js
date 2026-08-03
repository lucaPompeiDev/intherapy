/* ============================================================
   instagram.js — Sezione "Seguici su Instagram"
   ------------------------------------------------------------
   Il feed arriva dal Cloudflare Worker, che fa da proxy verso la
   Graph API. Nessun token qui dentro.

   MODIFICHE rispetto alla versione precedente (correzioni discusse):
   1. mediaUrl: se il Worker restituisce un percorso RELATIVO
      (es. "/instagram-media/<id>", cioè immagini proxate dal Worker
      per non far contattare Meta al browser), lo prefissiamo con
      WORKER_BASE_URL. Se invece è già un URL assoluto, lo usiamo così
      com'è. In questo modo il frontend funziona con entrambe le versioni
      del Worker.
   2. Stato di errore: l'icona ora è un vero SVG dallo sprite
      (#i-wifi_off). Prima era il testo "wifi_off", che con lo sprite
      SVG restava scritto a schermo.
   3. Alt della foto: prima si faceva esc(caption).slice(120) — così si
      poteva tagliare a metà un'entità HTML ("...&am"). Ora si tronca
      PRIMA di fare l'escape. In più si rimuovono gli hashtag, che uno
      screen reader leggerebbe uno per uno come rumore.
   4. Controllo risposta: !res.ok invece di res.status !== 200.
   5. Timeout: AbortSignal.timeout(8000), così lo spinner non gira
      all'infinito se il Worker non risponde.
   ============================================================ */
(function () {
  "use strict";

  var WORKER_BASE_URL =
    "https://instagram-showcase-worker.instagram-showcase-worker-intherapy.workers.dev";

  var slot = document.getElementById("ig-feed");
  if (!slot) return;

  // Prefissa i percorsi relativi con il dominio del Worker (vedi punto 1).
  function resolveMediaUrl(u) {
    if (!u) return "";
    if (/^https?:\/\//i.test(u)) return u;      // già assoluto
    return WORKER_BASE_URL + (u.charAt(0) === "/" ? u : "/" + u);
  }

  /* --- InstagramService.fetchRecentPosts() --- */
  function fetchRecentPosts() {
    return fetch(WORKER_BASE_URL + "/instagram-feed", {
      // Timeout: se il Worker è lento, la promise fallisce (vedi punto 5).
      signal: AbortSignal.timeout(8000)
    }).then(function (res) {
      if (!res.ok) {
        throw new Error("Impossibile caricare il feed Instagram (status " + res.status + ")");
      }
      return res.json().then(function (data) {
        if (data.error) throw new Error(data.error);
        return (data.posts || []).map(function (p) {
          return {
            id: p.id || "",
            caption: p.caption || "",
            mediaType: p.mediaType || "IMAGE",
            mediaUrl: resolveMediaUrl(p.mediaUrl || ""),
            permalink: p.permalink || "",
            timestamp: p.timestamp || ""
          };
        });
      });
    });
  }

  function esc(s) {
    return String(s).replace(/[&<>"']/g, function (c) {
      return { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c];
    });
  }

  // Testo alternativo pulito: via gli hashtag, tronca, poi fai l'escape.
  function altFromCaption(caption) {
    if (!caption) return "Post Instagram dello Studio Colantoni";
    var clean = caption.replace(/#\S+/g, "").replace(/\s+/g, " ").trim();
    if (!clean) return "Post Instagram dello Studio Colantoni";
    return esc(clean.slice(0, 120));
  }

  function renderLoading() {
    slot.innerHTML = '<div class="spinner" role="status" aria-label="Caricamento"></div>';
  }

  function renderError() {
    slot.innerHTML =
      '<div class="ig-error">' +
      '<svg class="icon" aria-hidden="true"><use href="#i-wifi_off"></use></svg>' +
      '<p class="body-md ig-error__text">Non riusciamo a caricare il feed Instagram in questo momento.</p>' +
      '<button type="button" class="btn btn--primary" id="ig-retry">Riprova</button>' +
      "</div>";
    document.getElementById("ig-retry").addEventListener("click", load);
  }

  function renderEmpty() {
    slot.innerHTML = '<p class="body-md">Nessun post disponibile al momento.</p>';
  }

  function renderPosts(posts) {
    var html = posts
      .map(function (post) {
        return (
          '<a class="ig-card" href="' + esc(post.permalink) +
          '" target="_blank" rel="noopener noreferrer">' +
          '<div class="photo photo--md">' +
          '<img src="' + esc(post.mediaUrl) + '" alt="' + altFromCaption(post.caption) +
          '" loading="lazy" width="400" height="400">' +
          "</div></a>"
        );
      })
      .join("");
    slot.innerHTML = '<div class="ig-grid">' + html + "</div>";
  }

  function load() {
    renderLoading();
    fetchRecentPosts()
      .then(function (posts) {
        if (!posts.length) return renderEmpty();
        renderPosts(posts);
      })
      .catch(function (err) {
        console.error(err);
        renderError();
      });
  }

  load();
})();
