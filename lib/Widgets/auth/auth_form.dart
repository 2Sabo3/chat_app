import 'dart:io';

import 'package:chatapp/Widgets/image_picker/cricle_avatar.dart';
import 'package:flutter/material.dart';

class Authform extends StatefulWidget {
  Authform(this.submitfn, this.isLoading);

  final void Function(
    String username,
    String email,
    String password,
    File image,
    bool isLogin,
    BuildContext context,
  ) submitfn;
  final bool isLoading;
  @override
  _AuthformState createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final _formkey = GlobalKey<FormState>();

  var isLogin = true;
  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';
  File _userImage;

  void _pickedimage(File image) {
    _userImage = image;
  }

  void trysubmit() {
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_userImage == null && !isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Pick an Image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid) {
      _formkey.currentState.save();
      widget.submitfn(
        _userName.trim(),
        _userEmail.trim(),
        _userPassword.trim(),
        _userImage,
        isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.deepOrange,
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isLogin) Cricle(_pickedimage),
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please Enter the Correct Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: ('Email Address'),
                          labelStyle: TextStyle(color: Colors.white)),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    if (!isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Please Enter a Username of atleast 4 chatacters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: ('User Name'),
                            labelStyle: TextStyle(color: Colors.white)),
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Please Enter a Password of atleast 7 chatacters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: ('Password'),
                          labelStyle: TextStyle(color: Colors.white)),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      // ignore: deprecated_member_use
                      RaisedButton(
                        padding: EdgeInsets.all(10),
                        color: Colors.purple[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: trysubmit,
                        child: Text(
                          isLogin ? 'Login' : 'SignUp',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    if (!widget.isLoading)
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(
                          isLogin ? 'Create a New Account' : 'Have An Account?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
