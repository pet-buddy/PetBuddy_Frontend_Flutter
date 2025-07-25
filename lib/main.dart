import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:petbuddy_frontend_flutter/common/layout/default_behavior.dart';
import 'package:petbuddy_frontend_flutter/route/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      scrollBehavior: DefaultScrollBehavior(), // Web 가로 스크롤 인식
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: WidgetStateProperty.all(kIsWeb),
        ),
        scaffoldBackgroundColor: CustomColor.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        /* inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: CustomColor.gray04),
          ),
          hintStyle: TextStyle(color: CustomColor.extraDarkGray),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: CustomColor.primaryBlue100),
          ),
        ), */
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: CustomColor.black,
        ),
        textTheme: const TextTheme().apply(
          bodyColor: CustomColor.black, 
        ),
      ),
      //폰트 크기 고정
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          // 웹일 경우, 웹이 아니더라도 화면이 큰 경우
          child: kIsWeb
            ? Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColor.blue03,
                      image: MediaQuery.of(context).size.width >= ProjectConstant.WEB_RESPONSIVE_WIDTH ? 
                        const DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(
                            'assets/icons/etc/web_banner.png'
                          ), 
                        ) :
                        null,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MediaQuery.of(context).size.width >= ProjectConstant.WEB_RESPONSIVE_WIDTH ? 
                        MainAxisAlignment.end :
                        MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: (MediaQuery.of(context).size.width >= ProjectConstant.WEB_MAX_WIDTH ? ProjectConstant.WEB_MAX_WIDTH : MediaQuery.of(context).size.width),
                          ),
                          margin: MediaQuery.of(context).size.width >= ProjectConstant.WEB_RESPONSIVE_WIDTH ? 
                            const EdgeInsets.only(right: 200) :
                            const EdgeInsets.only(right: 0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: CustomColor.gray04..withValues(alpha: 0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: child!
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : child!,
        );
      },
    );
  }
}
