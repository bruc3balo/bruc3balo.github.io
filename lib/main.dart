import 'package:bruce_omukoko_portfolio/data/repositories/publication_repository.dart';
import 'package:bruce_omukoko_portfolio/data/repositories/skill_repository.dart';
import 'package:bruce_omukoko_portfolio/data/repositories/technogoly_repository.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/home/view/home_screen.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/home/view_model/home_view_model.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/publications/view_model/publications_view_model.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/skills/view/skills_playground_screen.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/skills/view_model/skills_view_model.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/ui/theme.dart';
import 'package:bruce_omukoko_portfolio/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  SkillRepository skillRepository = SkillRepositoryImpl();
  GetIt.I.registerSingleton(skillRepository);

  TechnologyRepository technologyRepository = TechnologyRepositoryImpl();
  GetIt.I.registerSingleton(technologyRepository);

  PublicationRepository publicationRepository = PublicationRepositoryImpl();
  GetIt.I.registerSingleton(publicationRepository);

  runApp(const PortfolioApplication());
}

class PortfolioApplication extends StatelessWidget {
  const PortfolioApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home.path,
        routes: {
          AppRoutes.home.path: (c) => HomePage(
                homeViewModel: HomeViewModel(),
                skillsViewModel: SkillsViewModel(
                  skillRepository: GetIt.I(),
                  technologyRepository: GetIt.I(),
                ),
                publicationsViewModel: PublicationsViewModel(
                  publicationRepository: GetIt.I(),
                ),
              ),
          AppRoutes.playground.path: (c) => SkillPlayground(
                skillsViewModel: SkillsViewModel(
                  skillRepository: GetIt.I(),
                  technologyRepository: GetIt.I(),
                ),
              ),
        },
      ),
    );
  }
}
