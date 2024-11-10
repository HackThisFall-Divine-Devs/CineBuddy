import 'package:cine_buddy/main.dart';
import 'package:cine_buddy/src/features/groups/bloc/group_bloc.dart';
import 'package:cine_buddy/src/features/groups/widgets/contact_tile.dart';
import 'package:cine_buddy/src/features/groups/widgets/my_room_tile.dart';
import 'package:cine_buddy/src/models/groups/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyGroupsPage extends StatefulWidget {
  const MyGroupsPage({super.key});

  @override
  State<MyGroupsPage> createState() => _MyGroupsPageState();
}

class _MyGroupsPageState extends State<MyGroupsPage> {
  String userId = "";
  @override
  void initState() {
    userId = prefs.getString('userId') as String;
    context.read<GroupBloc>().add(FetchMyGroups());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: Center(
            child: Text(
              "My Groups",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 22.0),
            ),
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
                  if (state is FetchMyGroupLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FetchMyGroupSuccess) {
                    final successState = state as FetchMyGroupSuccess;
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
                            return MyRoomTile(groups[index], userId);
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
    );
  }
}
