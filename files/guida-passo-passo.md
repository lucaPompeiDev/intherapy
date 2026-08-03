# Guida passo-passo: SEO + GEO per il sito dello studio di psicologia

## PARTE 1 - File da aggiungere/modificare nel progetto (codebase)

### 1. Struttura consigliata delle pagine
```
/index.html                  → Homepage
/chi-siamo.html               → Presentazione studio + titolare
/team/nome-cognome-1.html     → Pagina dedicata titolare
/team/nome-cognome-2.html     → Pagina dedicata collaboratrice 1
/team/nome-cognome-3.html     → Pagina dedicata collaboratrice 2
/servizi.html                 → Elenco servizi offerti (o una pagina per servizio)
/faq.html                     → Domande frequenti
/contatti.html                → Indirizzo, mappa, form contatti
/robots.txt
/sitemap.xml
```
Perché pagine separate per ogni professionista: ogni collaboratrice ha probabilmente
specializzazioni diverse (età evolutiva, coppie, ansia...). Query come
"psicologa specializzata in DCA a {{città}}" hanno molte più possibilità di
posizionarsi con una pagina dedicata che con un unico paragrafo nella home.

### 2. File da inserire (vedi allegati)
- `robots.txt` → nella root del sito
- `sitemap.xml` → nella root del sito, aggiornare `<lastmod>` ad ogni modifica
- `head-homepage-example.html` → adattare e inserire nel `<head>` di `index.html`
- `schema-team-example.html` → duplicare per ogni pagina `/team/*.html`
- `faq-example.html` → contenuto per `/faq.html`

### 3. Immagini
- Rinomina i file in modo descrittivo prima di caricarli: `studio-psicologia-milano-sala-attesa.jpg`
  invece di `IMG_0234.jpg`
- Converti in `.webp` (riduce peso senza perdere qualità)
- Aggiungi sempre `width`, `height` e `alt` descrittivo su ogni `<img>`
- Per le foto del team: `alt="{{Nome Cognome}}, psicologa specializzata in {{specialità}}"`

### 4. Worker Instagram
- Verifica che i post recuperati dinamicamente non siano l'unica fonte di informazioni
  importanti (es. se annunci "chiuso per ferie" solo su Instagram, valuta di scriverlo
  anche staticamente nella pagina contatti)
- Aggiungi un `alt` generico o una didascalia ai post embeddati, se possibile

### 5. Performance
- Minifica CSS/JS prima della messa online
- Usa `<script defer src="worker-instagram.js"></script>` per non bloccare il rendering
- Metti in cache le immagini con header appropriati (dipende dal tuo hosting)

---

## PARTE 2 - Attività esterne al codice (da fare una tantum + manutenzione)

### Passo 1: Google Search Console
1. Vai su https://search.google.com/search-console
2. Aggiungi la proprietà con il dominio del sito
3. Verifica la proprietà (via file HTML, tag DNS o Google Analytics)
4. Invia la sitemap: Search Console → Sitemap → incolla `https://www.tuodominio.it/sitemap.xml`
5. Dopo il deploy della nuova codebase, usa "Ispeziona URL" sulle pagine principali
   e clicca "Richiedi indicizzazione"

### Passo 2: Google Business Profile (fondamentale per uno studio locale)
1. Crea/aggiorna il profilo su https://www.google.com/business/
2. Categoria principale: "Psicologo" o "Studio di psicologia"
3. Inserisci indirizzo, orari, telefono IDENTICI a quelli sul sito (coerenza dei dati =
   fiducia per Google e per gli LLM che aggregano informazioni)
4. Carica foto reali dello studio e del team
5. Se possibile, invita i pazienti (con il loro consenso) a lasciare recensioni:
   le recensioni Google sono uno dei fattori più forti per il posizionamento locale

### Passo 3: Coerenza NAP (Name, Address, Phone) ovunque
Verifica che nome studio, indirizzo e telefono siano scritti in modo identico su:
- Sito web
- Google Business Profile
- Pagine social (Instagram, Facebook, LinkedIn)
- Eventuali directory di settore (vedi Passo 4)

### Passo 4: Directory di settore (backlink di qualità + presenza per gli LLM)
Registra lo studio su:
- Albo/Ordine degli Psicologi della regione (spesso ha un elenco pubblico online)
- ProntoProfessionista, MioDottore/Doctolib se applicabile
- Directory locali della città (Pagine Gialle, portali comunali, ecc.)
Questi link aiutano sia il posizionamento Google classico, sia la probabilità che un
LLM trovi informazioni coerenti su più fonti quando "ricostruisce" una risposta.

### Passo 5: Social
- Assicurati che i link `sameAs` nello schema.org puntino ai profili social reali e attivi
- Un profilo Instagram/Facebook aggiornato regolarmente aiuta anche indirettamente
  la SEO (segnali di attività, possibili menzioni/link esterni)

### Passo 6: Monitoraggio continuo
- Dopo 2-4 settimane dal deploy, controlla in Search Console → Rendimento quali query
  portano traffico e quali pagine vengono mostrate
- Controlla in Search Console → Copertura che tutte le pagine siano indicizzate senza errori
- Aggiorna periodicamente contenuti (bio, FAQ, eventuali articoli) e la `lastmod` in sitemap.xml

---

## Checklist riassuntiva

- [ ] robots.txt caricato nella root
- [ ] sitemap.xml caricato nella root e inviato a Search Console
- [ ] Meta title + description unici per ogni pagina
- [ ] Schema MedicalBusiness nella homepage
- [ ] Schema Person in ogni pagina del team
- [ ] Schema FAQPage nella pagina FAQ
- [ ] Tutte le immagini con alt descrittivo, nomi file leggibili, formato webp
- [ ] Sito verificato su Google Search Console
- [ ] Profilo Google Business Profile creato/aggiornato
- [ ] Dati NAP coerenti su sito, Google Business, social
- [ ] Registrazione su almeno 1-2 directory di settore
