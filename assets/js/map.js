/* ============================================================
   map.js — Mappa con caricamento su clic (click-to-load)
   ------------------------------------------------------------
   La mappa Google è un iframe verso un dominio terzo. Caricarla
   subito trasmetterebbe l'IP del visitatore a Google prima di
   qualsiasi consenso. Qui l'iframe viene creato SOLO dopo che
   l'utente clicca sul placeholder: di default il sito non fa
   nessuna richiesta a Google. Il clic esplicito vale come consenso.

   L'URL della mappa sta in data-map-src sul contenitore #map,
   così questo file non contiene nulla di specifico e resta riusabile.
   ============================================================ */
(function () {
  "use strict";

  var box = document.getElementById("map");
  var btn = document.getElementById("map-load");
  if (!box || !btn) return;

  var src = box.getAttribute("data-map-src");
  if (!src) return;

  btn.addEventListener("click", function () {
    var iframe = document.createElement("iframe");
    iframe.src = src;
    iframe.title = "Mappa dello Studio Colantoni";
    iframe.loading = "lazy";
    iframe.allowFullscreen = true;
    iframe.referrerPolicy = "strict-origin-when-cross-origin";
    // Sostituisce il placeholder con la mappa vera.
    box.innerHTML = "";
    box.appendChild(iframe);
  });
})();
