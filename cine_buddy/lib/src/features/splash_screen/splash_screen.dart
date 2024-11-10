import 'package:cine_buddy/main.dart';
import 'package:cine_buddy/src/features/authentication/preferences.dart';
import 'package:cine_buddy/src/features/authentication/signin.dart';
import 'package:cine_buddy/src/features/home_outline/home_outline.dart';
import 'package:cine_buddy/src/features/onboarding/onboarding.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:cine_buddy/src/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    final int? onBoard = prefs.getInt('onBoard');

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              onBoard == 0 ? const HomeOutLine() : const Onboarding()));
    });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              "assets/icons/icon.svg",
              height: 40.0,
              colorFilter: ColorFilter.mode(
                ColorSys.ksecondary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              Strings.appName,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 28.0),
            ),
          ],
        ),
      ),
    );
  }
}
