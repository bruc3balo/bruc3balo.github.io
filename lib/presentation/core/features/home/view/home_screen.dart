import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruce_omukoko_portfolio/data/data.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/about_me/view/about_me_screen.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/contact_me/contact_me.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/home/models/home_models.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/home/view_model/home_view_model.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/publications/view/publications_screen.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/publications/view_model/publications_view_model.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/skills/view/skills_screen.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/skills/view_model/skills_view_model.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/splash/splash_screen.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/ui/theme.dart';
import 'package:bruce_omukoko_portfolio/presentation/utils/functions.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/ui/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

final ScrollController scrollController = ScrollController();
final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

class HomePage extends StatefulWidget {
  const HomePage({
    required this.homeViewModel,
    required this.skillsViewModel,
    required this.publicationsViewModel,
    super.key,
  });

  final HomeViewModel homeViewModel;
  final SkillsViewModel skillsViewModel;
  final PublicationsViewModel publicationsViewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double get separation => 70;

  @override
  void initState() {
    itemPositionsListener.itemPositions.addListener(() {
      List<ItemPosition> positions = itemPositionsListener.itemPositions.value.toList();
      positions.sort((a, b) => -a.index.compareTo(b.index));

      HomeSection section = widget.homeViewModel.allSections[positions.first.index];
      widget.homeViewModel.setCurrentSection(section);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background,
        LayoutBuilder(
          builder: (_, size) {
            bool isMobileView = size.maxWidth < mobileSizeBorder;
            return ListenableBuilder(
              listenable: widget.homeViewModel,
              builder: (_, __) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Bruce",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: orange,
                            ),
                          ),
                          TextSpan(
                            text: " Omukoko",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: isMobileView
                        ? null
                        : widget.homeViewModel.allSections.map(
                            (e) {
                              bool visible = widget.homeViewModel.currentSection == e;
                              return MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    itemScrollController.scrollTo(
                                      index: e.index,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOutCubic,
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 3.0,
                                      bottom: 3.0,
                                      left: isMobileView ? 2.0 : 6.0,
                                      right: isMobileView ? 2.0 : 6.0,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        OnHover(builder: (hovering) {
                                          return AutoSizeText(
                                            e.value,
                                            minFontSize: 8,
                                            maxFontSize: 16,
                                            style: GoogleFonts.inter(
                                              color: hovering ? orange : Colors.white,
                                              fontWeight: visible ? FontWeight.bold : FontWeight.w400,
                                              // fontSize: 24,
                                            ),
                                            textAlign: TextAlign.center,
                                          );
                                        }),
                                        AnimatedOpacity(
                                          opacity: visible ? 1 : 0,
                                          duration: const Duration(
                                            seconds: 1,
                                          ),
                                          curve: Curves.slowMiddle,
                                          child: Visibility(
                                            visible: visible,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                radius: 3.5,
                                                backgroundColor: orange,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                  ),
                  body: ScrollablePositionedList.separated(
                    itemCount: widget.homeViewModel.noOfSections,
                    separatorBuilder: (_, i) {
                      double height = widget.homeViewModel.isLastSection(i) ? separation / 2 : separation;
                      return SizedBox(
                        height: height,
                      );
                    },
                    itemBuilder: (_, i) {
                      HomeSection s = widget.homeViewModel.getSection(i);
                      return switch (s) {
                        HomeSection.about => AboutMePage(
                            isMobileView: isMobileView,
                            goToFlutterResume: () => openStringUri(flutterResume),
                            goToBackendResume: () => openStringUri(backendResume),
                            scrollToSkills: () {
                              itemScrollController.scrollTo(
                                index: HomeSection.skills.index,
                                duration: const Duration(seconds: 1),
                              );
                            },
                            scrollToContactMe: () {
                              itemScrollController.scrollTo(
                                index: HomeSection.contact.index,
                                duration: const Duration(seconds: 1),
                              );
                            },
                          ),
                        HomeSection.skills => SkillsPage(
                            isMobileView: isMobileView,
                            skillsViewModel: widget.skillsViewModel,
                          ),
                        HomeSection.publications => PublicationsPage(
                            isMobileView: isMobileView,
                            publicationsViewModel: widget.publicationsViewModel,
                          ),
                        // HomeSection.projects => const ProjectsPage(),
                        HomeSection.contact => const ContactMePage(),
                      };
                    },
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                  ),
                );
              },
            );
          },
        ),
        const SplashScreen(),
      ],
    );
  }
}
