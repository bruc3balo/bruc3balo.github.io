import 'package:bruce_omukoko_portfolio/data/models/models.dart';

abstract class PublicationRepository {
  RiveArt getRiveArt(RiveArtEnum riveArtEnum);

  List<RiveArt> get allRiveArts;
}

class PublicationRepositoryImpl extends PublicationRepository {
  RiveArt get _tod => const RiveArt(
        name: 'Truth or drink',
        riveArtEnum: RiveArtEnum.tod,
        animation: 'TOD',
        description:
            "Truth or Drink is a drinking game where players take turns asking each other questions. If someone doesn't want to answer, they take a drink instead. It's a fun way to get to know each other better while enjoying some drinks.",
        asset: 'bruc3balo/assets/tod.riv',
      );

  RiveArt get _anger => const RiveArt(
        name: 'Anger',
        riveArtEnum: RiveArtEnum.anger,
        animation: 'Anger',
        description:
            'An intense emotional response to perceived threats, frustrations, or injustices. Anger often involves feelings of hostility, irritation, and the desire to assert dominance or control.',
        asset: 'bruc3balo/assets/anger.riv',
      );

  RiveArt get _contempt => const RiveArt(
        name: 'Contempt',
        riveArtEnum: RiveArtEnum.contempt,
        animation: 'Contempt',
        description:
            'A mix of anger and disgust directed toward individuals or things perceived as inferior, worthless, or morally objectionable. Contempt often involves sneering, eye-rolling, or other dismissive gestures.',
        asset: 'bruc3balo/assets/contempt.riv',
      );

  RiveArt get _disgust => const RiveArt(
        name: 'Disgust',
        riveArtEnum: RiveArtEnum.disgust,
        animation: 'Disgust',
        description:
            'An aversive emotion triggered by offensive stimuli or situations. Disgust can lead to physical reactions like nausea or grimacing and serves as a protective mechanism against potentially harmful substances.',
        asset: 'bruc3balo/assets/disgust.riv',
      );

  RiveArt get _fear => const RiveArt(
        name: 'Fear',
        riveArtEnum: RiveArtEnum.fear,
        animation: 'Fear',
        description:
            "A primal emotion triggered by the anticipation of danger or threat. Fear activates the body's fight-or-flight response and can manifest as heightened alertness, trembling, or avoidance behaviors.",
        asset: 'bruc3balo/assets/fear.riv',
      );

  RiveArt get _happiness => const RiveArt(
        name: 'Happiness',
        riveArtEnum: RiveArtEnum.happiness,
        animation: 'Happy',
        description:
            "A positive emotion characterized by feelings of joy, contentment, and satisfaction. Happiness is often accompanied by smiling, laughter, and a sense of well-being.",
        asset: 'bruc3balo/assets/happy.riv',
      );

  RiveArt get _sadness => const RiveArt(
        name: 'Sadness',
        riveArtEnum: RiveArtEnum.sadness,
        animation: 'Sad',
        description:
            "A negative emotion associated with feelings of loss, disappointment, or sorrow. Sadness can manifest as tears, low energy, and a lack of motivation.",
        asset: 'bruc3balo/assets/sad.riv',
      );

  RiveArt get _surprise => const RiveArt(
        name: 'Surprise',
        riveArtEnum: RiveArtEnum.surprise,
        animation: 'Surprise',
        description:
            "A brief emotional reaction to unexpected or startling events. Surprise often involves wide-eyed expression, raised eyebrows, and a sudden intake of breath.",
        asset: 'bruc3balo/assets/surprised.riv',
      );

  @override
  List<RiveArt> get allRiveArts => RiveArtEnum.values.map(getRiveArt).toList();

  @override
  RiveArt getRiveArt(RiveArtEnum riveArtEnum) {
    return switch (riveArtEnum) {
      RiveArtEnum.tod => _tod,
      RiveArtEnum.anger => _anger,
      RiveArtEnum.sadness => _sadness,
      RiveArtEnum.surprise => _surprise,
      RiveArtEnum.happiness => _happiness,
      RiveArtEnum.fear => _fear,
      RiveArtEnum.disgust => _disgust,
      RiveArtEnum.contempt => _contempt,
    };
  }
}
