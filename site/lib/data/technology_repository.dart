import 'models.dart';

abstract class TechnologyRepository {

   Technologies getTechnology(TechnologyEnum technologyEnum);
   List<Technologies> get allTechnologies;
}

class TechnologyRepositoryImpl extends TechnologyRepository {

  final Technologies _springTechnology = Technologies(
    name: 'Spring Framework',
    brief: 'My main backend framework. I use Spring Boot to build REST APIs, microservices and USSD services in Java.',
    url: 'https://spring.io/projects/spring-framework',
    startDate: DateTime(2021, DateTime.august),
    technologyEnum: TechnologyEnum.springTechnology,
    abilities: [
      const Ability(
        name: 'USSD Applications',
        brief:
        "Built USSD menus with session tracking, so people can use mobile services on any phone without internet.",
      ),
      const Ability(
        name: 'Spring Data',
        brief:
        'Build data access layers with Spring Data JPA and Hibernate that stay fast as data grows.',
        points: [
          "Designed data models and mapped them to JPA entities.",
          "Wrote dynamic filters with JPA Specifications and custom JPQL queries.",
          "Kept queries fast on large tables with pagination, indexes and constraints.",
        ],
      ),
      const Ability(
        name: 'Spring Security',
        brief:
        'Secure APIs with Spring Security, covering who can log in and what each user is allowed to do.',
        points: [
          "Implemented JWT login and multi-factor authentication.",
          "Restricted access per endpoint and per method based on user roles.",
          "Kept each tenant's data isolated in multi-tenant systems.",
        ],
      ),
      const Ability(
        name: 'Microservices',
        brief:
        'Built Spring Boot microservices that talk through message queues and sit behind an API gateway.',
        points: [
          "Moved slow work off the request path with asynchronous messaging between services.",
          "Designed batch processing systems for high-volume tasks.",
        ],
      ),
    ],
  );

  final Technologies _dockerTechnology = Technologies(
    name: 'Docker',
    brief:
    "I package every service I ship as a Docker image, so it runs the same on my laptop, in CI and in production.",
    url: 'https://www.docker.com',
    technologyEnum: TechnologyEnum.dockerTechnology,
    startDate: DateTime(2022, DateTime.august),
    abilities: [
      const Ability(
        name: 'Dockerfile Authoring',
        brief:
        "Write Dockerfiles that produce small, fast-building images.",
        points: [
          "Created lightweight images using multistage builds and slim base images.",
          "Pass settings in through environment variables so one image works in every environment.",
        ],
      ),
      const Ability(
        name: 'Private Registry Management',
        brief:
        'Run private registries so team images stay internal and only the right people can pull them.',
        url:
        'https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-22-04',
        points: [
          "Configured basic authentication for registry security.",
        ],
      ),
      const Ability(
        name: 'Testing with Docker Compose',
        brief:
        "Spin up a service and everything it depends on (databases, queues) with one Docker Compose command for local testing.",
        url: 'https://docs.docker.com/compose',
        points: [
          "Split Compose files per service so each one can be tested on its own.",
          "Reused shared Compose config with extends and override files instead of copying it.",
        ],
      ),
    ],
  );

  final Technologies _kubernetesTechnology = Technologies(
    name: 'Kubernetes',
    brief:
    "I deploy and run my services on bare-metal Kubernetes clusters, with scaling, routing and health checks set up so they look after themselves.",
    url: 'https://kubernetes.io',
    technologyEnum: TechnologyEnum.kubernetesTechnology,
    startDate: DateTime(2024, DateTime.february),
    abilities: const [
      Ability(
        name: 'Certifications',
        brief:
        "Certified Kubernetes and Cloud Native Associate (KCNA), and currently preparing for the Certified Kubernetes Application Developer (CKAD) exam.",
      ),
      Ability(
        name: 'Deployment and Scaling',
        brief:
        "Roll out services with zero-downtime updates and scale them automatically as traffic changes.",
        points: [
          "Used Deployments with rolling updates and multiple replicas.",
          "Set up Horizontal Pod Autoscalers driven by CPU, memory and request metrics.",
        ],
      ),
      Ability(
        name: 'Networking and Traffic Management',
        brief:
        "Route traffic into and around the cluster so every service is reachable at the right address.",
        points: [
          "Exposed services with the NGINX Ingress Controller, including TLS certificates.",
          "Provisioned load balancers for distributed traffic handling.",
        ],
      ),
      Ability(
        name: 'Configuration and Secrets Management',
        brief:
        "Keep app settings and secrets out of images and out of plain text.",
        points: [
          "Used ConfigMaps for settings that change per environment.",
          "Stored sensitive data securely in encrypted Git repositories.",
        ],
      ),
      Ability(
        name: 'Monitoring and Health Checks',
        brief:
        "Use readiness and liveness probes so Kubernetes only sends traffic to healthy pods and restarts stuck ones.",
      ),
    ],
  );

  final Technologies _gitTechnology = Technologies(
    name: 'Git',
    brief:
    "I've used Git daily since 2017, on GitHub and GitLab, for solo projects and team codebases alike.",
    startDate: DateTime(2017, DateTime.august),
    technologyEnum: TechnologyEnum.gitTechnology,
    url: 'https://github.com',
    abilities: const [
      Ability(
        name: 'Repository Management',
        brief:
        "Set up repositories for teams, with branch protection, required reviews and CI checks on every pull request.",
      ),
      Ability(
        name: 'Branch Management',
        brief:
        "Keep history clean with feature branches, rebasing and fast-forward merges.",
        points: [
          "Recovered lost work and broken branches with reflog and reset.",
        ],
      ),
      Ability(
        name: 'Commit Management',
        brief:
        "Write small, clear commits so history is easy to review and debug.",
        points: [
          "Tracked down regressions with git bisect.",
          "Cherry-picked fixes onto release branches.",
        ],
      ),
    ],
  );

  final Technologies _ciCdTechnology = Technologies(
    name: 'CI/CD',
    brief:
    "I build pipelines in GitHub Actions, GitLab CI and Jenkins that test, build and deploy every change automatically.",
    startDate: DateTime(2022, DateTime.august),
    technologyEnum: TechnologyEnum.ciCdTechnology,
    url: 'https://github.com/features/actions',
    abilities: const [
      Ability(
        name: 'Pipelines',
        brief:
        "Write pipelines as code that run on every push and pull request.",
        points: [
          "Built workflows in GitHub Actions, GitLab CI and Jenkins.",
          "Cached dependencies and Docker layers to keep builds fast.",
        ],
      ),
      Ability(
        name: 'Automated Testing',
        brief:
        "Run tests and checks automatically so broken code never reaches the main branch.",
        points: [
          "Ran unit and integration tests on every pull request.",
          "Blocked merges until builds, tests and linters pass.",
        ],
      ),
      Ability(
        name: 'Deployments',
        brief:
        "Ship to production straight from the pipeline, with no manual steps.",
        points: [
          "Built and pushed Docker images, then rolled them out to Kubernetes.",
          "Kept separate staging and production environments with approval gates.",
        ],
      ),
    ],
  );

  final Technologies _nativeAndroidTechnology = Technologies(
    name: 'Native Android',
    brief:
    "I build native Android apps in Kotlin and Java, with UIs in Jetpack Compose or XML layouts and an MVI architecture that stays easy to maintain as the app grows.",
    url: 'https://developer.android.com',
    technologyEnum: TechnologyEnum.nativeAndroidTechnology,
    startDate: DateTime(2020, DateTime.may),
    abilities: const [
      Ability(
        name: 'Android SDK',
        brief:
        "Work across the Android SDK, from lifecycles and navigation to local storage and background work.",
        points: [
          "Built screens with Compose, plus activities and fragments in older apps.",
          "Stored data locally with Room.",
          "Managed UI state with ViewModel and Kotlin Flow in an MVI setup.",
        ],
      ),
      Ability(
        name: 'Kotlin and Java',
        brief:
        "Write app logic in Kotlin, and maintain Java codebases.",
        points: [
          "Ran background work with coroutines and WorkManager so the UI stays smooth.",
          "Handled errors and offline cases so the app fails gracefully.",
        ],
      ),
      Ability(
        name: 'UI: Compose and XML',
        brief:
        "Build Material Design UIs declaratively in Jetpack Compose, and in XML layouts for existing screens.",
        points: [
          "Built reusable composables and layout components.",
          "Used DataBinding to cut boilerplate in XML screens.",
        ],
      ),
      Ability(
        name: 'Networking with GraphQL',
        brief:
        "Connect apps to GraphQL APIs with Apollo Kotlin.",
        points: [
          "Generated type-safe Kotlin models from the GraphQL schema.",
          "Used Apollo's normalized cache so screens load fast and work offline.",
        ],
      ),
    ],
  );

  final Technologies _flutterTechnology = Technologies(
    name: 'Flutter',
    brief:
    "I build Flutter apps for Android, iOS and the web from one Dart codebase.",
    url: 'https://flutter.dev',
    technologyEnum: TechnologyEnum.flutterTechnology,
    startDate: DateTime(2021, DateTime.january),
    abilities: const [
      Ability(
        name: 'Cross-Platform Development',
        brief:
        "Build responsive UIs that adapt from phones to tablets and the browser.",
        points: [
          "Composed custom widgets and animations on top of Material.",
          "Connected apps to REST and GraphQL APIs.",
        ],
      ),
      Ability(
        name: 'State Management',
        brief:
        "Manage app state with Bloc, Riverpod and Provider, picking the one that fits the app.",
        points: [
          "Built multi-step navigation flows driven by app state.",
          "Cut unnecessary widget rebuilds to keep scrolling and animations smooth.",
        ],
      ),
      Ability(
        name: 'Firebase Integration',
        brief:
        "Use Firebase as a ready-made backend for login, data and notifications.",
        points: [
          "Set up sign-in flows with Firebase Authentication.",
          "Synced data in real time with Cloud Firestore.",
          "Sent push notifications with Firebase Cloud Messaging.",
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
     TechnologyEnum.ciCdTechnology => _ciCdTechnology,
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