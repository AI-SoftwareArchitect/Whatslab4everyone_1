import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child:Text("Settings")),
      ),
      body: ListView(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/account');
            },
            child: const Row(
              children: [
                Icon(Icons.account_box),
                SizedBox(width: 16),
                Text("Account", style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/privacy');
            },
            child: const Row(
              children: [
                Icon(Icons.privacy_tip),
                SizedBox(width: 16),
                Text("Privacy", style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
            child: const Row(
              children: [
                Icon(Icons.favorite),
                SizedBox(width: 16),
                Text("Favorites", style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/change_chat_background_page');
            },
            child: const Row(
              children: [
                Icon(Icons.image),
                SizedBox(width: 16),
                Text("Chat Background", style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
            child: const Row(
              children: [
                Icon(Icons.notification_add),
                SizedBox(width: 16),
                Text("Notifications", style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
