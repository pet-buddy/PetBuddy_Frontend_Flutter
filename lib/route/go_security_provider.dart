import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoSecurityState extends StateNotifier<bool> {
  GoSecurityState() : super(false) {
    _loadPreference();
  }

  static const _preferenceKey = 'goSecurity';

  void set(bool value) {
    state = value;
    _savePreference();
  }

  bool get() => state;

  Future<bool> fnCheckLoginStatus(WidgetRef ref) async {
    final storage = ref.watch(secureStorageProvider);

    final accessToken = await storage.read(key: ProjectConstant.ACCESS_TOKEN);
    state = (accessToken != null && accessToken.isNotEmpty);
    
    return state;
  }

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool(_preferenceKey) ?? false;
    state = saved;
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_preferenceKey, state);
  }
}

final goSecurityProvider = 
  StateNotifierProvider<GoSecurityState, bool>((ref) => GoSecurityState());