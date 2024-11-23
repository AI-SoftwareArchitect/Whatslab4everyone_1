import 'dart:io';
import 'dart:js_interop';
import 'package:http_parser/http_parser.dart'; // Bu import'u ekleyin
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:whatslab4everyone_1/services/shared_preference_service/shared_preference_manager.dart';

class ProfileImageService {
  static const String baseUrl = "http://10.0.2.2:3000/profile";

  static Future<String> pickProfilePictureFromGallery() async {
    try {
      final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (returnedImage == null) return "";

      final directory = await getApplicationDocumentsDirectory();
      final newPath = '${directory.path}/profile_images/';

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = path.extension(returnedImage.path).toLowerCase();
      final newFileName = 'profile_$timestamp$extension';

      final newFile = File(path.join(newPath, newFileName));

      await newFile.parent.create(recursive: true);
      await newFile.writeAsBytes(await returnedImage.readAsBytes());

      return newFile.path;
    } catch (e) {
      print('Error picking image: $e');
      return "";
    }
  }

  static Future<bool> uploadProfileImage(String imagePath) async {
    try {
      final url = Uri.parse('$baseUrl/set-profile-image');
      var request = http.MultipartRequest('POST', url);

      final SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
      final token = sharedPreferenceManager.getJWT_TOKEN();

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // Dosya uzantısını al
      final extension = path.extension(imagePath).toLowerCase();

      // MIME tipini belirle
      String mimeType;
      switch (extension) {
        case '.jpg':
        case '.jpeg':
          mimeType = 'image/jpeg';
          break;
        case '.png':
          mimeType = 'image/png';
          break;
        default:
          throw Exception('Unsupported file type');
      }

      // MultipartFile oluştururken MIME tipini belirt
      final file = await http.MultipartFile.fromPath(
        'profile_image',
        imagePath,
        filename: path.basename(imagePath),
        contentType: MediaType.parse(mimeType),
      );

      request.files.add(file);



      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Upload successful');
        return true;
      } else {
        print('Error uploading image: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Upload failed: $e');
      return false;
    }
  }
}