import 'package:cine_buddy/src/features/home/widgets/movie_genre.dart';
import 'package:cine_buddy/src/features/home/widgets/sliding_card.dart';
import 'package:cine_buddy/src/features/movies/movie_search.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:cine_buddy/src/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(
              12.0,
              0,
              0,
              0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  Strings.homeTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 22.0),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              icon: const Icon(Icons.search),
              color: ColorSys.kwhite,
            ),
          ],
          leadingWidth: double.infinity,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 12.0),
                  child: Text(
                    Strings.nowPlayingText,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 22.0),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const SlidingCard(),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ]),
        ),
        const MoviesByGenre(),
      ],
    );
  }
}
