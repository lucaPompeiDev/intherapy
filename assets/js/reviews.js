/* ============================================================
   reviews.js — Carosello recensioni ("Cosa dicono di noi")
   ------------------------------------------------------------
   Una recensione visibile per volta. Lo scorrimento vero è nativo
   (scroll-snap CSS): questo file aggiunge solo frecce, puntini,
   sincronizzazione e stato "disabilitato" agli estremi.
   - Touch/swipe: gestito dal browser (scroll-snap), nessun codice.
   - Frecce: scorrono di una card.
   - Puntini: portano alla card corrispondente e mostrano quella attiva.
   ============================================================ */
(function () {
  "use strict";

  var track = document.getElementById("reviews-track");
  if (!track) return;

  var carousel = track.closest(".reviews-carousel");
  var slides = Array.prototype.slice.call(track.querySelectorAll(".review"));
  if (!slides.length) return;

  var prevBtn = carousel.querySelector('[data-dir="prev"]');
  var nextBtn = carousel.querySelector('[data-dir="next"]');
  var dots = Array.prototype.slice.call(carousel.querySelectorAll(".carousel-dot"));

  // Indice corrente ricavato dalla posizione di scorrimento.
  function currentIndex() {
    return Math.round(track.scrollLeft / track.clientWidth);
  }

  // Aggiorna puntini attivi e disabilita le frecce agli estremi.
  function setActive(i) {
    dots.forEach(function (d, idx) {
      var on = idx === i;
      d.classList.toggle("is-active", on);
      d.setAttribute("aria-selected", on ? "true" : "false");
    });
    if (prevBtn) prevBtn.disabled = i <= 0;
    if (nextBtn) nextBtn.disabled = i >= slides.length - 1;
  }

  // Da scorrimento/swipe: ricava l'indice dalla posizione e aggiorna.
  function sync() {
    setActive(currentIndex());
  }

  function goTo(i) {
    i = Math.max(0, Math.min(slides.length - 1, i));
    setActive(i);   // aggiorna subito l'interfaccia, senza aspettare lo scroll
    track.scrollTo({ left: i * track.clientWidth, behavior: "smooth" });
  }

  if (prevBtn) prevBtn.addEventListener("click", function () { goTo(currentIndex() - 1); });
  if (nextBtn) nextBtn.addEventListener("click", function () { goTo(currentIndex() + 1); });
  dots.forEach(function (d, idx) {
    d.addEventListener("click", function () { goTo(idx); });
  });

  // Frecce da tastiera quando il carosello ha il focus.
  track.addEventListener("keydown", function (e) {
    if (e.key === "ArrowRight") { e.preventDefault(); goTo(currentIndex() + 1); }
    if (e.key === "ArrowLeft")  { e.preventDefault(); goTo(currentIndex() - 1); }
  });

  // Ricalcolo "sfrondato" su scroll (anche da swipe) e su resize.
  var t;
  function debounced() { clearTimeout(t); t = setTimeout(sync, 80); }
  track.addEventListener("scroll", debounced, { passive: true });
  window.addEventListener("resize", debounced);

  sync();
})();
