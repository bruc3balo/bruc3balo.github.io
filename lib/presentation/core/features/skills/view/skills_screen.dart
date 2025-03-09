import 'dart:async';

import 'package:bruce_omukoko_portfolio/data/models/models.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/skills/view_model/skills_view_model.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/ui/reusable_widgets.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/ui/theme.dart';
import 'package:bruce_omukoko_portfolio/presentation/utils/extensions.dart';
import 'package:bruce_omukoko_portfolio/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({
    required this.isMobileView,
    required this.skillsViewModel,
    super.key,
  });

  final bool isMobileView;
  final SkillsViewModel skillsViewModel;

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final ValueNotifier<double> opacityStream = ValueNotifier(1);

  bool reverse = false;

  @override
  void initState() {
    Timer.periodic(
      const Duration(milliseconds: 200),
      (timer) {
        double val = opacityStream.value;

        if (val <= 0.1) {
          reverse = false;
        } else if (val >= 0.9) {
          reverse = true;
        }

        if (reverse) {
          val -= 0.1;
        } else {
          val += 0.1;
        }

        opacityStream.value = val;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: SizedBox(
            height: 500,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.playground.path,
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Skills",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 60,
                              color: orange,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ValueListenableBuilder(
                            valueListenable: opacityStream,
                            builder: (_, opacity, __) {
                              return AnimatedOpacity(
                                opacity: opacity,
                                duration: const Duration(milliseconds: 200),
                                child: const Icon(
                                  Icons.ads_click,
                                  color: Colors.greenAccent,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: widget.isMobileView ? 270 : 350,
                  bottom: 250,
                  child: PsstPressHere(
                    isMobileView: widget.isMobileView,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisExtent: 150,
              mainAxisSpacing: 80,
            ),
            children: widget.skillsViewModel.allSkills
                .expand(
                  (s) => s.technologies.map(
                        (t) => OnHover(
                          builder: (hovering) {
                            return Flex(
                              direction: Axis.vertical,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => showTechnologyInfo(
                                      context: context,
                                      skillBoard: s,
                                      technologies: widget.skillsViewModel.getTechnology(t),
                                    ),
                                    child: AnimatedScale(
                                      scale: hovering ? 0.5 : 0.8,
                                      duration: const Duration(milliseconds: 300),
                                      child: Visibility(
                                        visible: hovering,
                                        replacement: t.cover,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: t.cover,
                                            ),
                                            SvgPicture.asset(
                                              "bruc3balo/assets/skills_hover.svg",
                                              width: 250,
                                              height: 250,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.skillsViewModel.getTechnology(t).name,
                                  style: GoogleFonts.aBeeZee(),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  widget.skillsViewModel.getTechnology(t).xp,
                                  style: GoogleFonts.aBeeZee(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                        ),
                      ).toList(),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class PsstPressHere extends StatelessWidget {
  const PsstPressHere({
    required this.isMobileView,
    super.key,
  });

  final bool isMobileView;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Psst press here",
          style: GoogleFonts.lovedByTheKing(
            color: Colors.white,
            fontSize: isMobileView ? 34 : 64,
          ),
          textAlign: TextAlign.center,
        ),
        SvgPicture.asset(
          "bruc3balo/assets/skills_arrow.svg",
        ),
      ],
    );
  }
}

void showTechnologyInfo({
  required BuildContext context,
  required SkillBoard skillBoard,
  required Technologies technologies,
}) {
  showDialog(
    context: context,
    builder: (_) {
      final ThemeData theme = Theme.of(context);
      return Dialog(
        insetAnimationCurve: Curves.easeIn,
        insetAnimationDuration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: orange,
        child: Card(
          color: darkBackground,
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Text(
                technologies.name,
                style: theme.listTileTheme.titleTextStyle,
              ),
              Text(
                technologies.xp,
                style: theme.listTileTheme.subtitleTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.red),
                  ),
                  onPressed: Navigator.of(context).pop,
                  child: Text("Close"),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: technologies.abilities.length,
                  itemBuilder: (_, i) {
                    Ability a = technologies.abilities[i];
                    return Visibility(
                      visible: a.points.isNotEmpty,
                      replacement: ListTile(
                        title: Text(a.name),
                        subtitle: Text(a.brief),
                      ),
                      child: ExpansionTile(
                        title: Text(a.name),
                        subtitle: Text(a.brief),
                        children: a.points
                            .map(
                              (e) => ListTile(
                                leading: const Icon(Icons.chevron_right),
                                title: Text(e),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
