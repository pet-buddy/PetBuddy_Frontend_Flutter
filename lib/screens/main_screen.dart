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

    final location = GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    final currentIndex = () {
      if (location.startsWith('/home_screen')) return 0;
      if (location.startsWith('/camera_upload_screen')) return 1;
      if (location.startsWith('/shop_screen')) return 2;
      if (location.startsWith('/my_screen')) return 3;
      return 0;
    }();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bottomNavProvider.notifier).set(currentIndex);
    });
    
    return DefaultLayout(
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: CustomColor.white,
          highlightColor: CustomColor.white,
        ),
        child: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: fnGetDeviceWidth(context),
              ),
              child: BottomNavigationBar( 
                  key: bottomNavKey,
                  selectedLabelStyle: const TextStyle(fontSize: 12,),
                  unselectedLabelStyle: const TextStyle(fontSize: 12),
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: CustomColor.yellow03,
                  unselectedItemColor: CustomColor.gray03,
                  backgroundColor: CustomColor.white,
                  elevation: 5.0,
                  currentIndex: currentScreenIndex,
                  onTap: (index) {
                    // 화면 이동
                    if (index == 0) {
                      context.goNamed('home_screen');
                    } else if (index == 1) {
                      context.goNamed('camera_upload_screen');
                    } else if (index == 2) {
                      // context.goNamed('shop_screen');
                      context.pushNamed('preorder_screen');
                      return; // 임시 : 사전예약 페이지 클릭할 때만 인덱스 상태 갱신 비활성화, shop_screen 이동 시 삭제 예정
                    } else if (index == 3) {
                      context.goNamed('my_screen');
                    }
                    
                    // ref.read(bottomNavProvider.notifier).set(index); // 인덱스 상태 갱신
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: SvgPicture.asset(
                        'assets/icons/navigation/home.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(CustomColor.gray03, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navigation/home.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(CustomColor.yellow03, BlendMode.srcIn),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Camera',
                      icon: SvgPicture.asset(
                        'assets/icons/navigation/camera.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(CustomColor.gray03, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navigation/camera.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(CustomColor.yellow03, BlendMode.srcIn),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Shop',
                      icon: SvgPicture.asset(
                        'assets/icons/navigation/shopping.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(CustomColor.gray03, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navigation/shopping.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(CustomColor.yellow03, BlendMode.srcIn),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Profile',
                      icon: SvgPicture.asset(
                        'assets/icons/navigation/user.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(CustomColor.gray03, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navigation/user.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(CustomColor.yellow03, BlendMode.srcIn),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
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
