import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor ?? Colors.white,
        appBar: appBar,
        body: Container(
          // width: kIsWeb ? ProjectConstant.WEB_MAX_WIDTH : MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
            maxWidth: fnGetDeviceWidth(context),
          ),
          child: child
        ),
        bottomNavigationBar: bottomNavigationBar ?? const SizedBox(height: 0,),
        floatingActionButton: floatingActionButton,
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
