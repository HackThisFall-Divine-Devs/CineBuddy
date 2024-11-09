import 'package:cine_buddy/src/features/groups/bloc/group_bloc.dart';
import 'package:cine_buddy/src/features/groups/widgets/contact_tile.dart';
import 'package:cine_buddy/src/models/groups/group.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieGroupPage extends StatefulWidget {
  String? movie;
  MovieGroupPage(this.movie, {super.key});

  @override
  State<MovieGroupPage> createState() => _MovieGroupPageState();
}

class _MovieGroupPageState extends State<MovieGroupPage> {
  @override
  void initState() {
    context.read<GroupBloc>().add(FetchMovieGroups(widget.movie ?? ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            title: Center(
              child: Text(
                widget.movie ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 22.0),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
              color: ColorSys.kwhite,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                BlocConsumer<GroupBloc, GroupState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is FetchMovieGroupLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is FetchMovieGroupSuccess) {
                      final successState = state as FetchMovieGroupSuccess;
                      List<Group> groups = successState.group as List<Group>;
                      print(groups);
                      return SizedBox(
                        height: 1000,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: groups.length,
                            itemBuilder: (context, index) {
                              print(groups[index]);
                              return ContactTile(groups[index]);
                            }),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
