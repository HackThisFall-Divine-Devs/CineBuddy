import 'dart:convert';

import 'package:cine_buddy/main.dart';
import 'package:cine_buddy/src/models/groups/group.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestTile extends StatefulWidget {
  final Map<String, dynamic> group;
  RequestTile(this.group, {super.key});

  @override
  State<RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  Future<void> handleRequest(
      String groupId, String requestId, String action) async {
    final url = Uri.parse(
        'https://cine-buddy-backend.vercel.app/api/rooms/$groupId/handle-request/$requestId');

    final token = await MyApp().getAuthToken();

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3MmY1YWY2N2NiOTJlODE1MDIyMjdiNCIsImlhdCI6MTczMTE1NjcyNiwiZXhwIjoxNzMxMjQzMTI2fQ.N9TDVizIS2OS4fR_TK3EK8R9Du_U6cl7r8Iailt6irk',
        },
        body: jsonEncode({"action": action}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success']) {
          print('Request $action successful');
        } else {
          print('Failed to $action request: ${responseData['message']}');
        }
      } else {
        print('Failed to $action request: ${response.statusCode}');
      }
    } catch (e) {
      print('Error handling request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: ColorSys.kgrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo6wCUSmJEK9kC5KVqmQczHMH3OMcc_9BTTQ&s',
                      fit: BoxFit.fill,
                      height: 60.0,
                      width: 60.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.group["groupName"]!,
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 18.0, color: ColorSys.kwhite),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Request to Join',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14.0, color: ColorSys.ksecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      print(widget.group);
                      handleRequest(widget.group["groupId"],
                          widget.group["requestId"], "approve");
                    },
                    icon: Icon(Icons.check_circle, color: ColorSys.kprimary),
                  ),
                  IconButton(
                    onPressed: () {
                      handleRequest(widget.group["groupId"],
                          widget.group["requestId"], "reject");
                    },
                    icon: Icon(Icons.cancel, color: ColorSys.ksecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
