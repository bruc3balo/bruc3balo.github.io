import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// Material icon paths, inlined so no icon font has to be downloaded.
const _paths = {
  'ads_click':
      'M11.71 17.99C8.53 17.84 6 15.22 6 12c0-3.31 2.69-6 6-6 3.22 0 5.84 2.53 5.99 5.71l-2.1-.63C15.48 9.31 13.89 8 12 8c-2.21 0-4 1.79-4 4 0 1.89 1.31 3.48 3.08 3.89l.63 2.1zM22 12c0 .3-.01.6-.04.9l-1.97-.59c.01-.1.01-.21.01-.31 0-4.42-3.58-8-8-8s-8 3.58-8 8 3.58 8 8 8c.1 0 .21 0 .31-.01l.59 1.97c-.3.03-.6.04-.9.04-5.52 0-10-4.48-10-10S6.48 2 12 2s10 4.48 10 10zm-3.77 4.26L22 15l-10-3 3 10 1.26-3.77 4.27 4.27 1.98-1.98-4.28-4.26z',
  'code': 'M9.4 16.6L4.8 12l4.6-4.6L8 6l-6 6 6 6 1.4-1.4zm5.2 0l4.6-4.6-4.6-4.6L16 6l6 6-6 6-1.4-1.4z',
  'phone':
      'M16 1H8C6.34 1 5 2.34 5 4v16c0 1.66 1.34 3 3 3h8c1.66 0 3-1.34 3-3V4c0-1.66-1.34-3-3-3zm1 17H7V4h10v14zm-3 3h-4v-1h4v1z',
  'desktop':
      'M21 2H3c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h7l-2 3v1h8v-1l-2-3h7c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 12H3V4h18v10z',
  'email':
      'M22 6c0-1.1-.9-2-2-2H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6zm-2 0l-8 5-8-5h16zm0 12H4V8l8 5 8-5v10z',
  'chevron_right': 'M10 6L8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6z',
};

Component icon(String name, {String? classes}) {
  return RawText(
    '<svg class="icon${classes == null ? '' : ' $classes'}" viewBox="0 0 24 24" width="24" height="24" '
    'aria-hidden="true" fill="currentColor"><path d="${_paths[name]}"/></svg>',
  );
}
