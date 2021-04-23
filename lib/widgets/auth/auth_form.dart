import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String name,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final bool _isLoading;
  AuthForm(this.submitFn, this._isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  var _isLogin = true;
  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _isLogin ? 'SIGN IN,' : 'SIGN UP',
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            _isLogin ? 'WELCOME BACK!' : 'PLEASE!',
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('Name'),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                    decoration: InputDecoration(
                      hintText: 'Name',
                      filled: true,
                      fillColor: Theme.of(context).primaryColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length < 3) {
                        return 'Please enter atleast 3 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                SizedBox(height: 20),
                TextFormField(
                  key: ValueKey('Email'),
                  focusNode: _emailFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Theme.of(context).primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  key: ValueKey('Password'),
                  focusNode: _passwordFocusNode,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Theme.of(context).primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      // 7 is firebase default
                      return 'Password must be atleast 7 characters long.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value;
                  },
                ),
                if (!widget._isLoading)
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'New user? Sign up here!'
                          : 'Already signed up? login here!',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                SizedBox(height: 20),
                if (widget._isLoading) CircularProgressIndicator(),
                if (!widget._isLoading)
                  OutlinedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(2),
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                    onPressed: _trySubmit,
                    // () {
                    //   if (_isLogin) {
                    //     Navigator.of(context)
                    //         .pushReplacementNamed(HomeScreen.routeName);
                    //     _isLogin = false;
                    //   } else {
                    //     setState(() {
                    //       _isLogin = true;
                    //     });
                    //   }
                    // },
                    child: Container(
                      child: Text(
                        'JUMP IN',
                        style: TextStyle(
                          // color: Theme.of(context).primaryColor,
                          fontSize: 24,
                          fontFamily: 'Lequire',
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
