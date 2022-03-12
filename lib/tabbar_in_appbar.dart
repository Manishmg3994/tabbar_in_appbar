library tabbar_in_appbar;

import 'package:flutter/material.dart';
import 'package:tabbar_in_appbar/md2indicator.dart';

// ignore: must_be_immutable
class CustomTab extends StatefulWidget implements PreferredSizeWidget {
  final void Function(int) onDone;
  final List<Widget> tabs;
  double? indicatorHeight;
  Color? indicatorColor;
  MD2IndicatorSize? indicatorSize;
  Color? labelColor;
  FontWeight? labelFontWeight;
  Color? unselectedLabelColor;
  bool? isScrollable;
  CustomTab({
    Key? key,
    required this.tabs,
    required this.onDone,
    this.indicatorHeight = 3,
    this.indicatorColor = Colors.green,
    this.indicatorSize = MD2IndicatorSize.full,
    this.labelColor = Colors.green,
    this.labelFontWeight = FontWeight.w700,
    this.unselectedLabelColor = Colors.black,
    this.isScrollable = true,
  }) : super(key: key);

  @override
  State<CustomTab> createState() => _CustomTabState();

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

class _CustomTabState extends State<CustomTab>
    with SingleTickerProviderStateMixin {
  late TabController tabcontroller;

  // final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: widget.tabs.length, vsync: this);
    tabcontroller.addListener(() {
      setState(() {
        widget.onDone(tabcontroller.index);
        tabcontroller.animateTo(tabcontroller.index);
      });
    });
  }

  @override
  void dispose() {
    tabcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabcontroller,
      labelStyle: TextStyle(
        fontWeight: widget.labelFontWeight,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: widget.labelColor,
      unselectedLabelColor: widget.unselectedLabelColor,
      isScrollable: widget.isScrollable!,
      indicator: MD2Indicator(
        indicatorHeight: widget.indicatorHeight!,
        indicatorColor: widget.indicatorColor!,
        indicatorSize: widget.indicatorSize!,
      ),
      tabs: widget.tabs,
    );
  }
}
