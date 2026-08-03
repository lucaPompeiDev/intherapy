# Studio Colantoni — sito statico (HTML/CSS/JS)

Sito statico ristrutturato secondo le nuove linee guida.
Nessun framework, nessuna build: sono file statici che puoi caricare così
come sono su qualsiasi hosting. Palette e componenti derivano dal progetto
Flutter originale (`app_theme.dart`), invariati.

## Struttura delle pagine

    index.html                                Home
    terapie.html                              Terapie (panoramica delle 4 aree)
    chi-e-dove-siamo.html                     Chi e dove siamo
    terapia-cognitivo-comportamentale.html    Dettaglio terapia
    neuropsicologia-clinica.html              Dettaglio terapia
    psicologia-e-psicoterapia.html            Dettaglio terapia
    terapia-emdr.html                         Dettaglio terapia
    privacy.html                              Informativa privacy (bozza)

    assets/css/style.css     Token + tutti i componenti (palette invariata)
    assets/js/main.js        Drawer di navigazione mobile
    assets/js/instagram.js   Feed Instagram dal Worker (con correzioni)
    assets/js/map.js         Mappa a caricamento su clic (click-to-load)
    assets/img/*.svg         Immagini PLACEHOLDER locali (in palette)
    assets/fonts/            Poppins ospitato in locale (OFL)
    assets/icons/            Icone PWA
    manifest.json, robots.txt, sitemap.xml

## Contenuti delle sezioni

- **Home**: presentazione della Dott.ssa Colantoni (+ pulsante "Chi e dove
  siamo"), "Cosa facciamo", "Aree di intervento" (+ link a Terapie), ultimi
  post Instagram, "Cosa dicono di noi" (recensioni).
- **Terapie**: le 4 aree di intervento, ognuna con link alla pagina dedicata.
- **Chi e dove siamo**: presentazione in evidenza + pulsante curriculum,
  collaboratrici, partner e visite specialistiche, foto dello studio,
  "Dove siamo" (mappa, indirizzo, telefono, email, WhatsApp).
- **Footer** (tutte le pagine): telefono, indirizzo, email, social, link
  rapidi alle 3 sezioni principali.

## Da personalizzare prima di pubblicare

I punti seguenti sono segnalati come `PLACEHOLDER` nei commenti del codice:

1. **Testi**: biografie, "Cosa facciamo", descrizioni delle terapie, testi di
   approfondimento nelle pagine di dettaglio, curriculum, recensioni.
2. **Email**: ovunque compare `info@studiocolantoni.it` — è inventata.
3. **Immagini**: i file in `assets/img/*.svg` sono placeholder. Sostituiscili
   con foto reali (mantieni gli stessi nomi file, oppure aggiorna i `src`).
4. **Dominio**: sostituisci `IL-TUO-DOMINIO.it` in tutte le pagine
   (canonical + og:url), in `robots.txt` e in `sitemap.xml`.
5. **JSON-LD** in `index.html`: verifica i dati dell'attività locale.
6. **Recensioni**: pubblica testimonianze reali solo con il consenso.

Dati reali già inseriti (ripresi dal progetto originale): telefono, indirizzo,
profili Instagram/Facebook, link WhatsApp, coordinate della mappa.

## Scelte su privacy / terze parti

Il sito è costruito per **non fare richieste a domini terzi** al caricamento:

- **Font Poppins**: ospitato in locale (niente Google Fonts).
- **Icone**: SVG inline (niente font-icona da CDN).
- **Immagini placeholder**: SVG locali (niente `picsum.photos` o simili).
- **Instagram**: il feed passa dal tuo Cloudflare Worker; le immagini non
  vengono caricate direttamente dai server di Meta (se il Worker le proxa —
  vedi il commento in `assets/js/instagram.js`).
- **Mappa**: caricata da Google Maps **solo dopo un clic** dell'utente. Fino
  a quel momento non parte nessuna richiesta a Google. Il clic vale come
  consenso (vedi `assets/js/map.js`).

Conseguenza pratica: nessun cookie di terze parti impostato di default, quindi
niente cookie banner con blocco preventivo. Resta comunque necessaria
un'informativa privacy (`privacy.html`, da completare). Per uno studio
sanitario è consigliabile far validare i testi a un legale.

## Provarlo in locale

Serve un server locale (le icone SVG inline e il font funzionano anche da
`file://`, ma un server evita sorprese):

    python3 -m http.server 8000
    # apri http://localhost:8000

## Nota sulla navigazione

Le tre sezioni sono tre documenti separati (URL reali e indicizzabili). Lo
stato attivo nella navbar è già corretto al primo frame di ogni pagina; il
cambio pagina usa una dissolvenza (View Transitions API) dove supportata,
altrimenti la pagina cambia senza animazione. Vedi i commenti in `style.css`.
