import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/site_header.dart';
import '../components/tech_cover.dart';
import '../components/tech_dialog.dart';
import '../data/skill_repository.dart';
import '../data/technology_repository.dart';
import '../utils.dart';

/// The ways the playground can behave; playground.js animates whichever one is picked.
const _modes = [
  (id: 'bubbles', label: 'Bubbles', hint: 'Bigger bubbles are tools I have used longer. Drag one and fling it.'),
  (id: 'magnets', label: 'Magnets', hint: 'Pick a skill to pull its tools together.'),
  (id: 'stars', label: 'Constellations', hint: 'Hover or tap a star to light up its skill.'),
  (id: 'pit', label: 'Ball pit', hint: 'Push them around with your cursor, or tilt your phone.'),
  (id: 'breakout', label: 'Breakout', hint: 'Move to steer the paddle and knock every skill loose.'),
];

/// Technologies laid out as physics bodies in an arena, with a selector for how they move.
class Playground extends StatelessComponent {
  const Playground({super.key});

  @override
  Component build(BuildContext context) {
    final skills = SkillRepositoryImpl().allSkills;
    final technologies = TechnologyRepositoryImpl();

    return Component.fragment([
      const SiteHeader(playground: true),
      main_(classes: 'playground', attributes: {'data-mode': _modes.first.id}, [
        div(classes: 'pg-bar', [
          div(classes: 'pg-modes', attributes: {'role': 'group', 'aria-label': 'Playground mode'}, [
            for (final m in _modes)
              button(
                classes: 'pg-mode',
                attributes: {'data-mode': m.id, 'aria-pressed': '${m == _modes.first}'},
                [.text(m.label)],
              ),
          ]),
          for (final m in _modes) p(classes: 'pg-hint', attributes: {'data-for': m.id}, [.text(m.hint)]),
          div(classes: 'pg-chips', attributes: {'data-for': 'magnets'}, [
            for (final (i, s) in skills.indexed)
              button(
                classes: 'pg-chip',
                attributes: {'data-skill': '$i', 'aria-pressed': 'false', 'style': '--skill: ${skillColor(s.skillsEnum)}'},
                [.text(s.name)],
              ),
          ]),
          div(classes: 'pg-actions', attributes: {'data-for': 'pit'}, [
            button(classes: 'btn btn-outline pg-shake', [.text('Shake')]),
          ]),
          div(classes: 'pg-actions', attributes: {'data-for': 'breakout'}, [
            span(classes: 'pg-score', [.text('0 / ${skills.fold(0, (count, skill) => count + skill.technologies.length)}')]),
            button(classes: 'btn btn-outline pg-reset', [.text('Reset')]),
          ]),
        ]),
        div(classes: 'pg-arena', [
          svg(classes: 'pg-lines', attributes: {'aria-hidden': 'true'}, []),
          for (final (i, s) in skills.indexed)
            for (final t in s.technologies)
              button(
                classes: 'floater',
                attributes: {
                  'data-open': techId(t),
                  'data-skill': '$i',
                  'data-start': isoDate(technologies.getTechnology(t).startDate),
                  'style': '--skill: ${skillColor(s.skillsEnum)}',
                },
                [
                  TechCover(t),
                  span([.text(technologies.getTechnology(t).name)]),
                ],
              ),
          for (final (i, s) in skills.indexed)
            div(classes: 'pg-brief', attributes: {'data-skill': '$i', 'style': '--skill: ${skillColor(s.skillsEnum)}'}, [
              h3([.text(s.name)]),
              p([.text(s.brief)]),
            ]),
          div(classes: 'pg-paddle', attributes: {'aria-hidden': 'true'}, []),
          div(classes: 'pg-ball', attributes: {'aria-hidden': 'true'}, []),
        ]),
      ]),
      for (final s in skills)
        for (final t in s.technologies) TechDialog(technologies.getTechnology(t)),
      script(src: '/playground.js', defer: true),
    ]);
  }
}
