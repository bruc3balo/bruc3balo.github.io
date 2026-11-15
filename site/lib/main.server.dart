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
    // Link previews (LinkedIn, Slack, WhatsApp) show a title, summary and photo instead of a bare URL.
    head: [
      meta(attributes: {'property': 'og:title', 'content': 'Bruce Omukoko | Backend & Flutter developer'}),
      meta(attributes: {'property': 'og:description', 'content': 'Spring Boot backends, Flutter apps and Rive animations. Portfolio, skills and contact.'}),
      meta(attributes: {'property': 'og:image', 'content': 'https://bruc3balo.github.io/assets/og.jpg'}),
      meta(attributes: {'property': 'og:url', 'content': 'https://bruc3balo.github.io/'}),
      meta(attributes: {'property': 'og:type', 'content': 'website'}),
      meta(name: 'twitter:card', content: 'summary_large_image'),
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
