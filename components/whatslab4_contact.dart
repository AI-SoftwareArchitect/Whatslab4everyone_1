import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:whatslab4everyone_1/components/whatslab4_text.dart';
import 'package:whatslab4everyone_1/pages/chat_direct_page.dart';

class Whatslab4Contact extends ConsumerWidget {
  final String name;
  final String imageName;
  final String contactUuid;
  final String bgImageName;

  Whatslab4Contact({
    super.key,
    required this.name,
    required this.imageName,
    required this.contactUuid,
    required this.bgImageName,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return GestureDetector(child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            colors: 
            [
              Colors.greenAccent.withOpacity(0.4),
              Colors.lightGreenAccent.withOpacity(0.4),
              Colors.greenAccent.withOpacity(0.4),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      margin: const EdgeInsets.symmetric(vertical: 7),
      child:
      Slidable(
        key: ValueKey(name), // Anahtar ekleniyor
        direction: Axis.horizontal,
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                // Silme işlemi
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              icon: Icons.delete,
              label: "Delete",
            ),
            SlidableAction(
              onPressed: (context) {
                // Profil işlemi
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              icon: Icons.person,
              label: "Profile",
            ),
          ],
        ),
        child: Row(
          children: [
            ClipOval(
              child: /*Image.asset("assets/images/empty_profile.png", width: 50, height: 50) ??*/ Icon(Icons.person),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Whatslab4Text(content: name, fontSize: 24),
            ),
          ],
        ),
      ),
    ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDirectPage(
              name: name,
              imageName: imageName,
              contactUUID: contactUuid,
              backgroundImageName: bgImageName,
            ),
          ),
        );
      },
    );
  }
}
