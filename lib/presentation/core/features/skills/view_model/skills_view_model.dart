import 'package:bruce_omukoko_portfolio/data/models/models.dart';
import 'package:bruce_omukoko_portfolio/data/repositories/skill_repository.dart';
import 'package:bruce_omukoko_portfolio/data/repositories/technogoly_repository.dart';
import 'package:flutter/material.dart';

class SkillsViewModel extends ChangeNotifier {
  final SkillRepository _skillRepository;
  final TechnologyRepository _technologyRepository;

  SkillsViewModel({
    required SkillRepository skillRepository,
    required TechnologyRepository technologyRepository,
  })  : _skillRepository = skillRepository,
        _technologyRepository = technologyRepository;

  List<SkillBoard> get allSkills => _skillRepository.allSkills;

  Technologies getTechnology(TechnologyEnum technologyEnum) => _technologyRepository.getTechnology(technologyEnum);
}
