import 'package:doctor_opinion/services/doctor/Registeration.dart';
import 'package:flutter/material.dart';

class UserNameWidget extends StatefulWidget {
  const UserNameWidget({required Function this.vadliateUsername});
  final Function vadliateUsername;
  @override
  State<StatefulWidget> createState() {
    return _UserNameWidget();
    throw UnimplementedError();
  }
}

class _UserNameWidget extends State<UserNameWidget> {
  String _username = "";
  bool _vusername = false;
  Widget? status = null;
  final _controller = TextEditingController();
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _controller,
        onChanged: (username) async {
          if (username.isNotEmpty) {
            _username = username;
            setState(() {
              status = CircularProgressIndicator();
            });
            bool res = await DoctorRegisterationApi.validateUsername(username);
            if (res == true) {
              setState(() {
                status = Icon(Icons.check);

                _vusername = res;
                widget.vadliateUsername(username, res);
              });
            } else {
              setState(() {
                status = Icon(Icons.close);

                _vusername = res;

                widget.vadliateUsername(username, res);
              });
            }
          }
        },
        decoration: InputDecoration(
            errorText: _username.isEmpty
                ? null
                : _vusername
                    ? "username already exist"
                    : null,
            label: const Text("username"),
            suffix: status),
      ),
    );
  }
}
