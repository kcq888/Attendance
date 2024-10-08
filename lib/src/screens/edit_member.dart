import 'package:attendance/src/common_widgets/responsive_center.dart';
import 'package:attendance/src/constants/breakpoints.dart';
import 'package:attendance/src/models/member.dart';
import 'package:attendance/src/screens/edit_member_screen_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditMemberScreen extends ConsumerStatefulWidget {
  const EditMemberScreen({super.key, this.member});
  final Member? member;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditMemberScreenState();
}

class _EditMemberScreenState extends ConsumerState<EditMemberScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _firstname;
  String? _lastname;
  String? _rfid;

  @override
  void initState() {
    super.initState();
    if (widget.member != null) {
      _firstname = widget.member?.firstname;
      _lastname = widget.member?.lastname;
      _rfid = widget.member?.rfid;
    }
  }

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
      final success = await ref
          .read(editMemberScreenControllerProvider.notifier)
          .submit(widget.member,
              firstname: _firstname, lastname: _lastname, rfid: _rfid);

      if (success && mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.member == null
            ? AppLocalizations.of(context)!.newMember
            : AppLocalizations.of(context)!.editMember),
        actions: <Widget>[
          TextButton(
              onPressed: () => _submit(),
              child: Text(AppLocalizations.of(context)!.saveMember,
                  style: const TextStyle(fontSize: 18, color: Colors.blue)))
        ],
      ),
      body: _buildMemberEditContent(),
    );
  }

  Widget _buildMemberEditContent() {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildMemberForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildMemberForm() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.firstname),
              keyboardAppearance: Brightness.light,
              initialValue: _firstname,
              validator: (value) => (value ?? '').isNotEmpty
                  ? null
                  : AppLocalizations.of(context)!.nameCanntBeEmpty,
              onSaved: (value) => _firstname = value,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.lastname),
              keyboardAppearance: Brightness.light,
              initialValue: _lastname,
              validator: (value) => (value ?? '').isNotEmpty
                  ? null
                  : AppLocalizations.of(context)!.nameCanntBeEmpty,
              onSaved: (value) => _lastname = value,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.rfid),
              keyboardAppearance: Brightness.light,
              initialValue: _rfid,
              enabled: _rfid != null ? false : true,
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              onSaved: (value) => _rfid = value,
            ),
          ],
        ));
  }
}
