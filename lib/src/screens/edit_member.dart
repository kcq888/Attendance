import 'package:attendance/src/common_widgets/responsive_center.dart';
import 'package:attendance/src/constants/breakpoints.dart';
import 'package:attendance/src/models/member.dart';
import 'package:attendance/src/screens/edit_member_screen_controller.dart';
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
        title: Text(widget.member == null ? 'New Member' : 'Edit Member'),
        actions: <Widget>[
          TextButton(
              onPressed: () => _submit(),
              child: const Text('Save',
                  style: TextStyle(fontSize: 18, color: Colors.white)))
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
              decoration: const InputDecoration(labelText: 'First Name'),
              keyboardAppearance: Brightness.light,
              initialValue: _firstname,
              validator: (value) =>
                  (value ?? '').isNotEmpty ? null : 'Name can\'t be empty',
              onSaved: (value) => _firstname = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Last Name'),
              keyboardAppearance: Brightness.light,
              initialValue: _lastname,
              validator: (value) =>
                  (value ?? '').isNotEmpty ? null : 'Name can\'t be empty',
              onSaved: (value) => _lastname = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'RFID'),
              keyboardAppearance: Brightness.light,
              initialValue: _rfid,
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              onSaved: (value) => _rfid,
            ),
          ],
        ));
  }
}
