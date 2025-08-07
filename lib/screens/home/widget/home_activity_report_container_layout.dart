import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';

class HomeActivityReportContainerLayout extends StatelessWidget {
  const HomeActivityReportContainerLayout({
    super.key,
    required this.child
  });

  final Widget child;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(
        minWidth: 344,
        minHeight: 196,
      ),
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: const BorderRadius.all(Radius.circular(16),),
        boxShadow: [
          BoxShadow(
            color: CustomColor.gray04..withValues(alpha: 0.0),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 0),
          )
        ],
      ),
      child: child,
    );
  }
}
