import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/models.dart';
import '../utils.dart';

class TechCover extends StatelessComponent {
  const TechCover(this.technology, {super.key});

  final TechnologyEnum technology;

  @override
  Component build(BuildContext context) {
    final c = cover(technology);
    if (c.tint case final tint?) {
      return span(
        classes: 'cover tinted',
        styles: Styles(raw: {'--mask': 'url(${c.src})', 'background-color': tint}),
        attributes: {'role': 'img'},
        [],
      );
    }
    return img(classes: 'cover', src: c.src, alt: '', loading: .lazy);
  }
}
