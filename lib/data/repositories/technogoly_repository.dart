import 'package:bruce_omukoko_portfolio/data/models/models.dart';

abstract class TechnologyRepository {

   Technologies getTechnology(TechnologyEnum technologyEnum);
   List<Technologies> get allTechnologies;
}

class TechnologyRepositoryImpl extends TechnologyRepository {

  final Technologies _springTechnology = Technologies(
    name: 'Spring Framework',
    brief: 'Spring is a comprehensive Java framework used to develop high-performance, secure, and scalable backend applications. It simplifies backend development, making it ideal for creating microservices, APIs, and enterprise systems.',
    url: 'https://spring.io/projects/spring-framework',
    startDate: DateTime(2021, DateTime.august),
    technologyEnum: TechnologyEnum.springTechnology,
    abilities: [
      const Ability(
        name: 'USSD Applications',
        brief:
        "Designed dynamic USSD menus with advanced session tracking, enabling interactive mobile services accessible without internet.",
      ),
      const Ability(
        name: 'Spring Data',
        brief:
        'Proficient in efficient database operations using Spring Data and Hibernate, optimizing data access layers for seamless performance.',
        points: [
          "Designed data models and implemented entities for database interaction.",
          "Developed versatile queries using JPA Specifications and JPQL.",
          "Optimized database performance with paging, indexing, and constraints.",
          "Streamlined schema management with Hibernate ORM.",
        ],
      ),
      const Ability(
        name: 'Spring Security',
        brief:
        'Secured applications using advanced authentication and authorization mechanisms, enhancing user experience and data protection.',
        points: [
          "Implemented JWT-based authentication and multi-factor authorization.",
          "Controlled endpoint and method-level access for sensitive data.",
          "Enabled secure multi-tenant systems based on user roles.",
        ],
      ),
      const Ability(
        name: 'Microservices',
        brief:
        'Built resilient microservices using Spring Boot, messaging queues, and API gateways to ensure seamless inter-service communication.',
        points: [
          "Integrated microservices using messaging systems for asynchronous operations.",
          "Externalized configurations for dynamic and flexible deployments.",
          "Designed batch processing systems for high-volume tasks.",
        ],
      ),
    ],
  );

  final Technologies _dockerTechnology = Technologies(
    name: 'Docker',
    brief:
    "Docker revolutionizes application deployment by packaging software and dependencies into portable containers for consistent environments.",
    url: 'https://www.docker.com',
    technologyEnum: TechnologyEnum.dockerTechnology,
    startDate: DateTime(2022, DateTime.august),
    abilities: [
      const Ability(
        name: 'Dockerfile Authoring',
        brief:
        "Authored Dockerfiles for seamless containerization, enabling consistent application deployment across environments.",
        points: [
          "Created lightweight images using multistage builds and slim base images.",
          "Externalized configurations for flexibility and maintainability.",
        ],
      ),
      const Ability(
        name: 'Private Registry Management',
        brief:
        'Set up private Docker registries to secure container images and control access for team collaboration.',
        url:
        'https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-22-04',
        points: [
          "Configured basic authentication for registry security.",
          "Managed private images with controlled access for internal use.",
        ],
      ),
      const Ability(
        name: 'Testing with Docker Compose',
        brief:
        "Streamlined testing environments using Docker Compose for multi-service orchestration.",
        url: 'https://docs.docker.com/compose',
        points: [
          "Created modular Compose files for isolated service testing.",
          "Extended and reused Compose configurations for efficient testing setups.",
        ],
      ),
    ],
  );

  final Technologies _kubernetesTechnology = Technologies(
    name: 'Kubernetes',
    brief:
    "Kubernetes automates deployment, scaling, and management of containerized applications, ensuring optimal resource utilization.",
    url: 'https://kubernetes.io',
    technologyEnum: TechnologyEnum.kubernetesTechnology,
    startDate: DateTime(2024, DateTime.february),
    abilities: const [
      Ability(
        name: 'Deployment and Scaling',
        brief:
        "Orchestrated deployments with auto-scaling for dynamic workloads.",
        points: [
          "Implemented replica sets for scaling.",
          "Enabled auto-scaling based on CPU, memory, and request metrics.",
        ],
      ),
      Ability(
        name: 'Networking and Traffic Management',
        brief:
        "Managed seamless network communication and traffic routing within Kubernetes clusters.",
        points: [
          "Exposed services internally and externally with Nginx ingress.",
          "Provisioned load balancers for distributed traffic handling.",
        ],
      ),
      Ability(
        name: 'Configuration and Secrets Management',
        brief:
        "Centralized management of application secrets and configurations for enhanced security.",
        points: [
          "Utilized ConfigMaps for dynamic application settings.",
          "Stored sensitive data securely in encrypted Git repositories.",
        ],
      ),
      Ability(
        name: 'Monitoring and Health Checks',
        brief:
        "Ensured application availability with readiness and liveness probes.",
        points: [
          "Configured HTTP and TCP probes to monitor pod health and traffic readiness.",
        ],
      ),
    ],
  );

  final Technologies _gitTechnology = Technologies(
    name: 'Git',
    brief:
    "Git is a version control system that enables collaborative development, efficient tracking of changes, and robust branching workflows for codebases.",
    startDate: DateTime(2017, DateTime.august),
    technologyEnum: TechnologyEnum.gitTechnology,
    url: 'https://github.com',
    abilities: const [
      Ability(
        name: 'Repository Management',
        brief:
        "Expertise in managing Git repositories to ensure clean and structured version control.",
        points: [
          "Created and cloned repositories for efficient collaboration.",
          "Managed updates to both local and remote repositories seamlessly.",
        ],
      ),
      Ability(
        name: 'Branch Management',
        brief:
        "Proficient in handling branches for parallel development and streamlined code integration.",
        points: [
          "Merged branches for integrating features and bug fixes.",
          "Performed rebasing to maintain a linear history.",
          "Recovered and fast-forwarded branches for consistent updates.",
        ],
      ),
      Ability(
        name: 'Commit Management',
        brief:
        "Skillful in commit handling to maintain a reliable and traceable project history.",
        points: [
          "Checked out specific commits to debug or review changes.",
          "Cherry-picked commits for selective integration.",
          "Created new branches from existing commits for feature isolation.",
        ],
      ),
    ],
  );

  final Technologies _nativeAndroidTechnology = Technologies(
    name: 'Native Android',
    brief:
    "With over 5 years of experience, I specialize in creating robust Android applications using Java, XML layouts, and the MVVM architecture, ensuring scalability, maintainability, and user satisfaction.",
    url: 'https://developer.android.com',
    technologyEnum: TechnologyEnum.nativeAndroidTechnology,
    startDate: DateTime(2020, DateTime.may),
    abilities: const [
      Ability(
        name: 'Android SDK',
        brief:
        "Comprehensive knowledge of Android SDK components, enabling efficient app development and lifecycle management.",
        points: [
          "Designed interactive user interfaces using activities and fragments.",
          "Integrated Room database for robust local storage.",
          "Utilized LiveData and ViewModel for reactive programming.",
        ],
      ),
      Ability(
        name: 'Java Logic Programming',
        brief:
        "Developed clean and efficient backend logic using Java 8/11 features.",
        points: [
          "Implemented background processing for smooth user experiences.",
          "Designed robust error-handling mechanisms for high reliability.",
        ],
      ),
      Ability(
        name: 'XML Layouts',
        brief:
        "Designed visually appealing UI components following Material Design principles.",
        points: [
          "Modularized layouts for reusable components.",
          "Leveraged DataBinding to reduce boilerplate code and enhance readability.",
        ],
      ),
    ],
  );

  final Technologies _flutterTechnology = Technologies(
    name: 'Flutter',
    brief:
    "Flutter is a modern cross-platform framework that enables rapid development of high-performance, visually stunning mobile applications.",
    url: 'https://flutter.dev',
    technologyEnum: TechnologyEnum.flutterTechnology,
    startDate: DateTime(2021, DateTime.january),
    abilities: const [
      Ability(
        name: 'Cross-Platform Development',
        brief:
        "Build mobile applications for iOS and Android from a single codebase using Flutter and Dart.",
        points: [
          "Developed responsive UIs with Flutter's flexible widgets.",
          "Integrated RESTful APIs for real-time data synchronization.",
        ],
      ),
      Ability(
        name: 'State Management',
        brief:
        "Efficiently manage app state using providers, Riverpod, and Bloc architectures.",
        points: [
          "Implemented complex navigation flows with dynamic state handling.",
          "Optimized performance by reducing unnecessary widget rebuilds.",
        ],
      ),
      Ability(
        name: 'Firebase Integration',
        brief:
        "Seamlessly integrated Firebase services to enhance app functionality.",
        points: [
          "Implemented Firebase Authentication for secure login flows.",
          "Utilized Firestore for real-time data storage and retrieval.",
        ],
      ),
    ],
  );

  final Technologies _riveTechnology = Technologies(
    name: 'Rive',
    brief:
    "Rive is a powerful design and animation tool used for creating interactive vector animations and illustrations for various digital platforms.",
    startDate: DateTime(2022, DateTime.march),
    technologyEnum: TechnologyEnum.riveTechnology,
    url: 'https://rive.app',
    abilities: const [
      Ability(
        name: 'Animating vectors',
        brief:
        'Skilled in animating vector graphics, enhancing visual appeal and interactivity in digital designs for dynamic user experiences.',
      ),
      Ability(
        name: 'State animations',
        brief:
        "Skilled in implementing state animations using state machines, effectively managing and controlling application states to create dynamic and responsive user interfaces.",
      ),
    ],
  );

  final Technologies _adobeIllustratorTechnology = Technologies(
    name: 'Adobe illustrator',
    brief:
    "Adobe Illustrator is a versatile vector graphics editor used for creating scalable illustrations, logos, icons, and other graphical elements for print, web, and multimedia projects.",
    startDate: DateTime(2022, DateTime.march),
    technologyEnum: TechnologyEnum.adobeIllustratorTechnology,
    url: 'https://www.adobe.com/products/illustrator.html',
    abilities: const [
      Ability(
        name: 'Character modelling',
        brief:
        "Proficient in character drawing using Adobe Illustrator, leveraging its powerful vector-based tools to create detailed and expressive characters for various digital media and design projects.",
        points: [
          "Utilized vector paths for precision in character creation.",
          "Incorporated layers and grouping for complex designs.",
          "Adapted designs for both print and digital platforms.",
        ],
      ),
    ],
  );

  final Technologies _postgresTechnology = Technologies(
    name: 'PostgreSQL',
    brief:
    "PostgreSQL is a powerful, open-source relational database known for its extensibility, reliability, and performance.",
    url: 'https://www.postgresql.org',
    technologyEnum: TechnologyEnum.postgresTechnology,
    startDate: DateTime(2020, DateTime.july),
    abilities: const [
      Ability(
        name: 'Database Design',
        brief:
        "Proficient in designing normalized database schemas for scalable and efficient data storage.",
        points: [
          "Created relational schemas with primary and foreign keys for data integrity.",
          "Optimized table indexing for faster query performance.",
        ],
      ),
      Ability(
        name: 'Advanced Querying',
        brief:
        "Developed advanced SQL queries to meet complex application needs.",
        points: [
          "Implemented complex joins and subqueries for data retrieval.",
          "Utilized aggregate functions and window functions for analytics.",
        ],
      ),
      Ability(
        name: 'Performance Optimization',
        brief:
        "Ensured optimal database performance through tuning and monitoring.",
        points: [
          "Analyzed and optimized slow queries using EXPLAIN plans.",
          "Managed connection pools for high-concurrency scenarios.",
        ],
      ),
      Ability(
        name: 'Data Security',
        brief:
        "Implemented robust security measures for sensitive data protection.",
        points: [
          "Set up roles and permissions for controlled data access.",
          "Utilized SSL encryption to secure database connections.",
        ],
      ),
    ],
  );

  final Technologies _mysqlTechnology = Technologies(
    name: 'MySQL',
    brief:
    "MySQL is a widely-used relational database known for its simplicity, speed, and reliability in managing structured data.",
    url: 'https://www.mysql.com',
    technologyEnum: TechnologyEnum.mysqlTechnology,
    startDate: DateTime(2020, DateTime.june),
    abilities: const [
      Ability(
        name: 'Database Design',
        brief:
        "Proficient in designing normalized schemas for structured data storage.",
        points: [
          "Created efficient table structures to enforce data integrity.",
          "Optimized database relations with foreign keys and indexing.",
        ],
      ),
      Ability(
        name: 'Query Optimization',
        brief:
        "Improved application performance by optimizing database queries.",
        points: [
          "Analyzed slow queries using EXPLAIN for optimization.",
          "Implemented indexing to boost query execution speed.",
        ],
      ),
      Ability(
        name: 'Data Backup and Recovery',
        brief:
        "Ensured data durability with robust backup and recovery mechanisms.",
        points: [
          "Automated database backups for regular snapshots.",
          "Restored critical data efficiently during outages or failures.",
        ],
      ),
    ],
  );

  final Technologies _mongoDbTechnology = Technologies(
    name: 'MongoDB',
    brief:
    "MongoDB is a high-performance NoSQL database designed for flexible, scalable, and document-oriented storage, catering to modern, data-intensive applications.",
    startDate: DateTime(2021, DateTime.august),
    technologyEnum: TechnologyEnum.mongoDbTechnology,
    url: 'https://www.mongodb.com',
    abilities: const [
      Ability(
        name: 'Data Modeling',
        brief:
        "Expertise in designing and implementing flexible document-based schemas that align with application requirements.",
        points: [
          "Created dynamic schemas for rapid development.",
          "Designed indexes to optimize query performance.",
          "Managed relationships using embedded documents and references.",
        ],
      ),
      Ability(
        name: 'Scalability and Performance',
        brief:
        "Proficient in scaling MongoDB clusters and optimizing performance for high-throughput operations.",
        points: [
          "Configured sharding for large-scale data distribution.",
          "Tuned performance using profiling and monitoring tools.",
        ],
      ),
    ],
  );

  final Technologies _visualParadigmTechnology = Technologies(
    name: 'Visual Paradigm',
    brief:
    "Visual Paradigm is a robust tool for software and business process modeling, offering UML diagrams, agile tools, and collaboration capabilities to enhance system design and documentation.",
    startDate: DateTime(2020, DateTime.january),
    technologyEnum: TechnologyEnum.visualParadigmTechnology,
    url: 'https://www.visual-paradigm.com',
    abilities: const [
      Ability(
        name: 'Activity Diagrams',
        brief:
        "Proficient in creating activity diagrams to model workflows, enabling clear visualization of system processes and interactions.",
        points: [
          "Modeled complex workflows for software systems.",
          "Analyzed and optimized processes using clear diagrams.",
        ],
        url:
        'https://www.visual-paradigm.com/tutorials/how-to-draw-activity-diagram-in-uml',
      ),
      Ability(
        name: 'Data Flow Diagrams (DFD)',
        brief:
        "Skilled in illustrating system data flows with DFDs, providing clarity in data processing and system analysis.",
        points: [
          "Visualized data movement between processes and entities.",
          "Used DFDs to facilitate efficient communication with stakeholders.",
        ],
        url:
        'https://www.visual-paradigm.com/tutorials/data-flow-diagram-dfd.jsp',
      ),
      Ability(
        name: 'Entity-Relationship Diagrams (ERD)',
        brief:
        "Experienced in crafting ERDs for database design, highlighting entity relationships, attributes, and structural organization.",
        points: [
          "Designed comprehensive ERDs to streamline database implementation.",
          "Simplified data relationships for enhanced database normalization.",
        ],
        url:
        'https://www.visual-paradigm.com/tutorials/databasedesign.jsp',
      ),
    ],
  );

  @override
  List<Technologies> get allTechnologies => TechnologyEnum.values.map(getTechnology).toList();

  @override
  Technologies getTechnology(TechnologyEnum technologyEnum) {
   return switch (technologyEnum) {
     TechnologyEnum.springTechnology => _springTechnology,
     TechnologyEnum.dockerTechnology => _dockerTechnology,
     TechnologyEnum.kubernetesTechnology => _kubernetesTechnology,
     TechnologyEnum.gitTechnology => _gitTechnology,
     TechnologyEnum.nativeAndroidTechnology => _nativeAndroidTechnology,
     TechnologyEnum.flutterTechnology => _flutterTechnology,
     TechnologyEnum.riveTechnology => _riveTechnology,
     TechnologyEnum.adobeIllustratorTechnology => _adobeIllustratorTechnology,
     TechnologyEnum.postgresTechnology => _postgresTechnology,
     TechnologyEnum.mysqlTechnology => _mysqlTechnology,
     TechnologyEnum.mongoDbTechnology => _mongoDbTechnology,
     TechnologyEnum.visualParadigmTechnology => _visualParadigmTechnology,
    };
  }

}