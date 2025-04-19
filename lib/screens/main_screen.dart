import 'package:flutter/foundation.dart';
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
        child: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: fnGetDeviceWidth(context),
              ),
              child: BottomNavigationBar( 
                  selectedLabelStyle: const TextStyle(fontSize: 12,),
                  unselectedLabelStyle: const TextStyle(fontSize: 12),
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: CustomColor.black,
                  unselectedItemColor: CustomColor.gray04,
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
                      kIsWeb ?                  
                        context.pushNamed('camera_upload_screen') :
                        null;
                    } else if (index == 2) {
                      // context.goNamed('shop_screen');
                      context.goNamed('preorder_screen');
                    } else if (index == 3) {
                      context.goNamed('my_screen');
                    }
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: SvgPicture.asset(
                        'assets/icons/navigation/home_icon_outlined.svg',
                        width: 24,
                        height: 24,
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navigation/home_icon_filled.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Camera',
                      icon: SvgPicture.asset(
                        'assets/icons/navigation/camera_icon_outlined.svg',
                        width: 24,
                        height: 24,
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navigation/camera_icon_filled.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Shop',
                      icon: SvgPicture.asset(
                        'assets/icons/navigation/shopping_icon_outlined.svg',
                        width: 24,
                        height: 24,
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navigation/shopping_icon_filled.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Profile',
                      icon: SvgPicture.asset(
                        'assets/icons/navigation/profile_icon_outlined.svg',
                        width: 24,
                        height: 24,
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navigation/profile_icon_filled.svg',
                        width: 24,
                        height: 24,
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
