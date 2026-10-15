import 'data/models.dart';

/// Mirrors the Flutter app's experience label. Rendered at build time and refreshed in the browser by main.js.
String experience(DateTime start, [DateTime? now]) {
  final days = (now ?? DateTime.now()).difference(start).inDays;
  if (days < 365) return '$days days experience';
  final years = (days / 365).round();
  return "$years year${years == 1 ? '' : 's'} experience";
}

String isoDate(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

/// Logo for each technology. [tint] recolours single-colour SVGs through a CSS mask.
({String src, String? tint}) cover(TechnologyEnum t) => switch (t) {
  TechnologyEnum.springTechnology => (src: '/assets/spring.svg', tint: null),
  TechnologyEnum.dockerTechnology => (src: '/assets/docker.svg', tint: null),
  TechnologyEnum.kubernetesTechnology => (src: '/assets/kubernets.svg', tint: null),
  TechnologyEnum.gitTechnology => (src: '/assets/git.svg', tint: null),
  TechnologyEnum.ciCdTechnology => (src: '/assets/github-actions.svg', tint: '#2088FF'),
  TechnologyEnum.nativeAndroidTechnology => (src: '/assets/android.svg', tint: '#4CAF50'),
  TechnologyEnum.flutterTechnology => (src: '/assets/flutter.svg', tint: null),
  TechnologyEnum.riveTechnology => (src: '/assets/rive.webp', tint: null),
  TechnologyEnum.adobeIllustratorTechnology => (src: '/assets/adobe-illustrator.svg', tint: null),
  TechnologyEnum.postgresTechnology => (src: '/assets/postgresql.svg', tint: null),
  TechnologyEnum.mysqlTechnology => (src: '/assets/mysql.svg', tint: null),
  TechnologyEnum.mongoDbTechnology => (src: '/assets/mongo.svg', tint: null),
  TechnologyEnum.visualParadigmTechnology => (src: '/assets/visual-paradigm.webp', tint: null),
};

String skillColor(SkillsEnum s) => switch (s) {
  SkillsEnum.backendDevelopment => '#F44336',
  SkillsEnum.devOps => '#607D8B',
  SkillsEnum.mobileDevelopment => '#4CAF50',
  SkillsEnum.vectorGraphics => '#795548',
  SkillsEnum.databaseAdministration => '#FF6E40',
  SkillsEnum.umlVisualization => '#FFFFFF',
};

String techId(TechnologyEnum t) => 'tech-${t.name}';
