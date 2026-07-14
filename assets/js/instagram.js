/* Sezione "Seguici su Instagram".
   Porta di lib/widgets/instagram_showcase.dart + lib/services/instagram_service.dart.
   Nessun token qui dentro: il Worker fa da proxy verso la Graph API,
   esattamente come nella versione Flutter. */
(function () {
  "use strict";

  var WORKER_BASE_URL =
    "https://instagram-showcase-worker.instagram-showcase-worker-intherapy.workers.dev";

  var slot = document.getElementById("ig-feed");
  if (!slot) return;

  /* --- InstagramService.fetchRecentPosts() --- */
  function fetchRecentPosts() {
    return fetch(WORKER_BASE_URL + "/instagram-feed").then(function (res) {
      if (res.status !== 200) {
        throw new Error(
          "Impossibile caricare il feed Instagram (status " + res.status + ")"
        );
      }
      return res.json().then(function (data) {
        if (data.error) throw new Error(data.error);
        return (data.posts || []).map(function (p) {
          return {
            id: p.id || "",
            caption: p.caption || "",
            mediaType: p.mediaType || "IMAGE",
            mediaUrl: p.mediaUrl || "",
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

  function renderLoading() {
    slot.innerHTML = '<div class="spinner" role="status" aria-label="Caricamento"></div>';
  }

  function renderError() {
    slot.innerHTML =
      '<div class="ig-error">' +
      '<span class="icon" aria-hidden="true">wifi_off</span>' +
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
        // La caption diventa l'alt: testo reale nel DOM, leggibile
        // dai crawler e dagli screen reader.
        var alt = post.caption
          ? esc(post.caption).slice(0, 120)
          : "Post Instagram dello Studio Colantoni";
        return (
          '<a class="ig-card" href="' +
          esc(post.permalink) +
          '" target="_blank" rel="noopener noreferrer">' +
          '<div class="photo photo--md">' +
          '<img src="' +
          esc(post.mediaUrl) +
          '" alt="' +
          alt +
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
