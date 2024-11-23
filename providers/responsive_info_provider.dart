
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatslab4everyone_1/responsive/device_type.dart';

import '../responsive/responsive_info/responsive_info.dart';

part 'responsive_info_provider.g.dart';

@riverpod
class ResponsiveInfoProvider extends _$ResponsiveInfoProvider {
  @override
  ResponsiveInfo build() {
    return ResponsiveInfo();
  }

  void setIsPhone(bool isPhone) {
    state.isPhone = isPhone;
  }

  void setDeviceType(DeviceType deviceType) {
    state.deviceType = deviceType;
  }
}