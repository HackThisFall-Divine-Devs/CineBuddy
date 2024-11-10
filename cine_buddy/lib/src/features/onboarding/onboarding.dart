import 'package:cine_buddy/src/common_widgets/theme_button.dart';
import 'package:cine_buddy/src/features/authentication/signin.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:cine_buddy/src/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController _pageController;
  int currentIndex = 0;
  String text = Strings.nextText;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo(context) async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: TextButton(
              onPressed: () {
                _storeOnboardInfo(context);
              },
              child:
                  Text("Skip", style: Theme.of(context).textTheme.bodyMedium),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                  text =
                      currentIndex != 2 ? Strings.nextText : Strings.skipText;
                });
              },
              controller: _pageController,
              children: <Widget>[
                makePage(
                    image: 'assets/images/onboarding_1.json',
                    title: Strings.stepOneTitle,
                    content: Strings.stepOneContent,
                    margin: 60.0),
                makePage(
                    image: 'assets/images/onboarding_2.json',
                    title: Strings.stepTwoTitle,
                    content: Strings.stepTwoContent,
                    margin: 0.0),
                makePage(
                    image: 'assets/images/onboarding_3.json',
                    title: Strings.stepThreeTitle,
                    content: Strings.stepThreeContent,
                    margin: 0.0),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget makePage({image, title, content, margin}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.only(left: margin),
            child: Lottie.asset(
              image,
              height: 300,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(content,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ThemeButton(
              name: text,
              onPressed: () async {
                if (text == Strings.skipText) {
                  _storeOnboardInfo(context);
                } else {
                  setState(() {
                    currentIndex += 1;
                    text =
                        currentIndex != 2 ? Strings.nextText : Strings.skipText;
                    _pageController.jumpToPage(currentIndex);
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: ColorSys.ksecondary, borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
