/* Drawer di navigazione mobile — equivalente di AppEndDrawer
   aperto da Scaffold.of(context).openEndDrawer(). */
(function () {
  "use strict";

  var btn = document.querySelector(".menu-btn");
  var drawer = document.getElementById("drawer");
  var scrim = document.getElementById("scrim");

  if (!btn || !drawer || !scrim) return;

  function open() {
    drawer.classList.add("is-open");
    scrim.classList.add("is-open");
    btn.setAttribute("aria-expanded", "true");
    drawer.removeAttribute("aria-hidden");
    document.body.style.overflow = "hidden";
    var first = drawer.querySelector(".drawer__item");
    if (first) first.focus();
  }

  function close() {
    drawer.classList.remove("is-open");
    scrim.classList.remove("is-open");
    btn.setAttribute("aria-expanded", "false");
    drawer.setAttribute("aria-hidden", "true");
    document.body.style.overflow = "";
    btn.focus();
  }

  btn.addEventListener("click", open);
  scrim.addEventListener("click", close);

  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape" && drawer.classList.contains("is-open")) close();
  });

  // Se si torna sopra il breakpoint mobile (700px) mentre il drawer
  // è aperto, lo chiudiamo: la navbar orizzontale torna visibile.
  window.addEventListener("resize", function () {
    if (window.innerWidth >= 700 && drawer.classList.contains("is-open")) close();
  });
})();
