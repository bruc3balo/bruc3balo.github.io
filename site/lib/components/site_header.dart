import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class SiteHeader extends StatelessComponent {
  const SiteHeader({this.playground = false, super.key});

  final bool playground;

  static const _sections = ['About', 'Skills', 'Publications', 'Contact'];

  @override
  Component build(BuildContext context) {
    return header(classes: 'site-header', [
      a(href: playground ? '/' : '#about', classes: 'brand', [
        span(classes: 'accent', [.text('Bruce')]),
        span(classes: 'surname', [.text(' Omukoko')]),
      ]),
      if (playground)
        span(classes: 'page-title', [.text('Skills Playground')])
      else
        nav([
          for (final s in _sections)
            a(href: '#${s.toLowerCase()}', attributes: {'data-section': s.toLowerCase()}, [.text(s)]),
        ]),
    ]);
  }
}
