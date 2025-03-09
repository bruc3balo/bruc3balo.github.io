import 'package:bruce_omukoko_portfolio/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart' hide Image;

extension DateTimeX on DateTime {
  String get readableDateOnly {
    String getOrdinalSuffix(int day) {
      if (day >= 11 && day <= 13) {
        return '${day}th';
      }
      switch (day % 10) {
        case 1:
          return '${day}st';
        case 2:
          return '${day}nd';
        case 3:
          return '${day}rd';
        default:
          return '${day}th';
      }
    }

    String formatCustomDate(DateTime date) {
      String day = DateFormat('d').format(date);
      String month = DateFormat('MMMM').format(date);
      String year = DateFormat('y').format(date);

      // Create a function to add the ordinal suffix to the day
      String ordinalDay = getOrdinalSuffix(int.parse(day));

      // Combine the components to form the desired format
      return '$ordinalDay $month $year';
    }

    return formatCustomDate(toLocal());
  }
}

extension DurationX on Duration {
  String get inExperience {
    int daysInYear = 365;
    int days = inDays;

    if (days < daysInYear) return '$days days experience';

    int years = (days / daysInYear).round();
    return "$years year${years == 1 ? '' : 's'} experience";
  }
}

extension Xp on Technologies {
  String get xp => DateTime.now().difference(startDate).inExperience;
}

extension TechnologyCover on TechnologyEnum {
  Widget get cover {
    switch (this) {
      case TechnologyEnum.springTechnology:
        return SvgPicture.asset(
          "bruc3balo/assets/spring.svg",
          fit: BoxFit.contain,
          color: HexColor("#77bc1f"),
        );
      case TechnologyEnum.dockerTechnology:
        return SvgPicture.asset(
          "bruc3balo/assets/docker.svg",
          fit: BoxFit.contain,
        );
      case TechnologyEnum.kubernetesTechnology:
        return SvgPicture.asset(
          "bruc3balo/assets/kubernets.svg",
          fit: BoxFit.contain,
        );
      case TechnologyEnum.gitTechnology:
        return SvgPicture.asset(
          "bruc3balo/assets/git.svg",
          fit: BoxFit.contain,
        );
      case TechnologyEnum.nativeAndroidTechnology:
        return SvgPicture.asset(
          "bruc3balo/assets/android.svg",
          height: 300,
          width: 300,
          color: Colors.green,
        );
      case TechnologyEnum.flutterTechnology:
        return SvgPicture.asset(
          "bruc3balo/assets/flutter.svg",
          fit: BoxFit.contain,
        );
      case TechnologyEnum.riveTechnology:
        return Image.asset(
          "bruc3balo/assets/rive.png",
          fit: BoxFit.contain,
          width: 300,
          height: 300,
        );
      case TechnologyEnum.adobeIllustratorTechnology:
        return SvgPicture.asset(
          "bruc3balo/assets/adobe-illustrator.svg",
        );
      case TechnologyEnum.postgresTechnology:
        return SvgPicture.asset(
          "bruc3balo/assets/postgresql.svg",
          fit: BoxFit.contain,
        );
      case TechnologyEnum.mysqlTechnology:
        return SvgPicture.asset(
          "bruc3balo/assets/mysql.svg",
          fit: BoxFit.contain,
        );
      case TechnologyEnum.mongoDbTechnology:
        return SvgPicture.asset(
          "bruc3balo/assets/mongo.svg",
          height: 300,
          width: 300,
        );
      case TechnologyEnum.visualParadigmTechnology:
        return Image.asset(
          "bruc3balo/assets/visual-paradigm.png",
        );
    }
  }

  Curve get curve => Curves.linear;
}

extension SkillBoardColor on SkillsEnum {
  Color get color {
    return switch (this) {
      SkillsEnum.backendDevelopment => Colors.red,
      SkillsEnum.devOps => Colors.blueGrey,
      SkillsEnum.mobileDevelopment => Colors.green,
      SkillsEnum.vectorGraphics => Colors.brown,
      SkillsEnum.databaseAdministration => Colors.deepOrangeAccent,
      SkillsEnum.umlVisualization => Colors.white,
    };
  }
}

extension ProjectCover on ProjectEnum {
  Widget get cover {
    return switch (this) {
      ProjectEnum.tod => const RiveAnimation.asset(
          "bruc3balo/assets/tod.riv",
        ),
    };
  }
}
