import 'package:flutter/cupertino.dart';
import 'package:xinhuashop/core/model/cart_model.dart';
import 'package:xinhuashop/core/services/json_parse.dart';

class XHCartViewModel extends ChangeNotifier {
  List<XHCartModel> _resList = [];
  bool selectAllcheck = false;

  // 构造函数，托管所有的数据
  XHCartViewModel(String name) {
    JsonParse.getCartData(name).then((value) {
      _resList = value;
      // 通知所有的调用者
      notifyListeners();
    });
  }

  // 获取所有的购物车数据
  List<XHCartModel> get cartList {
    return _resList;
  }

  // 减少某一个书籍的数量 count
  void deleteCartItemCount(int index) {
    // 发送网络请求 ----  成功后 进行 数量的减少
    print("index： $index");
    _resList[index].qty--;

    // 计算价格
    _resList[index].partMoney =
        (_resList[index].qty * double.parse(_resList[index].unitPrice))
            .toString();
    notifyListeners();
  }

  // 增加 某一个书籍的数量 count
  void addCartItemCount(int index) {
    // 发送网络请求 ----  成功后 进行 数量的增加
    print("index： $index");
    _resList[index].qty++;
    _resList[index].partMoney =
        (_resList[index].qty * double.parse(_resList[index].unitPrice))
            .toString();
    notifyListeners();
  }

  // 修改checkbox的 状态
  void changeCheckedBoxStatus(int index, bool newstatus) {
    print("index: $index");

    print("_resList[index].check ${_resList[index].check}");
    print("!_resList[index].check ${!_resList[index].check}");

    _resList[index].check = newstatus;
    notifyListeners();
  }

  // 删除商品
  void removeCartItem(index) {
    // 删除商品
    _resList.removeAt(index);
    notifyListeners();
  }

  // 全选的按钮控制
  void selectedAll(bool val) {
    selectAllcheck = val;
    _resList.forEach((element) {
      element.check = selectAllcheck;
    });
    notifyListeners();
  }
}
