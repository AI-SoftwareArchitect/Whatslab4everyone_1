import 'package:flutter/material.dart';

class Whatslab4FriendRequest extends StatelessWidget {
  final String senderName;
  final String senderUUID;
  final VoidCallback onPressedAccept;
  final VoidCallback onPressedReject;

  const Whatslab4FriendRequest({
    super.key,
    required this.senderUUID,
    required this.senderName,
    required this.onPressedAccept,
    required this.onPressedReject
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "name: $senderName",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "userid: $senderUUID",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 105,
            child: ElevatedButton(
              onPressed: onPressedReject,
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.red),
              ),
              child: const Text(
                "REJECT",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 105,
            child: ElevatedButton(
              onPressed: onPressedAccept,
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
              ),
              child: const Text(
                "ACCEPT",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}