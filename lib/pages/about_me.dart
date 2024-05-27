import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruce_omukoko_portfolio/data/data.dart';
import 'package:bruce_omukoko_portfolio/pages/contact_me.dart';
import 'package:bruce_omukoko_portfolio/theme/theme.dart';
import 'package:bruce_omukoko_portfolio/utils/reusable_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({
    required this.goToResume,
    required this.scrollToSkills,
    required this.scrollToContactMe,
    super.key,
  });

  final Function() goToResume;
  final Function() scrollToSkills;
  final Function() scrollToContactMe;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, size) {
        bool isMobileView = size.maxWidth < mobileSizeBorder;
        print("Mobile : $isMobileView : ${size.maxWidth}");

        return isMobileView
            ? AboutMeMobile(
          goToResume: goToResume,
          scrollToSkills: scrollToSkills,
          scrollToContactMe: scrollToContactMe,
        )
            : AboutMeDesktop(
            goToResume: goToResume,
            scrollToSkills: scrollToSkills,
            scrollToContactMe: scrollToContactMe,
        );
      },
    );
  }
}

class AboutMeDesktop extends StatelessWidget {
  AboutMeDesktop({
    required this.goToResume,
    required this.scrollToSkills,
    required this.scrollToContactMe,
    super.key,
  });

  final Function() goToResume;
  final Function() scrollToSkills;
  final Function() scrollToContactMe;
  final GlobalKey moreKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset("assets/flash.svg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Hey There, I'm ",
                              style: GoogleFonts.inter(
                                fontSize: 50,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "Bruce",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: orange,
                              ),
                            ),
                            TextSpan(
                              text: " Omukoko",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset("assets/sign.svg"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        "Software developer, chilling out in Nairobi and always up for a good problem solving challenge one code at a time.",
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset("assets/smile.svg"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: scrollToContactMe,
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(15.0)),
                                backgroundColor:
                                MaterialStateProperty.resolveWith(
                                      (state) {
                                    if (state.contains(MaterialState.hovered)) {
                                      return Colors.transparent;
                                    }

                                    return orange;
                                  },
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                ),
                                side: MaterialStateProperty.resolveWith(
                                      (state) {
                                    if (state.contains(MaterialState.hovered)) {
                                      return BorderSide(
                                          color: orange, width: 1.0);
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              child: Text(
                                "Let's Work",
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: scrollToSkills,
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(15.0)),
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                ),
                                side: MaterialStateProperty.resolveWith(
                                      (state) {
                                    if (state.contains(MaterialState.hovered)) {
                                      return BorderSide(
                                        color: orange,
                                        width: 1.0,
                                      );
                                    }

                                    return const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    );
                                  },
                                ),
                              ),
                              child: Text(
                                "More",
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: OnHover(
                            builder: (hovering) {
                              return GestureDetector(
                                onTap: () {
                                  Scrollable.ensureVisible(
                                    moreKey.currentContext!,
                                    duration:
                                    const Duration(milliseconds: 1000),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        "assets/mouse.svg",
                                        color: hovering ? orange : Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Scroll down",
                                      style: GoogleFonts.inter(
                                        fontSize: 20,
                                        color: hovering ? orange : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "assets/brucy.png",
                ),
              ),
            ),
          ],
        ),
        Flex(
          key: moreKey,
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: BruceRugbyPhoto(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "A little more about me",
                      key: moreKey,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 54,
                        color: orange,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "When I’m not deep in thought, you can find me gaming , getting rough and tumble on the  rugby field, or just hanging out with friends. Life’s too short not to enjoy a good game and some great company. So yeah, that’s me - always looking for the next challenge and bringing creative flair to everything I do.",
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 150,
                          maxWidth: 250,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset("flash.svg"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: goToResume,
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(15.0)),
                                  backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                        (state) {
                                      if (state
                                          .contains(MaterialState.hovered)) {
                                        return Colors.transparent;
                                      }

                                      return orange;
                                    },
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                  ),
                                  side: MaterialStateProperty.resolveWith(
                                        (state) {
                                      if (state
                                          .contains(MaterialState.hovered)) {
                                        return BorderSide(
                                            color: orange, width: 1.0);
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                                child: Text(
                                  "View my resume",
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: RotatedBox(
                                quarterTurns: 90,
                                child: SvgPicture.asset("flash.svg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AboutMeMobile extends StatelessWidget {
  AboutMeMobile({
    required this.goToResume,
    required this.scrollToSkills,
    required this.scrollToContactMe,
    super.key,
  });

  final Function() goToResume;
  final Function() scrollToSkills;
  final Function() scrollToContactMe;
  final GlobalKey moreKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset("assets/flash.svg"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Hey There, I'm ",
                        style: GoogleFonts.inter(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "Bruce",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: orange,
                        ),
                      ),
                      TextSpan(
                        text: " Omukoko",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/sign.svg"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "Software developer, chilling out in Nairobi and always up for a good problem solving challenge one code at a time.",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/smile.svg"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "assets/brucy.png",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: scrollToSkills,
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(15.0)),
                            backgroundColor: MaterialStateProperty.resolveWith(
                                  (state) {
                                if (state.contains(MaterialState.hovered)) {
                                  return Colors.transparent;
                                }

                                return orange;
                              },
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                            ),
                            side: MaterialStateProperty.resolveWith(
                                  (state) {
                                if (state.contains(MaterialState.hovered)) {
                                  return BorderSide(color: orange, width: 1.0);
                                }

                                return null;
                              },
                            ),
                          ),
                          child: Text(
                            "Let's Work",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: scrollToSkills,
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(15.0)),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.transparent,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                            ),
                            side: MaterialStateProperty.resolveWith(
                                  (state) {
                                if (state.contains(MaterialState.hovered)) {
                                  return BorderSide(
                                    color: orange,
                                    width: 1.0,
                                  );
                                }

                                return const BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                );
                              },
                            ),
                          ),
                          child: Text(
                            "More",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: OnHover(
                      builder: (hovering) {
                        return GestureDetector(
                          onTap: () {
                            Scrollable.ensureVisible(
                              moreKey.currentContext!,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  "assets/mouse.svg",
                                  color: hovering ? orange : Colors.white,
                                ),
                              ),
                              Text(
                                "Scroll down",
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  color: hovering ? orange : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "A little more about me",
                key: moreKey,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 54,
                  color: orange,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "When I’m not deep in thought, you can find me gaming , getting rough and tumble on the  rugby field, or just hanging out with friends. Life’s too short not to enjoy a good game and some great company. So yeah, that’s me - always looking for the next challenge and bringing creative flair to everything I do.",
                style: GoogleFonts.inter(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50,),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 150,
                  maxWidth: 250,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset("flash.svg"),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: goToResume,
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(15.0)),
                            backgroundColor: MaterialStateProperty.resolveWith(
                                  (state) {
                                if (state.contains(MaterialState.hovered)) {
                                  return Colors.transparent;
                                }

                                return orange;
                              },
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                            ),
                            side: MaterialStateProperty.resolveWith(
                                  (state) {
                                if (state.contains(MaterialState.hovered)) {
                                  return BorderSide(color: orange, width: 1.0);
                                }

                                return null;
                              },
                            ),
                          ),
                          child: Text(
                            "View my resume",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RotatedBox(
                        quarterTurns: 90,
                        child: SvgPicture.asset("flash.svg"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const BruceRugbyPhoto(),
      ],
    );
  }
}

class BruceRugbyPhoto extends StatelessWidget {
  const BruceRugbyPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        height: 700,
        child: Stack(
          children: [
            Container(
              height: 450,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/bruce_rugby.jpg',
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: ThatsMeLol(),
            ),
          ],
        ),
      ),
    );
  }
}

class ThatsMeLol extends StatelessWidget {
  const ThatsMeLol({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 33.0,
                top: 35.0,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  "assets/rugby_arrow.svg",
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: AutoSizeText(
                "That is me LOL",
                style: GoogleFonts.lovedByTheKing(
                  color: Colors.white,
                ),
                maxFontSize: 64,
                minFontSize: 32,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
