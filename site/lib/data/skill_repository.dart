import 'models.dart';

abstract class SkillRepository {
  SkillBoard getSkill(SkillsEnum skillEnum);

  List<SkillBoard> get allSkills;
}

class SkillRepositoryImpl extends SkillRepository {
  SkillBoard get _backendDevelopment => const SkillBoard(
        name: 'Backend Development',
        brief:
            'I design and build backend systems that stay fast and reliable under real load. Security is built in from the start, with authentication, access control and careful handling of sensitive data.',
        skillsEnum: SkillsEnum.backendDevelopment,
        technologies: [
          TechnologyEnum.springTechnology,
        ],
      );

  SkillBoard get _devOps => const SkillBoard(
        name: 'DevOps',
        brief:
            "I set up and run the infrastructure my services live on, aiming to keep them available and stable. I automate builds and deployments with GitHub Actions, GitLab CI and Jenkins so releases ship with little or no downtime. I keep traffic between services encrypted and lock down who can reach what. I monitor what's running so problems are caught before users notice them.",
        skillsEnum: SkillsEnum.devOps,
        technologies: [
          TechnologyEnum.dockerTechnology,
          TechnologyEnum.kubernetesTechnology,
          TechnologyEnum.gitTechnology,
          TechnologyEnum.ciCdTechnology,
        ],
      );

  SkillBoard get _mobileDevelopment => const SkillBoard(
        name: 'Mobile Development',
        brief:
            "I build mobile apps in Flutter for Android and iOS, and in native Android with Kotlin and Java when an app needs to go deeper into the platform.",
        skillsEnum: SkillsEnum.mobileDevelopment,
        technologies: [
          TechnologyEnum.nativeAndroidTechnology,
          TechnologyEnum.flutterTechnology,
        ],
      );

  SkillBoard get _vectorGraphics => const SkillBoard(
        name: 'Vector Graphics',
        brief:
            'I draw characters and icons in Adobe Illustrator, then bring them to life as interactive animations in Rive, like the faces on this site.',
        skillsEnum: SkillsEnum.vectorGraphics,
        technologies: [
          TechnologyEnum.riveTechnology,
          TechnologyEnum.adobeIllustratorTechnology,
        ],
      );

  SkillBoard get _databaseAdministration => const SkillBoard(
        name: 'Database administrations',
        brief:
            "Proficient in database administration, encompassing tasks such as database installation, configuration, performance tuning, backup and recovery, security management, and troubleshooting, ensuring optimal functionality, reliability, and security of database systems.",
        skillsEnum: SkillsEnum.databaseAdministration,
        technologies: [
          TechnologyEnum.postgresTechnology,
          TechnologyEnum.mysqlTechnology,
          TechnologyEnum.mongoDbTechnology,
        ],
      );

  SkillBoard get _umlVisualization => const SkillBoard(
        name: 'UML visualization',
        brief:
            "Proficient in UML (Unified Modeling Language) visualization, utilizing industry-standard diagrams and notations to depict system architectures, design patterns, and software processes, facilitating clear communication and collaboration among project stakeholders.",
        skillsEnum: SkillsEnum.umlVisualization,
        technologies: [
          TechnologyEnum.visualParadigmTechnology,
        ],
      );

  @override
  List<SkillBoard> get allSkills => SkillsEnum.values.map(getSkill).toList();

  @override
  SkillBoard getSkill(SkillsEnum skillEnum) {
    return switch (skillEnum) {
      SkillsEnum.backendDevelopment => _backendDevelopment,
      SkillsEnum.devOps => _devOps,
      SkillsEnum.mobileDevelopment => _mobileDevelopment,
      SkillsEnum.vectorGraphics => _vectorGraphics,
      SkillsEnum.databaseAdministration => _databaseAdministration,
      SkillsEnum.umlVisualization => _umlVisualization,
    };
  }
}
