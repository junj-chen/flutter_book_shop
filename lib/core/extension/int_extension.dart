import '../../ui/shared/size_fit.dart';

// 扩展 double 的方法
extension DoubleFit on int {
  double get px {
    return XHSizeFit.setPx(this.toDouble());
  }

  double get rpx {
    return XHSizeFit.setRpx(this.toDouble());
  }
}
