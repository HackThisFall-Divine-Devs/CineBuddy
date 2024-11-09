import 'package:cine_buddy/src/models/movie/carousel_movies.dart';
import 'package:cine_buddy/src/features/home/bloc/carousel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class SlidingCard extends StatefulWidget {
  const SlidingCard({super.key});

  @override
  State<SlidingCard> createState() => _SlidingCardState();
}

class _SlidingCardState extends State<SlidingCard> {
  late int futureMoviesSize;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    context.read<CarouselBloc>().add(CarouselRenderRequest());
  }

  List<Widget> generateMovieWidgets(List<CarouselMovie> movies) {
    return List.generate(
      movies.length,
      (index) => ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        child: Image.network(
          'https://image.tmdb.org/t/p/w500${movies[index].posterPath}',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarouselBloc, CarouselBlocState>(
      listener: (context, state) {
        //? Need it when wants to implement the onClick on slider card
      },
      builder: (context, state) {
        if (state is CarouselLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CarouselSuccess) {
          final successState = state;
          List<CarouselMovie> movies = successState.carouselMovies;
          List<Widget> movieWidgets = generateMovieWidgets(movies);

          return FlutterCarousel(
            items: movieWidgets,
            options: CarouselOptions(
              height: 300,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.6,
              showIndicator: false,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          );
        } else if (state is CarouselFailure) {
          return const Center(
            child: Text("Error loading the data!"),
          );
        } else {
          return const Center(
            child: Text("Unexpected error occured!"),
          );
        }
      },
    );
  }
}
