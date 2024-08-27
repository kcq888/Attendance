import 'package:attendance/src/common_widgets/responsive_center.dart';
import 'package:attendance/src/constants/breakpoints.dart';
import 'package:attendance/src/constants/constants.dart';
import 'package:attendance/src/repositories/attendance_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _season = '';

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      ref
          .read(SharedPrefStringNotifier.provider(SEASON_KEY).notifier)
          .setString(SEASON_KEY, _season!);
    }
    Navigator.of(context, rootNavigator: true).pop(true);
  }

  void _loadPreferences() async {
    final String? season =
        ref.read(SharedPrefStringNotifier.provider(SEASON_KEY));
    setState(() {
      _season = season;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.settingsTitle),
          actions: <Widget>[
            TextButton(
                onPressed: () => _submit(),
                child: Text(AppLocalizations.of(context)!.saveSetting,
                    style: const TextStyle(fontSize: 18, color: Colors.blue)))
          ],
        ),
        body: SingleChildScrollView(
          child: ResponsiveCenter(
              maxContentWidth: Breakpoint.tablet,
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildSettingForm(),
                ),
              )),
        ));
  }

  Widget _buildSettingForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Season Name'),
            keyboardAppearance: Brightness.light,
            initialValue: _season,
            validator: (value) =>
                (value ?? '').isNotEmpty ? null : 'Season must not be empty',
            onSaved: (value) => _season = value,
          )
        ],
      ),
    );
  }
}
