
import 'device_type.dart';

class ResponsiveManager {
  double width;
  double height;
  DeviceType deviceType = DeviceType.mediumPhone;

  ResponsiveManager({
    required this.width,
    required this.height,
  }) {
    deviceType = _detectDeviceType();
  }

  bool isPhone() {
    if (deviceType == DeviceType.smallPhone || deviceType == DeviceType.mediumPhone || deviceType == DeviceType.largePhone) {
      return true;
    }
    return false;
  }

  DeviceType _detectDeviceType() {
    if (width <= 320) {
      return DeviceType.smallPhone;
    } else if (width <= 480) {
      return DeviceType.mediumPhone;
    } else if (width <= 768) {
      return DeviceType.largePhone;
    } else if (width <= 1024) {
      return DeviceType.tablet;
    } else if (width <= 1440) {
      return DeviceType.desktop;
    } else {
      return DeviceType.tv;
    }
  }

}