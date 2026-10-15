import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/site_header.dart';
import '../components/tech_cover.dart';
import '../components/tech_dialog.dart';
import '../data/skill_repository.dart';
import '../data/technology_repository.dart';
import '../utils.dart';

/// Technologies drift around the page and bounce off the edges; main.js animates them.
class Playground extends StatelessComponent {
  const Playground({super.key});

  @override
  Component build(BuildContext context) {
    final skills = SkillRepositoryImpl().allSkills;
    final technologies = TechnologyRepositoryImpl();

    return Component.fragment([
      const SiteHeader(playground: true),
      main_(classes: 'playground', [
        for (final s in skills)
          for (final t in s.technologies)
            button(
              classes: 'floater',
              attributes: {'data-open': techId(t), 'style': '--skill: ${skillColor(s.skillsEnum)}'},
              [
                TechCover(t),
                span([.text(technologies.getTechnology(t).name)]),
              ],
            ),
      ]),
      for (final s in skills)
        for (final t in s.technologies) TechDialog(technologies.getTechnology(t)),
    ]);
  }
}
