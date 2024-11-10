import 'dart:convert';

import 'package:cine_buddy/src/features/groups/bloc/group_bloc.dart';
import 'package:cine_buddy/src/features/notification/widgets/notification_tile.dart';
import 'package:cine_buddy/src/models/groups/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    context.read<GroupBloc>().add(FetchNotification());
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
              "Notifications",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 22.0),
            ),
          ),
          leadingWidth: 200.0,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              BlocConsumer<GroupBloc, GroupState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is FetchNotificationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FetchNotificationSuccess) {
                    final successState = state as FetchNotificationSuccess;
                    List<Map<String, dynamic>> groups =
                        successState.group as List<Map<String, dynamic>>;
                    return SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: groups.length,
                        itemBuilder: (context, index) =>
                            RequestTile(groups[index]),
                      ),
                    );
                  } else if (state is FetchNotificationFailure) {
                    final failureState = state as FetchNotificationFailure;
                    return Center(
                      child: Text(failureState.error),
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
