import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  // allows for overriding with an awaited future in main.dart before application startup
  throw UnimplementedError();
});

class SharedPrefStringNotifier extends StateNotifier<String?> {
  SharedPrefStringNotifier(this.sharedPreferences, this.str)
      : super(sharedPreferences.getString(str));

  final SharedPreferences sharedPreferences;
  final String str;

  static final provider =
      StateNotifierProvider.family<SharedPrefStringNotifier, String?, String>(
          (ref, str) {
    final prefs = ref.watch(sharedPreferencesProvider);
    return SharedPrefStringNotifier(prefs, str);
  });

  void setString(String field, String season) {
    state = season;
    sharedPreferences.setString(field, season);
  }
}
