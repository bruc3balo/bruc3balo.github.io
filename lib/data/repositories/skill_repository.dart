import 'package:bruce_omukoko_portfolio/data/models/models.dart';

abstract class SkillRepository {
  SkillBoard getSkill(SkillsEnum skillEnum);

  List<SkillBoard> get allSkills;
}

class SkillRepositoryImpl extends SkillRepository {
  SkillBoard get _backendDevelopment => const SkillBoard(
        name: 'Backend Development',
        brief:
            'As a seasoned backend developer, I specialize in crafting robust architectures and optimizing performance to ensure seamless operation of backend systems. With a keen focus on security, I implement stringent measures to safeguard sensitive data and protect against potential threats. My expertise lies in architecting scalable solutions that deliver high performance and reliability, while prioritizing the integrity and confidentiality of backend systems. I am committed to staying abreast of the latest advancements in backend technologies to continuously enhance system efficiency and resilience.',
        skillsEnum: SkillsEnum.backendDevelopment,
        technologies: [
          TechnologyEnum.springTechnology,
        ],
      );

  SkillBoard get _devOps => const SkillBoard(
        name: 'DevOps',
        brief:
            'As a dedicated DevOps engineer, I specialize in ensuring high availability, stability, and seamless operations of complex environments. With a relentless focus on eliminating downtime, I implement robust strategies and automation techniques to maintain uninterrupted service delivery. My expertise extends to orchestrating secure networking communications between all nodes, implementing encryption protocols, and enforcing stringent access controls to safeguard sensitive data. Through continuous monitoring, optimization, and automation, I strive to create resilient infrastructures that meet the highest standards of reliability and security',
        skillsEnum: SkillsEnum.devOps,
        technologies: [
          TechnologyEnum.dockerTechnology,
          TechnologyEnum.kubernetesTechnology,
          TechnologyEnum.gitTechnology,
        ],
      );

  SkillBoard get _mobileDevelopment => const SkillBoard(
        name: 'Mobile Development',
        brief:
            "Proficient in mobile development, encompassing both Android native and Flutter cross-platform development, with expertise in creating high-quality, user-friendly mobile applications for diverse platforms and devices.",
        skillsEnum: SkillsEnum.mobileDevelopment,
        technologies: [
          TechnologyEnum.nativeAndroidTechnology,
          TechnologyEnum.flutterTechnology,
        ],
      );

  SkillBoard get _vectorGraphics => const SkillBoard(
        name: 'Vector Graphics',
        brief:
            'Proficient in creating vector graphics using Adobe Illustrator and animating them seamlessly using Rive, enhancing visual appeal and interactivity in digital designs.',
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
