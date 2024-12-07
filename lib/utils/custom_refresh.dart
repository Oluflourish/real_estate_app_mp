import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomRefresh extends StatefulWidget {
  final Widget child;
  final Function() refreshAction;
  final Color? color;

  const CustomRefresh({
    super.key,
    required this.child,
    required this.refreshAction,
    this.color = Colors.grey,
  });

  @override
  State<CustomRefresh> createState() => _CustomRefreshState();
}

class _CustomRefreshState extends State<CustomRefresh> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      header: ClassicHeader(
        textStyle: TextStyle(color: widget.color),
        refreshingIcon: SizedBox(
          width: 25.0,
          height: 25.0,
          child: Platform.isIOS
              ? CupertinoActivityIndicator(color: widget.color)
              : CircularProgressIndicator(
                  strokeWidth: 2.0, color: widget.color),
        ),
        failedIcon: Icon(Icons.error, color: widget.color),
        completeIcon: Icon(Icons.done, color: widget.color),
        idleIcon: Icon(Icons.arrow_downward, color: widget.color),
        releaseIcon: Icon(Icons.refresh, color: widget.color),
      ),
      child: widget.child,
      onRefresh: () async {
        await widget.refreshAction();
        _refreshController.refreshCompleted();
      },
    );
  }
}
