import 'package:cine_buddy/src/features/groups/bloc/group_bloc.dart';
import 'package:cine_buddy/src/features/groups/widgets/contact_tile.dart';
import 'package:cine_buddy/src/models/groups/group.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livekit_client/livekit_client.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  void initState() {
    context.read<GroupBloc>().add(FetchGroups());
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
          leading: Center(
            child: Text(
              "Movie Crews",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 22.0),
            ),
          ),
          leadingWidth: 200.0,
          actions: [
            IconButton(
              onPressed: () async {
                final roomOptions = RoomOptions(
                  adaptiveStream: true,
                  dynacast: true,
                );

                final room = Room();

                await room.connect("http://127.0.0.1:3000/",
                    "eyJhbGciOiJIUzI1NiJ9.eyJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwicm9vbSI6InF1aWNrc3RhcnQtcm9vbSJ9LCJpc3MiOiJBUElIa0dpY0RQdVNjOGEiLCJleHAiOjE3MjI3NzY3NjksIm5iZiI6MCwic3ViIjoicXVpY2tzdGFydC11c2VybmFtZSJ9.nN0bkYyICrILHCxHRHnGdmlsG-HHkb_3Y2zxB0LTbyo",
                    roomOptions: roomOptions);
                try {
                  // video will fail when running in ios simulator
                  await room.localParticipant?.setCameraEnabled(true);
                } catch (error) {
                  print('Could not publish video, error: $error');
                }

                await room.localParticipant?.setMicrophoneEnabled(true);
              },
              icon: const Icon(Icons.search),
              color: ColorSys.kwhite,
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              BlocConsumer<GroupBloc, GroupState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is FetchGroupLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FetchGroupSuccess) {
                    final successState = state as FetchGroupSuccess;
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
    );
  }
}
