import 'dart:ui';

class XHSizeFit {
  /**
   * 通过使用 window 去获取屏幕的参数
   * 
   */

  static double physicalWidth;
  static double physicalHeight;
  static double dpr;
  static double screenWidth;
  static double screenHeight;
  static double statusHeight;

  // 使用 rpx做屏幕适配
  static double rpx;

  static double px;

  // 传入默认的参数
  static void initialize({double standardSize = 750}) {
    // 1. 获取物理分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    // 2. 获取dpr
    dpr = window.devicePixelRatio;

    // 3. 获取宽度和高度
    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;

    // 4. 状态栏的高度
    statusHeight = window.padding.top / dpr;

    // 5. 计算rpx的大小
    rpx = screenWidth / standardSize;

    px = screenWidth / standardSize * 2;
  }

  // 使用 rpx 为单位
  static double setRpx(double size) {
    return rpx * size;
  }

  // 以 px 为单位
  static double setPx(double size) {
    return px * size;
  }
}
