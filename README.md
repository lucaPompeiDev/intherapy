# Studio Colantoni — versione HTML statica

Porting 1:1 del progetto Flutter `intherapy` in HTML/CSS/JS statico.
Stessa struttura, stessi contenuti, stessa palette e stessi breakpoint.

## Struttura

    index.html        Home      (HomePage: hero, about, 2 preview, Instagram)
    team.html         Team      (TeamPage: griglia kTeam)
    terapie.html      Terapie   (TherapiesPage: griglia kTherapies)
    assets/css/style.css        token da app_theme.dart + responsive.dart
    assets/js/main.js           drawer mobile (AppEndDrawer)
    assets/js/instagram.js      feed dal Worker (InstagramService)
    manifest.json, robots.txt, sitemap.xml

## Corrispondenze con il progetto Flutter

| Flutter                        | HTML statico                          |
|--------------------------------|---------------------------------------|
| `RootShell` + `AnimatedSwitcher` | 3 pagine separate (URL reali)        |
| `TopNavBar`                    | `.topbar` + `.nav` (vedi nota sotto)  |
| `AppEndDrawer`                 | `#drawer` + `assets/js/main.js`       |
| `_Footer`                      | `.footer`                             |
| `RoundedCard` / `RoundedPill`  | `.card` / `.pill`                     |
| `RoundedPhoto`                 | `.photo` (+ `--xl`, `--md`, `--circle`) |
| `gridColumns()`                | `--grid-cols` per media query         |
| `pageHorizontalPadding()`      | `--hpad` per media query              |
| `cardAspectRatio()`            | `--team-ratio` / `--therapy-ratio`    |
| `AppColors` / `AppRadius`      | variabili CSS in `:root`              |
| `Icons.*_rounded`              | Material Symbols Rounded (FILL 1)     |
| `GoogleFonts.poppins`          | Poppins da Google Fonts               |

## Da sistemare prima di pubblicare

1. `IL-TUO-DOMINIO.it` — sostituire in: `index.html`, `team.html`,
   `terapie.html` (canonical + og:url), `robots.txt`, `sitemap.xml`.
2. Il JSON-LD in `index.html` usa i dati da `app_it.arb`
   (indirizzo, telefono, fondatrice): **verificarli**.
3. I contenuti visibili sono ancora i placeholder del progetto Flutter
   (Elena Bianchi, Marco Rossi, "Massaggio Rilassante", foto picsum.photos):
   vanno sostituiti con i contenuti veri.
4. Snippet iubenda: incollarlo prima di `</head>` in tutte e tre le pagine.

## Provarlo in locale

    cd site && python3 -m http.server 8000
    # poi apri http://localhost:8000

## Nota: la barra di navigazione non è la pillola del Flutter

È l'unica divergenza voluta dall'originale.

Nel Flutter la pillola attiva si spostava con un `AnimatedContainer`, perché
le tre pagine erano un solo documento: cambiava solo un `_index`. Qui sono
tre documenti separati (è il motivo per cui esistono `/team.html` e
`/terapie.html` come URL indicizzabili), quindi lo stato attivo cambia
durante un **caricamento di pagina**.

Animare quel cambiamento richiede una view transition con elemento condiviso:
il browser deve fotografare la pillola sulla pagina vecchia, ritrovarla su
quella nuova e interpolare. Funziona finché tutto va liscio, ma le
cross-document view transition hanno un budget di **4 secondi**: se la pagina
di destinazione non è renderizzabile in tempo la transizione muore in silenzio
e la pillola salta. Da qui i salti intermittenti.

La barra a sottolineatura non ha questo problema perché **non c'è niente da
animare fra una pagina e l'altra**:

- la sottolineatura è in `position: absolute` -> attiva e inattiva hanno
  geometria identica (verificato: 109.0 x 48.5 px in entrambi i casi), quindi
  nessuno scarto di layout;
- lo stato attivo è `transform: scaleX(1)` e le transition CSS non partono
  sullo stato iniziale -> al primo frame dipinto è già corretto, in ogni
  browser, senza dipendere da nulla;
- il movimento resta solo sull'`:hover`, che avviene dentro la stessa pagina
  ed è sempre fluido (e su touch è disattivato, vedi sotto).

Colori: bordeaux per la pagina corrente, giallo in hover — gli stessi due
delle cornici delle foto.

## Movimento

- **Cambio pagina**: solo una dissolvenza (`@view-transition { navigation: auto }`).
  Nessun `view-transition-name` condiviso. Se la transizione non parte, la
  pagina cambia e basta: assente, non scattosa.
  Per toglierla del tutto, cancella il blocco `@view-transition` in `style.css`.
- **Curve**: `cubic-bezier(0.4, 0, 0.2, 1)` = `Curves.fastOutSlowIn`, la stessa
  di Flutter.
- `prefers-reduced-motion: reduce` spegne tutto.

### Nessuna risorsa esterna: era la causa dei difetti

- **Icone**: sprite SVG inline (16 icone, ~9 KB, path autentici Material Symbols).
  Il font-icona di prima (a) era una richiesta render-blocking, (b) lasciava le
  legature come testo nel DOM ("spa", "home") sporcando il SEO, (c) **cambiava
  la larghezza degli elementi quando arrivava**.
- **Poppins**: ospitato in locale (`@fontsource/poppins`, licenza OFL, 24 KB per
  i 3 pesi) con `preload`. Prima arrivava da `fonts.googleapis.com` con un
  `<link>` render-blocking: con quella richiesta lenta o bloccata le view
  transition **non partivano affatto** (verificato). In più il CDN di Google
  non riceve più l'IP dei visitatori: su un sito sanitario europeo con iubenda,
  una grana in meno.

Resta esterno solo `picsum.photos` per le foto placeholder, da sostituire.

### Touch

- `-webkit-tap-highlight-color: transparent` su `html` (proprietà ereditata,
  copre tutto). Prima mancava sul `.menu-btn`, cioè proprio il pulsante che si
  tocca su mobile: da lì il flash blu.
- Tutti gli `:hover` sono dentro `@media (hover: hover)`: su touch il `:hover`
  scatta al tap e resta incollato.
- Drawer: `translate3d` (GPU) + `overscroll-behavior: contain` + `touch-action: none`.

### Tarature

In `assets/css/style.css`, in `:root`:

    --dur-page: 280ms;   /* dissolvenza del cambio pagina */
    --dur-ui: 200ms;     /* hover e stati dei controlli */
    --ease: cubic-bezier(0.4, 0, 0.2, 1);

## Anteprima per il cliente su GitHub Pages

Il file `deploy-anteprima.yml` va messo nel repo in
`.github/workflows/deploy-anteprima.yml`. L'anteprima esce su
`https://TUO-UTENTE.github.io/intherapy/`.

### Tre cose da fare prima

1. **Settings -> Pages -> Source -> "GitHub Actions"**. Se resta su
   "Deploy from a branch", il workflow non pubblica niente.

2. **Disattiva il workflow Flutter esistente** (`.github/workflows/deploy.yml`).
   Usa `bluefireteam/flutter-gh-pages`, che pubblica spingendo sul branch
   `gh-pages`: punta allo stesso sito Pages di questo workflow. I due si
   sovrascrivono a vicenda e vince l'ultimo che gira.

3. Metti il sito statico in una cartella `site/` alla radice del repo
   (o cambia `SITE_DIR` nel workflow).

### Niente baseHref

Il workflow Flutter aveva `baseHref: /intherapy/` perché il sito sta in una
sottocartella. Qui non serve: tutti i percorsi sono relativi
(`href="team.html"`, `assets/css/style.css`), quindi funzionano sotto qualsiasi
sottocartella. Verificato servendo il sito da `/intherapy/`: 16/16 icone,
font caricato, navigazione corretta, zero richieste fallite.

Corretto anche `manifest.json`: `start_url` era `/`, che su
`utente.github.io/intherapy/` puntava fuori dal sito. Ora è `./`.

### L'anteprima è bloccata all'indicizzazione, apposta

Il workflow inietta `<meta name="robots" content="noindex, nofollow">` in ogni
pagina, sostituisce `robots.txt` con un `Disallow: /` e cancella la sitemap.

Non è pignoleria. Se Google indicizza l'anteprima:

- i nomi placeholder (Elena Bianchi, Marco Rossi, "Massaggio Rilassante")
  finiscono nei risultati associati allo studio;
- quando il sito vero andrà online sul dominio, si troverà a competere con la
  propria copia su github.io -> contenuti duplicati, e il danno cade proprio
  sul SEO che tutto questo lavoro serviva a salvare.

Il blocco è iniettato **in fase di build**, non nei file sorgente: il codice nel
repo resta pronto per la produzione, senza `noindex` da ricordarsi di togliere
il giorno del lancio.

### Due cose da verificare tu

- **Il feed Instagram**: passa dal Worker su Cloudflare, il cui codice non è in
  questo repo. Su GitHub Pages l'origine diventa `github.io`: se il Worker
  limita le origini via CORS, il feed non caricherà (vedrai lo stato di errore
  con "Riprova"). Non ho potuto verificarlo da qui.
- **L'anteprima è pubblica**: chiunque abbia l'URL la vede. Per un'anteprima con
  contenuti placeholder va bene; se ti serve davvero privata, servono Pages su
  repo privato (piano a pagamento) o un altro host.
