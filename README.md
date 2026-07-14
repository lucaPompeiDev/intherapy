# Serena Studio — Sito Vetrina Flutter

Sito vetrina realizzato in Flutter (funziona su **Flutter Web**, e con gli
stessi widget anche su mobile/desktop nativo) per uno studio di terapie.

## Struttura

- **Home** — hero con foto tondeggiante, punti di forza, anteprima Team e Terapie
- **Team** — griglia di card con foto circolari e bio dei professionisti
- **Terapie** — griglia di card con foto e descrizione dei trattamenti

## Design

- Colori: bianco, `RGB(153, 85, 101)` (rosa antico) e `RGB(248, 230, 164)` (crema)
  — vedi `lib/theme/app_theme.dart`
- Elementi tondeggianti ovunque (bottoni, card, badge)
- Foto racchiuse in una cornice con lo stesso raggio dei bordi
  (`lib/widgets/rounded_photo.dart`)
- Layout responsive: la struttura (navbar, hero, griglie, footer) resta
  identica su mobile e desktop, cambiano solo colonne/spaziature e il menu
  (pillole orizzontali su desktop, Drawer su mobile) — vedi
  `lib/widgets/responsive.dart`

Le foto sono placeholder da `picsum.photos` (richiedono connessione
internet). Per usare immagini reali:
1. Copia i file in `assets/images/`
2. Dichiara la cartella in `pubspec.yaml` sotto `flutter: assets:`
3. Passa `assetPath: 'assets/images/nome.jpg'` a `RoundedPhoto`

## Sezione Instagram (Home)

La Home mostra una griglia con gli ultimi post Instagram, caricati tramite
un Cloudflare Worker che fa da proxy verso la Instagram Graph API (vedi
cartella separata `instagram-worker/` per il codice e le istruzioni di
deploy).

Prima di eseguire il sito, in `lib/pages/home_page.dart` sostituisci:
- `workerBaseUrl` con l'URL del tuo Worker deployato
- `instagramProfileUrl` con il link al tuo profilo Instagram reale

Se il Worker non è ancora pronto, la sezione mostra automaticamente uno
stato di errore con un pulsante "Riprova", senza bloccare il resto del sito.

## Come eseguirlo

```bash
flutter pub get
flutter run -d chrome      # per il web
# oppure
flutter run                # su un emulatore/dispositivo mobile
```

## Build per il web

```bash
flutter build web
```

I file pronti per il deploy si troveranno in `build/web/`.
