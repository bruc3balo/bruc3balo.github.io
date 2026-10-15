import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/models.dart';
import '../utils.dart';
import 'icons.dart';

/// Native `<dialog>` with a technology's abilities. Abilities that have points expand with `<details>`.
class TechDialog extends StatelessComponent {
  const TechDialog(this.technology, {super.key});

  final Technologies technology;

  @override
  Component build(BuildContext context) {
    return dialog(id: techId(technology.technologyEnum), classes: 'tech-dialog', [
      div(classes: 'tech-dialog-head', [
        h3([.text(technology.name)]),
        p(classes: 'xp', attributes: {'data-start': isoDate(technology.startDate)}, [
          .text(experience(technology.startDate)),
        ]),
        button(classes: 'btn btn-close', attributes: {'data-close': ''}, [.text('Close')]),
      ]),
      ul(classes: 'abilities', [
        for (final a in technology.abilities)
          li([
            if (a.points.isEmpty)
              div(classes: 'ability', [
                strong([.text(a.name)]),
                p([.text(a.brief)]),
              ])
            else
              details([
                summary(classes: 'ability', [
                  strong([.text(a.name)]),
                  p([.text(a.brief)]),
                ]),
                ul(classes: 'points', [
                  for (final point in a.points) li([icon('chevron_right'), span([.text(point)])]),
                ]),
              ]),
          ]),
      ]),
    ]);
  }
}
