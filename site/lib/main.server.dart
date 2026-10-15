/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed during pre-rendering, so every page is shipped as static HTML.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import 'app.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.server.options.dart';

void main() {
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  runApp(Document(
    title: 'Bruce Omukoko | Portfolio',
    lang: 'en',
    meta: {
      'description': 'Bruce Omukoko, Flutter and backend developer. Portfolio, skills, publications and contact.',
      'theme-color': '#25292D',
    },
    head: [
      link(rel: 'icon', type: 'image/png', href: '/favicon.png'),
      link(rel: 'preload', href: '/fonts/Inter-400.woff2', as: 'font', type: 'font/woff2', attributes: {'crossorigin': ''}),
      link(rel: 'preload', href: '/fonts/Inter-700.woff2', as: 'font', type: 'font/woff2', attributes: {'crossorigin': ''}),
      link(rel: 'stylesheet', href: '/styles.css'),
      // Lets the stylesheet hide scroll-reveal content only when main.js will be there to show it again.
      script(content: "document.documentElement.classList.add('js')"),
      script(src: '/main.js', defer: true),
    ],
    body: App(),
  ));
}
