import '../../ui/shared/size_fit.dart';

// 扩展 double 的方法
extension DoubleFit on double {
  // // 对setPx进行扩展
  // double px() {
  //   return HYSizeFit.setPx(this);
  // }

  // // 对setRpx进行扩展
  // double rpx() {
  //   return HYSizeFit.setRpx(this);
  // }

  double get px {
    return XHSizeFit.setPx(this);
  }

  double get rpx {
    return XHSizeFit.setRpx(this);
  }
}
