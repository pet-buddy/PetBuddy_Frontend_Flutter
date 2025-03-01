import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';

class MainScreen extends ConsumerWidget {
  final Widget child;

  const MainScreen({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreenIndex = ref.watch(bottomNavProvider);
    
    return DefaultLayout(
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: CustomColor.white,
          highlightColor: CustomColor.white,
        ),
        child: BottomNavigationBar(
            selectedLabelStyle: const TextStyle(fontSize: 12,),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: CustomColor.black,
            unselectedItemColor: CustomColor.labelAssistiveBlack,
            backgroundColor: CustomColor.white,
            elevation: 1.0,
            currentIndex: currentScreenIndex,
            onTap: (index) {
              // 인덱스 상태 갱신
              ref.read(bottomNavProvider.notifier).set(index);
              // 화면 이동
              if (index == 0) {
                context.goNamed('home_screen');
              } else if (index == 1) {
                // TODO : 카메라 호출
              } else if (index == 2) {
                context.goNamed('shop_screen');
              }
            },
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: SvgPicture.asset(
                  'assets/icons/outlined/home_icon_outlined.svg',
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/filled/home_icon_filled.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Camera',
                icon: SvgPicture.asset(
                  'assets/icons/outlined/camera_icon_outlined.svg',
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/filled/camera_icon_filled.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Shop',
                icon: SvgPicture.asset(
                  'assets/icons/outlined/shopping_icon_outlined.svg',
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/filled/shopping_icon_filled.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ]),
      ),
      child: PopScope(
        canPop: false, 
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          // await fnClose(context);
        },
        child: child
      ),
    );
  }
}
