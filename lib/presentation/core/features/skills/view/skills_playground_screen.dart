import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruce_omukoko_portfolio/data/data.dart';
import 'package:bruce_omukoko_portfolio/data/models/models.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/skills/view/skills_screen.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/skills/view_model/skills_view_model.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/ui/theme.dart';
import 'package:bruce_omukoko_portfolio/presentation/utils/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SkillPlayground extends StatelessWidget {
  const SkillPlayground({
    required this.skillsViewModel,
    super.key,
  });

  final SkillsViewModel skillsViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skills Playground"),
      ),
      body: LayoutBuilder(
        builder: (context, size) {
          return Stack(
            children: skillsViewModel.allSkills
                .expand(
                  (s) => s.technologies
                      .map(
                        (t) => TechnologyBoard(
                          color: s.skillsEnum.color,
                          technologies: skillsViewModel.getTechnology(t),
                          constraints: size,
                          onSelect: (t) => showTechnologyInfo(
                            context: context,
                            skillBoard: s,
                            technologies: t,
                          ),
                        ),
                      )
                      .toList(),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class TechnologyBoard extends StatefulWidget {
  const TechnologyBoard({
    required this.color,
    required this.technologies,
    required this.constraints,
    required this.onSelect,
    super.key,
  });

  final Color color;
  final Technologies technologies;
  final BoxConstraints constraints;
  final Function(Technologies) onSelect;

  @override
  State<TechnologyBoard> createState() => _TechnologyBoardState();
}

class _TechnologyBoardState extends State<TechnologyBoard> {
  Technologies get tech => widget.technologies;

  double get maxWidth => widget.constraints.maxWidth;

  double get maxHeight => 500;
  bool movingLeft = Random().nextInt(10) < 5;
  bool movingTop = Random().nextInt(10) > 5;
  late Timer timer;

  late final ValueNotifier<Size> positionNotifier = ValueNotifier(
    Size(
      Random().nextInt(maxWidth.floor()).floorToDouble(),
      Random().nextInt(maxHeight.floor()).floorToDouble(),
    ),
  );

  Duration get syncSpeed => const Duration(milliseconds: 500);

  Timer start() {
    return Timer.periodic(
      syncSpeed,
      (timer) {
        Size oldPosition = positionNotifier.value;

        double newWidth = oldPosition.width;
        double newHeight = oldPosition.height;

        if (oldPosition.width >= maxWidth - 130) movingLeft = true;
        if (oldPosition.width <= 0) movingLeft = false;

        if (oldPosition.height >= maxHeight - 130) movingTop = true;
        if (oldPosition.height <= 0) movingTop = false;

        //detect side edge position
        if (movingLeft) {
          newWidth -= 10;
        } else {
          newWidth += 10;
        }

        //detect top edge position
        if (movingTop) {
          newHeight -= 10;
        } else {
          newHeight += 10;
        }

        // print("Width: $newWidth, Height: $newHeight, movingLeft: $movingLeft, movingTop: $movingTop");

        positionNotifier.value = Size(
          newWidth,
          newHeight,
        );
      },
    );
  }

  void pause() {
    if (!timer.isActive) return;
    timer.cancel();
  }

  @override
  void initState() {
    timer = start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: positionNotifier,
      builder: (_, position, __) {
        return AnimatedPositioned(
          duration: syncSpeed,
          top: position.height,
          left: position.width,
          curve: Curves.linear,
          child: GestureDetector(
            onTap: () => widget.onSelect(tech),
            onVerticalDragUpdate: (d) {
              var globalPosition = d.globalPosition;
              positionNotifier.value = Size(
                globalPosition.dx,
                globalPosition.dy,
              );
            },
            dragStartBehavior: DragStartBehavior.down,
            child: Column(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.technologies.technologyEnum.cover,
                  ),
                ),
                AutoSizeText(widget.technologies.name),
              ],
            ),
          ),
        );
      },
    );
  }
}
