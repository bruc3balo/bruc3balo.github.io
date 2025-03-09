import 'dart:collection';

import 'package:bruce_omukoko_portfolio/data/models/models.dart';
import 'package:bruce_omukoko_portfolio/data/repositories/project_repository.dart';
import 'package:bruce_omukoko_portfolio/data/repositories/technogoly_repository.dart';
import 'package:flutter/material.dart';

class ProjectViewModel extends ChangeNotifier {
  final ProjectRepository _projectRepository;
  final TechnologyRepository _technologyRepository;

  ProjectViewModel({
    required ProjectRepository projectRepository,
    required TechnologyRepository technologyRepository,
  })  : _projectRepository = projectRepository,
        _technologyRepository = technologyRepository;

  UnmodifiableListView<Project> get allProjects => UnmodifiableListView(_projectRepository.allProjects);

  Technologies getTechnology(TechnologyEnum technologyEnum) => _technologyRepository.getTechnology(technologyEnum);


}
