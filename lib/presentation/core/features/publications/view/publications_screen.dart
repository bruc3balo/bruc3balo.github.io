import 'dart:async';

import 'package:bruce_omukoko_portfolio/data/models/models.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/publications/view_model/publications_view_model.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/ui/theme.dart';

// import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' hide Image;
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;

class PublicationsPage extends StatelessWidget {
  const PublicationsPage({
    required this.publicationsViewModel,
    required this.isMobileView,
    super.key,
  });

  final PublicationsViewModel publicationsViewModel;
  final bool isMobileView;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobileView ? 100 : 200.0, top: isMobileView ? 90 : 180),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Publications",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: isMobileView ? 40 : 60,
                color: orange,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: RivePublications(
              riveArts: publicationsViewModel.allRiveArts,
              isMobileView: isMobileView,
            ),
          ),
        ],
      ),
    );
  }
}

class RivePublications extends StatelessWidget {
  const RivePublications({
    required this.riveArts,
    required this.isMobileView,
    super.key,
  });

  final List<RiveArt> riveArts;
  final bool isMobileView;

  @override
  Widget build(BuildContext context) {
    return RivePublicationItemMenu(
      isMobileView: isMobileView,
      rives: riveArts,
    );
  }
}

class RivePublicationItemMenu extends StatefulWidget {
  const RivePublicationItemMenu({
    required this.rives,
    required this.isMobileView,
    super.key,
  });

  final List<RiveArt> rives;
  final bool isMobileView;

  @override
  State<RivePublicationItemMenu> createState() => _RivePublicationItemMenuState();
}

class _RivePublicationItemMenuState extends State<RivePublicationItemMenu> with SingleTickerProviderStateMixin {
  ValueNotifier<bool> openNotifier = ValueNotifier(false);

  double widthFactor = 4.5;
  late Timer timer;

  Duration get riveDuration => const Duration(seconds: 1);

  late AnimationController controller;
  late final Animation<double> rotation = Tween<double>(
    begin: 0.0,
    end: 360.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.0,
        0.7,
        curve: Curves.easeInOutCubicEmphasized,
      ),
    ),
  );

  late final Animation<double> scale = Tween<double>(
    begin: 1.5,
    end: 0.0,
  ).animate(
    CurvedAnimation(parent: controller, curve: Curves.elasticOut),
  );

  void open() {
    openNotifier.value = true;
    controller.forward();
  }

  void close() {
    openNotifier.value = false;
    controller.reverse();
  }

  Future<Map<RiveArt, RiveFile>> _loadRiveFiles() async {
    // Load all files concurrently using Future.wait
    final results = await Future.wait(
      widget.rives.map(
        (art) async {
          final data = await rootBundle.load(art.asset);
          final file = RiveFile.import(data);
          return MapEntry(art, file);
        },
      ),
    );

    // Convert the list of MapEntry to LinkedHashMap to maintain order
    return Map.fromEntries(results);
  }

  // List<RiveArt> get rives => widget.rives;

  Widget buildButton({
    required double angle,
    required Animation<double> translation,
    double width = 250,
    required RiveArt riveArt,
  }) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()..translate((translation.value) * cos(rad), (translation.value) * sin(rad)),
      child: RivePublicationCircularItem(
        r: riveArt,
        width: width,
      ),
    );
  }

  final ValueNotifier<double> scaleNotifier = ValueNotifier(1.0);
  bool reverse = false;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    timer = Timer.periodic(riveDuration, (timer) {
      double val = scaleNotifier.value;

      if (val <= 0.9) {
        reverse = false;
      } else if (val >= 1.1) {
        reverse = true;
      }

      if (reverse) {
        val -= 0.1;
      } else {
        val += 0.1;
      }

      scaleNotifier.value = val;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, size) {
        widthFactor = (size.maxWidth / 100) - 2.0;

        double diameter = (size.maxWidth / widthFactor);
        double radius = (diameter / 2);

        final Animation<double> translation = Tween<double>(
          begin: 0.0,
          end: diameter,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.slowMiddle,
          ),
        );

        return AnimatedBuilder(
          animation: openNotifier,
          builder: (_, __) {
            bool isOpen = openNotifier.value;
            return AnimatedSize(
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: isOpen ? 600 : 200,
                child: Center(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (_, __) {
                      return Transform.rotate(
                        angle: radians(rotation.value),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ...widget.rives.sublist(1).asMap().entries.map(
                              (r) {
                                double angle = r.key * (360 / widget.rives.sublist(1).length);
                                return buildButton(
                                  angle: angle,
                                  translation: translation,
                                  riveArt: r.value,
                                  width: isOpen ? diameter : radius,
                                );
                              },
                            ),
                            Transform.scale(
                              scale: isOpen ? scale.value - 1 : scale.value,
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => isOpen ? close() : open(),
                                  child: ValueListenableBuilder(
                                    valueListenable: scaleNotifier,
                                    builder: (_, scale, __) {
                                      return AnimatedScale(
                                        scale: scale,
                                        duration: riveDuration,
                                        child: CircleAvatar(
                                          radius: radius - 20,
                                          backgroundColor: isOpen ? Colors.red : Colors.green,
                                          child: CircleAvatar(
                                            radius: radius - 25,
                                            child: RotatedBox(
                                              quarterTurns: isOpen ? 2 : 0,
                                              child: RivePublicationCircularItem(
                                                r: widget.rives[0],
                                                width: isOpen ? radius : diameter + 100,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class RivePublicationCircularItem extends StatelessWidget {
  const RivePublicationCircularItem({
    required this.r,
    this.width = 300,
    super.key,
  });

  final RiveArt r;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: RiveAnimation.asset(
        r.asset,
      ),
    );
  }
}
