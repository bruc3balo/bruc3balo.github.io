import 'package:bruce_omukoko_portfolio/data/models/models.dart';

abstract class ProjectRepository {
  Project getProject(ProjectEnum projectEnum);

  List<Project> get allProjects;
}

class ProjectRepositoryImpl extends ProjectRepository {

  Project get _tod => const Project(
    name: 'Truth or Drink',
    about:
    "Truth or Drink is a drinking game where players take turns asking each other questions. If someone doesn't want to answer, they take a drink instead. It's a fun way to get to know each other better while enjoying some drinks.",
    url: 'https://truthordrink-kg.web.app',
    projectEnum: ProjectEnum.tod,
    stack: [
      TechnologyEnum.springTechnology,
      TechnologyEnum.flutterTechnology,
      TechnologyEnum.mongoDbTechnology,
      TechnologyEnum.riveTechnology,
      TechnologyEnum.kubernetesTechnology,
      TechnologyEnum.dockerTechnology,
      TechnologyEnum.visualParadigmTechnology,
    ],
  );

  @override
  List<Project> get allProjects => ProjectEnum.values.map(getProject).toList();

  @override
  Project getProject(ProjectEnum projectEnum) {
    return switch (projectEnum) {
      ProjectEnum.tod => _tod,
    };
  }
}
