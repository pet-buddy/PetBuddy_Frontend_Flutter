import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  Widget _webWrap(Widget child) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: appBar,
      body: SizedBox(
        width: kIsWeb ? 600 : MediaQuery.of(context).size.width,
        child: child
      ),
      bottomNavigationBar: bottomNavigationBar ?? const SizedBox(height: 0,),
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: true,
    );
  }
}
