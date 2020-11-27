import 'package:flutter/material.dart';

class XHOrderScreen extends StatefulWidget {
  static final String routeName = "/order";
  int currentIndex = 0;
  XHOrderScreen({this.currentIndex});

  @override
  _XHOrderScreenState createState() => _XHOrderScreenState();
}

class _XHOrderScreenState extends State<XHOrderScreen>
    with SingleTickerProviderStateMixin {
  // 构建controller
  TabController _tabController;

  // 展示的内容列表
  final List<Tab> _titleList = [
    Tab(text: "待付款"),
    Tab(text: "待发货"),
    Tab(text: "待收货"),
    Tab(text: "待退款"),
  ];

  @override
  void initState() {
    // 初始化 tapBar
    // print("index: ----------------------------------${widget.currentIndex}");
    // 页面传递的值
    if (widget.currentIndex == null) {
      widget.currentIndex = 0;
    }
    _tabController = new TabController(
        length: _titleList.length,
        vsync: this,
        // 上一页面传值
        initialIndex: widget.currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单中心"),
        centerTitle: true,
        bottom: TabBar(
          tabs: _titleList,
          controller: _tabController,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildObligation(),
          _buildToSendGoods(),
          _buildWaitForGoods(),
          _buildForRefund(),
        ],
      ),
    );
  }

  // 待付款页面
  Widget _buildObligation() {
    return Center(
      child: Text("暂无待付款订单"),
    );
  }

  // 待发货页面
  Widget _buildToSendGoods() {
    return Center(
      child: Text("暂无待发货订单"),
    );
  }

  // 待收货页面
  Widget _buildWaitForGoods() {
    return Center(
      child: Text("暂无待收货订单"),
    );
  }

  // 待退款页面
  Widget _buildForRefund() {
    return Center(
      child: Text("暂无待退款订单"),
    );
  }
}
