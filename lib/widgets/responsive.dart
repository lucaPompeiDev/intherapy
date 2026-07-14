import 'package:flutter/widgets.dart';

/// Breakpoint centralizzati per mantenere la stessa struttura
/// su schermi diversi, adattando solo il layout (colonne, nav, spaziature).
class Breakpoints {
  Breakpoints._();

  static const double mobile = 700;
  static const double tablet = 1000;
  static const double desktop = 1280;
}

bool isMobile(BuildContext context) =>
    MediaQuery.of(context).size.width < Breakpoints.mobile;

bool isTablet(BuildContext context) {
  final w = MediaQuery.of(context).size.width;
  return w >= Breakpoints.mobile && w < Breakpoints.tablet;
}

bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width >= Breakpoints.tablet;

/// Numero di colonne per le griglie (team / terapie) in base alla larghezza.
int gridColumns(BuildContext context) {
  final w = MediaQuery.of(context).size.width;
  if (w < Breakpoints.mobile) return 1;
  if (w < Breakpoints.tablet) return 2;
  if (w < Breakpoints.desktop) return 3;
  return 4;
}

/// Padding orizzontale coerente in tutte le pagine.
double pageHorizontalPadding(BuildContext context) {
  final w = MediaQuery.of(context).size.width;
  if (w < Breakpoints.mobile) return 20;
  if (w < Breakpoints.tablet) return 40;
  return 80;
}

/// Aspect ratio delle card in base al numero di colonne.
/// Più colonne = celle più strette = servono celle più alte (ratio più basso)
/// perché il testo abbia spazio per andare su più righe senza essere tagliato.
double cardAspectRatio(int columns, {required double single}) {
  switch (columns) {
    case 1:
      return single;
    case 2:
      return single - 0.15;
    case 3:
      return single - 0.28;
    default:
      return single - 0.33;
  }
}
