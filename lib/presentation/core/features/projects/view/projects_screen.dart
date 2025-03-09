import 'package:bruce_omukoko_portfolio/data/models/models.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/features/projects/view_model/project_view_model.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/ui/theme.dart';
import 'package:bruce_omukoko_portfolio/presentation/utils/extensions.dart';
import 'package:bruce_omukoko_portfolio/presentation/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({
    required this.projectViewModel,
    super.key,
  });

  final ProjectViewModel projectViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Projects",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 60,
              color: orange,
            ),
          ),
        ),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: projectViewModel.allProjects
              .map(
                (e) => ProjectItem(
                  project: e,
                  getTechnology: projectViewModel.getTechnology,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class ProjectItem extends StatelessWidget {
  const ProjectItem({
    required this.project,
    required this.getTechnology,
    super.key,
  });

  final Project project;
  final Function(TechnologyEnum) getTechnology;

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => openStringUri(project.url),
        child: SizedBox(
          height: 500,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(child: project.projectEnum.cover),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SelectableText(
                            project.name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.open_in_new,
                        ),
                      ),
                      subtitle: SelectableText(
                        project.about,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 70,
                        child: Flex(
                          direction: Axis.horizontal,
                          children: project.stack
                              .map(
                                (e) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () => openStringUri(getTechnology(e).url),
                                      child: Tooltip(
                                        message: e.name,
                                        child: getTechnology(e).technologyEnum.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
