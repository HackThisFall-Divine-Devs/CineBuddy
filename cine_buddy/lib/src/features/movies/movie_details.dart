import 'package:cine_buddy/src/common_widgets/theme_button.dart';
import 'package:cine_buddy/src/features/groups/widgets/group_dialog.dart';
import 'package:cine_buddy/src/models/movie/genere.dart';
import 'package:cine_buddy/src/models/movie/movies.dart';
import 'package:cine_buddy/src/repository/movies_credit.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
  Movies movie;
  List<Genre> generes;
  MovieCredits movieCredits;
  MovieDetails(
      {super.key,
      required this.movie,
      required this.generes,
      required this.movieCredits});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ColorSys.kprimary,
            flexibleSpace: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(24),
              ),
              child: Image.network(
                'https://image.tmdb.org/t/p/original${widget.movie.posterPath}',
                fit: BoxFit.cover,
              ),
            ),
            toolbarHeight: 200.0,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Text(
                              widget.movie.title,
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 22.0),
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.bookmark_outline),
                            color: ColorSys.kblack,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rate,
                            size: 14.0,
                            color: Color.fromRGBO(255, 195, 25, 1),
                          ),
                          Text(
                            "9.1/10 IMDb",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 14.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: buildGenreWidgets(widget.movie.genreIds),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 2.0, 12.0, 2.0),
                                child: Text(
                                  "Release Date",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontSize: 14.0,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 2.0, 12.0, 2.0),
                                child: Text(
                                  widget.movie.releaseDate,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 14.0,
                                          color: ColorSys.kwhite),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 2.0, 12.0, 2.0),
                                child: Text(
                                  "Vote Count",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontSize: 14.0,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 2.0, 12.0, 2.0),
                                child: Text(
                                  widget.movie.voteCount.toString(),
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 14.0,
                                          color: ColorSys.kwhite),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 2.0, 12.0, 2.0),
                                child: Text(
                                  "Language",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontSize: 14.0,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 2.0, 12.0, 2.0),
                                child: Text(
                                  widget.movie.originalLanguage,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 14.0,
                                          color: ColorSys.kwhite),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Description",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 22.0),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.movie.overview,
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Cast",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 22.0),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 140.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.movieCredits.cast.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    child: Image.network(
                                      widget.movieCredits.cast[index]
                                                  .profilePath !=
                                              null
                                          ? 'https://image.tmdb.org/t/p/original${widget.movieCredits.cast[index].profilePath}'
                                          : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-lHBCodPME94gUAEZWFrLjscjuq2VtSITxKBd3ZxLGEsUZV1Ok9WdN5WA7P1-rOuwE_Q&usqp=CAU",
                                      fit: BoxFit.cover,
                                      height: 80.0,
                                      width: 80.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(widget.movieCredits.cast[index].name ??
                                      "")
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Container(
                          width: 300.0,
                          child: ThemeButton(
                            name: "Watch Together",
                            onPressed: () => GroupDialog().launchDialog(context,
                                movie: {
                                  "movie": widget.movie,
                                  "genere": widget.generes
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildGenreWidgets(List<int> genreIds) {
    List<Widget> widgets = [];
    for (int i = 0; i < genreIds.length; i++) {
      int genreId = genreIds[i];
      late String genereName;
      widget.generes.forEach((genre) {
        if (genre.id == genreId) {
          genereName = genre.name;
        }
        ;
      });
      Widget genreWidget = Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
              color: ColorSys.ksecondary,
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
            child: Text(
              genereName,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14.0,
                    color: ColorSys.kprimary,
                  ),
            ),
          ),
        ),
      );
      widgets.add(genreWidget);
    }
    return widgets;
  }
}
