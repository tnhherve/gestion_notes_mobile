import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gestion_notes/pages/login.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:gestion_notes/style/theme.dart' as Style;

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  bool clicked = false;

  void afterIntroComplete() {
    setState(() {
      this.clicked = true;
    });
  }

  final List<PageViewModel> pages = [
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          Text(
            "FACILE D'UTILISATION",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
                color: Style.Colors.mainColor,
                borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
      body:
          "Une application intuitive avec un tableau de board facile d'utilisation",
      image: Center(child: SvgPicture.asset("assets/icons/gift.svg")),
      decoration: const PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          descriptionPadding: EdgeInsets.only(left: 20, right: 20),
          imagePadding: EdgeInsets.all(20)),
    ),
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          Text(
            'VOUS NOTES A PORTER DE MAIN',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
                color: Style.Colors.mainColor,
                borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
      body:
          "En deux trois cliques, vous pouvez ajouter vous notes aux differents evaluations et avoir une vue sur votre avancement.",
      image: Center(
          child: SizedBox(
        width: 450.0,
        child: SvgPicture.asset("assets/icons/payment.svg"),
      )),
      decoration: const PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          descriptionPadding: EdgeInsets.only(left: 20, right: 20),
          imagePadding: EdgeInsets.all(20)),
    ),
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          Text(
            'DISPONIBLE 24H/24',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
                color: Style.Colors.mainColor,
                borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
      body:
          "Ou que vous soyez, vous avez un accès exclusif à vous données de façon securisé via internet.",
      image: Center(
          child: SizedBox(
        width: 450.0,
        child: SvgPicture.asset("assets/icons/call.svg"),
      )),
      decoration: const PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          descriptionPadding: EdgeInsets.only(left: 20, right: 20),
          imagePadding: EdgeInsets.all(20)),
    ),
  ];

  Widget build(BuildContext context) {
    return clicked
        ? Login()
        : IntroductionScreen(
            pages: pages,
            onDone: () {
              afterIntroComplete();
            },
            onSkip: () {
              afterIntroComplete();
            },
            showSkipButton: true,
            skip: const Text(
              'Skip',
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            next: const Icon(Icons.navigate_next),
            done: const Text(
              "Done",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            dotsDecorator: DotsDecorator(
                size: const Size.square(7.0),
                activeSize: const Size(20.0, 5.0),
                activeColor: Style.Colors.mainColor,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          );
  }
}
