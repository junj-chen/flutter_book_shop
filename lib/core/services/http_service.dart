import 'package:dio/dio.dart';

import 'config.dart';

class HttpRequest {
  // 基本设置
  static final BaseOptions baseOptions = BaseOptions(
      baseUrl: HttpConfig.baseUrl, connectTimeout: HttpConfig.timeout);

  // 设置为静态，开始就创建一个 dio对象
  static final Dio dio = Dio(baseOptions);

  static Future<T> request<T>(String url,
      {String methoed = "get",
      Map<String, dynamic> params,
      Interceptor myinter}) async {
    // 1. 创建单独配置
    final option = Options(method: methoed);

    // 全局的拦截器
    // 创建默认的全局拦截器
    Interceptor dinter = InterceptorsWrapper(onRequest: (request) {
      print("请求拦截！！！！");

      // 请求拦截
      return request;
    }, onResponse: (response) {
      print("响应拦截！！！！");
      return response;
    }, onError: (err) {
      print("错误拦截！！！！");
      return err;
    });

    List<Interceptor> inters = [dinter];

    // 判断是否传入了拦截器
    if (myinter != null) {
      // 加入拦截器数组
      inters.add(myinter);
    }

    // 同意添加到拦截器中
    dio.interceptors.addAll(inters);

    // 2. 发送网络请求
    try {
      Response response =
          await dio.request(url, queryParameters: params, options: option);
      return response.data;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }
}
