import 'dart:collection';

import 'package:bruce_omukoko_portfolio/data/models/models.dart';
import 'package:bruce_omukoko_portfolio/data/repositories/publication_repository.dart';

class PublicationsViewModel {
  final PublicationRepository _publicationRepository;

  PublicationsViewModel({
    required PublicationRepository publicationRepository,
  }) : _publicationRepository = publicationRepository;

  UnmodifiableListView<RiveArt> get allRiveArts => UnmodifiableListView(_publicationRepository.allRiveArts);
}
