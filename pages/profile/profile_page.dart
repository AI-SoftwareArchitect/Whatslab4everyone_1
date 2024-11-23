import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatslab4everyone_1/components/whatslab_textfield.dart';
import 'package:whatslab4everyone_1/providers/current_user_provider.dart';

import '../../components/whatslab4_bottom_navigation_bar.dart';
import '../../services/profile_service/set_profile_picture_rename.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String? profilePicPath;

  Widget _buildInfoRow(String label, String value, Color textColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: textColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }



  Future<String?> setProfilePicture() async {
    String newProfilePicPath = await ProfileImageService.pickProfilePictureFromGallery();
    if (newProfilePicPath.isNotEmpty) {
      setState(() {
        profilePicPath = newProfilePicPath;
      });
      return newProfilePicPath;
    }
    return null;
  }

  Future<bool> uploadProfilePicture() async {
        bool isUploaded = await ProfileImageService.uploadProfileImage(profilePicPath ?? "");
        return isUploaded;
  }

  Widget _buildProfilePicture() {
    if (profilePicPath != null && profilePicPath!.isNotEmpty) {
      return ClipOval(
        child: Image.file(
          File(profilePicPath!),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.person, size: 100, color: Colors.green);
          },
        ),
      );
    }
    return const Icon(Icons.person, size: 100, color: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProviderProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        leading: const SizedBox(),
        title: const Center(child: Text("Profile  ", style: TextStyle(fontWeight: FontWeight.bold))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: const Icon(Icons.settings, size: 32, color: Colors.white),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 4,
          vertical: 20.0,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: _buildProfilePicture(),
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
                onPressed: () {
                  setProfilePicture().then((pic) {
                    if (pic != null){
                      uploadProfilePicture().then((isUploaded) {
                        if (isUploaded) {
                          print("uploaded!");
                        }
                        else {
                          print("upload has failed!");
                        }
                      });
                    }
                  });

                },
                child: const Icon(Icons.photo)
            ),
            const SizedBox(height: 10),
            _buildInfoRow("ID", user.id, Colors.black87),
            _buildInfoRow("Username", user.username, Colors.green),
            _buildInfoRow("Password", user.password, Colors.red),
            _buildInfoRow("Email", user.email, Colors.blue),
          ],
        ),
      ),
      bottomNavigationBar: const Whatslab4BottomNavigationBar(),
    );
  }
}