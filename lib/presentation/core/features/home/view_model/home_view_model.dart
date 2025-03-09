import 'dart:collection';

import 'package:bruce_omukoko_portfolio/presentation/core/features/home/models/home_models.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final UnmodifiableListView<HomeSection> _homeSections = UnmodifiableListView(
    HomeSection.values,
  );
  HomeSection _currentSection = HomeSection.about;

  UnmodifiableListView<HomeSection> get allSections => _homeSections;
  int get noOfSections => allSections.length;
  HomeSection get currentSection => _currentSection;

  void setCurrentSection(HomeSection section) {
    if(_currentSection == section) return;

    _currentSection = section;
    notifyListeners();
  }

  bool isLastSection(int index) => _homeSections.last == _homeSections[index];

  HomeSection getSection(int index) => _homeSections[index];
}
