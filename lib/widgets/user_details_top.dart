import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserDetailsTop extends StatelessWidget {
  UserDetailsTop(
      {super.key, required this.userName, required this.userImageUrl});
  final String userName;
  final String userImageUrl;
  final DateFormat formatter = DateFormat('EEEE , MMMM');
  final DateFormat dayFormat = DateFormat('dd');

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = formatter.format(now);
    String formattedDay = dayFormat.format(now);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 28,
              foregroundColor: Colors.grey.shade400,
              foregroundImage: NetworkImage(userImageUrl),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello, $userName",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade900)),
                Text(
                  "$formattedDate $formattedDay",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade900),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
