import 'package:flutter/cupertino.dart';

class Ability {
  final String name;
  final String brief;
  final List<String> points;
  final String? url;

  const Ability({
    required this.name,
    required this.brief,
    this.points = const [],
    this.url,
  });
}

enum TechnologyEnum {
  springTechnology,
  dockerTechnology,
  kubernetesTechnology,
  gitTechnology,
  nativeAndroidTechnology,
  flutterTechnology,
  riveTechnology,
  adobeIllustratorTechnology,
  postgresTechnology,
  mysqlTechnology,
  mongoDbTechnology,
  visualParadigmTechnology,
}

class Technologies {
  final String name;
  final String brief;
  final String url;
  final TechnologyEnum technologyEnum;
  final DateTime startDate;
  final List<Ability> abilities;

  const Technologies({
    required this.name,
    required this.brief,
    required this.startDate,
    required this.technologyEnum,
    required this.url,
    this.abilities = const [],
  });

}

class SkillBoard {
  final String name;
  final String brief;
  final SkillsEnum skillsEnum;
  final List<TechnologyEnum> technologies;

  const SkillBoard({
    required this.name,
    required this.brief,
    required this.skillsEnum,
    this.technologies = const [],
  });
}

class Project {
  final ProjectEnum projectEnum;
  final String name;
  final String about;
  final String url;
  final List<TechnologyEnum> stack;

  const Project({
    required this.projectEnum,
    required this.name,
    required this.about,
    required this.url,
    this.stack = const [],
  });
}

class Event {
  final String name;
  final String about;
  final String content;
  final DateTime date;

  const Event({
    required this.name,
    required this.about,
    required this.content,
    required this.date,
  });
}

enum PubPackage {
  spinnerDatePicker,
  lruMemoryCache;
}

enum SkillsEnum {
  backendDevelopment,
  devOps,
  mobileDevelopment,
  vectorGraphics,
  databaseAdministration,
  umlVisualization
}

enum RiveArtEnum {
  tod,
  anger,
  sadness,
  surprise,
  happiness,
  fear,
  disgust,
  contempt
}
enum ProjectEnum {
  tod,
}

class PubDevPackage {
  final String name;
  final String about;
  final String url;
  final PubPackage package;

  const PubDevPackage({
    required this.name,
    required this.about,
    required this.url,
    required this.package,
  });
}

class RiveArt {
  final String name;
  final String description;
  final String animation;
  final String asset;

  const RiveArt({
    required this.name,
    required this.description,
    required this.animation,
    required this.asset,
  });
}