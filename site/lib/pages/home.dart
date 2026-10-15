import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/icons.dart';
import '../components/site_header.dart';
import '../components/tech_cover.dart';
import '../components/tech_dialog.dart';
import '../data/models.dart';
import '../data/publication_repository.dart';
import '../data/skill_repository.dart';
import '../data/technology_repository.dart';
import '../utils.dart';

const _backendResume =
    'https://github.com/bruc3balo/bruc3balo.github.io/releases/download/backend/BruceOmukokoBackendResume.pdf';
const _flutterResume =
    'https://github.com/bruc3balo/bruc3balo.github.io/releases/download/flutter/BruceOmukokoFlutterDeveloper.pdf';
const _email = 'bruceaomukoko@gmail.com';

const _aboutMeSynopsis =
    "Software developer, chilling out in Nairobi who's always up for a good problem solving challenge one line of code at a time.";
const _whatIDoSynopsis =
    'When I’m not deep in thought, you can find me gaming, getting rough and tumble on the rugby field, or just hanging out with friends. Life’s too short not to enjoy a good game and some great company. So yeah, that’s me, always looking for the next challenge and bringing creative flair to everything I do.';

const _contactSubjects = ['Consult', 'Job', 'Contract', 'Other', 'Feedback'];

class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    final skills = SkillRepositoryImpl().allSkills;
    final technologies = TechnologyRepositoryImpl();
    final rives = PublicationRepositoryImpl().allRiveArts;

    return Component.fragment([
      const SiteHeader(),
      main_([
        _about(),
        _skills(skills, technologies),
        _publications(rives),
        _contact(),
      ]),
      for (final s in skills)
        for (final t in s.technologies) TechDialog(technologies.getTechnology(t)),
      _contactDialog(),
    ]);
  }

  Component _about() {
    return section(id: 'about', classes: 'about', [
      div(classes: 'hero', [
        div(classes: 'hero-text', [
          img(classes: 'doodle flash', src: '/assets/flash.svg', alt: ''),
          h1([
            .text("Hey There, I'm "),
            span(classes: 'accent', [.text('Bruce')]),
            strong([.text(' Omukoko')]),
          ]),
          img(classes: 'doodle sign', src: '/assets/sign.svg', alt: ''),
          p(classes: 'lead', [.text(_aboutMeSynopsis)]),
          img(classes: 'doodle smile', src: '/assets/smile.svg', alt: ''),
          div(classes: 'actions', [
            a(href: '#contact', classes: 'btn btn-primary', [.text("Let's Work")]),
            a(href: '#skills', classes: 'btn btn-outline', [.text('More')]),
          ]),
          a(href: '#more', classes: 'scroll-down', [
            span(classes: 'mouse', []),
            .text('Scroll down'),
          ]),
        ]),
        div(classes: 'hero-photo', [
          img(src: '/assets/brucy.webp', alt: 'Bruce Omukoko', width: 426, height: 449, attributes: {'fetchpriority': 'high'}),
        ]),
      ]),
      div(id: 'more', classes: 'more', [
        div(classes: 'rugby', [
          img(src: '/assets/bruce_rugby.webp', alt: 'Bruce playing rugby', width: 1400, height: 933, loading: .lazy),
          div(classes: 'thats-me', [
            img(src: '/assets/rugby_arrow.svg', alt: '', loading: .lazy),
            span(classes: 'script', [.text('That is me LOL')]),
          ]),
        ]),
        div(classes: 'more-text', [
          h2(classes: 'accent', [.text('A little more about me')]),
          p(classes: 'lead', [.text(_whatIDoSynopsis)]),
          div(classes: 'resumes', [
            img(classes: 'doodle', src: '/assets/flash.svg', alt: '', loading: .lazy),
            a(href: _backendResume, target: .blank, classes: 'btn btn-resume backend', [
              icon('code'),
              .text('Backend Resume'),
            ]),
            a(href: _flutterResume, target: .blank, classes: 'btn btn-resume flutter', [
              icon('phone'),
              icon('desktop'),
              .text('Flutter Resume'),
            ]),
            img(classes: 'doodle flipped', src: '/assets/flash.svg', alt: '', loading: .lazy),
          ]),
        ]),
      ]),
    ]);
  }

  Component _skills(List<SkillBoard> skills, TechnologyRepository technologies) {
    return section(id: 'skills', classes: 'skills', [
      div(classes: 'skills-title', [
        a(href: '/playground', classes: 'skills-link', [
          h2(classes: 'accent', [.text('Skills')]),
          icon('ads_click', classes: 'pulse'),
        ]),
        div(classes: 'psst', [
          span(classes: 'script', [.text('Psst press here')]),
          img(src: '/assets/skills_arrow.svg', alt: '', loading: .lazy),
        ]),
      ]),
      div(classes: 'tech-grid', [
        for (final s in skills)
          for (final t in s.technologies)
            _techTile(technologies.getTechnology(t)),
      ]),
    ]);
  }

  Component _techTile(Technologies t) {
    return button(classes: 'tech-tile', attributes: {'data-open': techId(t.technologyEnum)}, [
      span(classes: 'tile-art', [
        TechCover(t.technologyEnum),
        img(classes: 'ring', src: '/assets/skills_hover.svg', alt: '', loading: .lazy),
      ]),
      span(classes: 'tile-name', [.text(t.name)]),
      span(classes: 'tile-xp xp', attributes: {'data-start': isoDate(t.startDate)}, [.text(experience(t.startDate))]),
    ]);
  }

  Component _publications(List<RiveArt> rives) {
    final centre = rives.first;
    final orbit = rives.sublist(1);
    return section(id: 'publications', classes: 'publications', [
      h2(classes: 'accent', [.text('Publications')]),
      div(classes: 'rive-menu', attributes: {'style': '--count: ${orbit.length}'}, [
        for (final (i, r) in orbit.indexed)
          div(classes: 'rive-item', attributes: {'style': '--i: $i', 'title': r.name}, [
            canvas(r),
          ]),
        button(classes: 'rive-centre', attributes: {'aria-label': 'Show Rive animations', 'title': centre.name}, [
          canvas(centre),
        ]),
      ]),
    ]);
  }

  Component canvas(RiveArt r) {
    return Component.element(
      tag: 'canvas',
      attributes: {'data-rive': '/${r.asset.replaceFirst('bruc3balo/', '')}', 'width': '300', 'height': '300'},
      children: const [],
    );
  }

  Component _contact() {
    return section(id: 'contact', classes: 'contact', [
      h2(classes: 'accent', [.text('Contact Me')]),
      button(classes: 'btn btn-outline btn-email', attributes: {'data-open': 'contact-dialog'}, [
        icon('email'),
        .text('Send me an email'),
      ]),
    ]);
  }

  Component _contactDialog() {
    return dialog(id: 'contact-dialog', classes: 'contact-dialog', [
      p([.text('What would you like to discuss about?')]),
      h3([.text('Subject')]),
      div(classes: 'subjects', [
        for (final subject in _contactSubjects)
          a(
            href:
                'mailto:$_email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent('Bruce,\n\n\n\n\nRegards')}',
            classes: 'btn btn-outline',
            [.text(subject)],
          ),
      ]),
      button(classes: 'btn btn-close', attributes: {'data-close': ''}, [.text('Never mind')]),
    ]);
  }
}
