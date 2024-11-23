import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_image_name_provider.g.dart';

@riverpod
class SelectedImageName extends _$SelectedImageName {

  @override
  String build() {
    return "/assets/chat_background/whatslab4everyone_default.jpg";
  }

  void setImageName(String imageName) {
    state = imageName;
  }

}
