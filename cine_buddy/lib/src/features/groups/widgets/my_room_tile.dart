import 'dart:convert';

import 'package:cine_buddy/main.dart';
import 'package:cine_buddy/src/common_widgets/theme_button.dart';
import 'package:cine_buddy/src/models/groups/group.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MyRoomTile extends StatefulWidget {
  final Group group;
  final String userId;
  MyRoomTile(this.group, this.userId, {super.key});

  @override
  State<MyRoomTile> createState() => _MyRoomTileState();
}

class _MyRoomTileState extends State<MyRoomTile> {
  Future<void> sendJoinRequest(BuildContext context) async {
    final String roomId = widget.group.id;
    final url = Uri.parse(
        'https://cine-buddy-backend.vercel.app/api/rooms/$roomId/request-join');
    final token = MyApp().getAuthToken();

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3MmY1YWY2N2NiOTJlODE1MDIyMjdiNCIsImlhdCI6MTczMTE1NjcyNiwiZXhwIjoxNzMxMjQzMTI2fQ.N9TDVizIS2OS4fR_TK3EK8R9Du_U6cl7r8Iailt6irk',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Request sent successfully'),
            backgroundColor: ColorSys.kgrey,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Failed to send request'),
            backgroundColor: ColorSys.kgrey,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          backgroundColor: ColorSys.kgrey,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: ColorSys.kgrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://image.tmdb.org/t/p/original${widget.group.movie.posterPath}",
                  fit: BoxFit.cover,
                  height: 180.0,
                ),
              ),
            ),
            // Group details on the right
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Group Name
                    Text(
                      widget.group.groupName ?? 'Group Name',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4.0),
                    // Movie Name
                    Text(
                      widget.group.movieName ?? 'Movie Name',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16.0),
                    ),
                    const SizedBox(height: 4.0),
                    // Genre
                    Text(
                      'Genre: ${widget.group.genre ?? 'Unknown'}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 14.0),
                    ),
                    const SizedBox(height: 4.0),
                    // Members Limit
                    Text(
                      'Members: ${widget.group.membersLimit ?? 'N/A'}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 14.0),
                    ),
                    const SizedBox(height: 4.0),
                    // Date and Time
                    Text(
                      'Date: ${widget.group.date?.toLocal().toString().split(' ')[0] ?? 'TBD'}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 14.0),
                    ),
                    Text(
                      'Time: ${widget.group.timePreference ?? 'Anytime'}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 14.0),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        SizedBox(
                          height: 24.0,
                          child: ElevatedButton(
                            onPressed: () =>
                                startOrJoinStream(widget.userId, widget.group),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorSys
                                  .ksecondary, // Customize the color as needed
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // Rounded edges
                              ),
                            ),
                            child: Text(
                              widget.group.createdBy.id == widget.userId
                                  ? 'Start Stream'
                                  : "Join Stream",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Text color
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startOrJoinStream(String userId, Group group) async {
    String url;

    if (group.createdBy.id == userId) {
      url =
          'https://cine-buddy-backend.vercel.app/api/rooms/${group.id}/start-stream';
      final token = await MyApp().getAuthToken();
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final jitsiLink = data['jitsiLink'];

        if (await canLaunchUrl(Uri.parse(jitsiLink))) {
          await launchUrl(jitsiLink);
        } else {
          debugPrint("Could not launch $jitsiLink");
        }
      } else {
        print(response.body);
        debugPrint("Failed to fetch link: ${response.statusCode}");
      }
    } else {
      url = 'https://cine-buddy-backend.vercel.app/api/users/stream-link';
    }
  }
}