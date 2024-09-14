import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/view/screens/user_side/order_history_screen/widgets/completed_orders.dart';
import 'package:godrive/view/screens/user_side/order_history_screen/widgets/pending_order.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          toolbarHeight: 20,
          surfaceTintColor: white,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          bottom: const TabBar(
            automaticIndicatorColorAdjustment: true,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: 'Completed Orders'),
              Tab(text: 'Pending Orders'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CompletedOrdersTab(),
            PendingOrdersTab(),
          ],
        ),
      ),
    );
  }
}
