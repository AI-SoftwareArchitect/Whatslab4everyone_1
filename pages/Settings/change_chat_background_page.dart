import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatslab4everyone_1/components/whatslab4_button.dart';
import 'package:whatslab4everyone_1/providers/selected_image_name_provider.dart';

class ChangeChatBackgroundPage extends ConsumerStatefulWidget {
  const ChangeChatBackgroundPage({super.key});

  @override
  ConsumerState<ChangeChatBackgroundPage> createState() => _ChangeChatBackgroundPageState();
}

class _ChangeChatBackgroundPageState extends ConsumerState<ChangeChatBackgroundPage> {
  List<String> allChatBackgroundImages = [];
  late Box<String> _box;

  @override
  void initState() {
    super.initState();
    loadSelectedImage();
    loadImages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedImageName = ref.watch(selectedImageNameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child:Text("Pick chat background image",style: TextStyle(color: Colors.green),)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: GridView.builder(
                itemCount: allChatBackgroundImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context,index) {
                  print(allChatBackgroundImages[index]);
                  return GestureDetector(
                    child:Container(
                      width: 200,
                      height: 600,
                      padding: const EdgeInsets.all(5.0),
                      color: selectedImageName == allChatBackgroundImages[index] ? Colors.green.withOpacity(0.7) : Colors.black.withOpacity(0.0),
                      child: allChatBackgroundImages[index].split("/")[0] == "assets" ? Image.asset(
                        "${allChatBackgroundImages[index]}",
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ) : Image.file(File(allChatBackgroundImages[index]),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,),
                    ),
                    onTap: () async {
                      await _box.put('sImage', allChatBackgroundImages[index]);
                      ref.read(selectedImageNameProvider.notifier).setImageName(allChatBackgroundImages[index]);
                    },
                  );
                },
              ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.grey
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 5,),
                Whatslab4Button(
                    onPressed: () async {
                        await _pickImageFromGallery();
                    },
                    color: Colors.white,
                    title: "Load Image",
                    fontSize: 16
                ),
                const SizedBox(height: 5,),
              ],
            ),
          )
        ],
      )
    );
  }

  Future<void> _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    // Uygulamanın belgeler dizinini al
    final directory = await getApplicationDocumentsDirectory();
    final newPath = '${directory.path}/external_backgrounds/';
    final newFile = File(newPath + returnedImage.name);

    // Klasörü oluştur
    await newFile.parent.create(recursive: true);

    // Resim dosyasını kaydet
    await newFile.writeAsBytes(await returnedImage.readAsBytes());

    setState(() {
      allChatBackgroundImages.add(newPath + returnedImage.name);
    });
  }


  Future<void> loadSelectedImage() async {
      _box = await Hive.openBox("selected_image_box");
      final sImage = ref.read(selectedImageNameProvider.notifier);
      sImage.setImageName(_box.get('sImage') ?? "assets/chat_background/whatslab4everyone_default.jpg");
  }

  Future<void> loadImages() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      setState(() {
        allChatBackgroundImages = manifestMap.keys
            .where((String key) => key.contains('assets/chat_background/'))
            .toList();
      });


    } catch (e) {
      print('Hata oluştu: $e');
    }
  }


}
