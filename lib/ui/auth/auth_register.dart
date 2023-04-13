import 'package:flutter/material.dart';

import 'auth_manager.dart';
import '../../ui/products/products_overview_screen.dart';

class NewRegister extends StatefulWidget{
  _NewRegister createState() => _NewRegister();
  
}

class _NewRegister extends State<NewRegister>{


    final AuthManager _authManager = AuthManager();
    void _saveItem() async {
    try{
      await _authManager.signUp(txtemail, txtpassword);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => ProductsOverviewScreen())
      );
    } catch(error) {
      print(error);
    }
  }

  final role = 'user';
  void _saveItem2() async {
    if (txtname == null || txtemail == null || txtpassword == null) {
    print('Invalid input');
    return;
  }
    try{
      await _authManager.signUp2(txtname!, txtemail!, txtpassword!, role);
              
    } catch(error) {
      print(error);
    }
  }

  final _formKey = GlobalKey<FormState>();
  late String txtname, txtemail, txtpassword, txtrole='';

  final _name = TextEditingController();
  final _email= TextEditingController();
  final _password = TextEditingController();

  void _resetItem(){
    _name.clear();
    _email.clear();
    _password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Create a new account'),
      ),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
          children: [
            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                labelText: 'Name'
              ),
              onSaved: (value){
                txtname = value!;
              },
              validator: validateName,
            ),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
              onSaved: (value){
                txtemail = value!;
              },
              validator: validateEmail,
            ),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              onSaved: (value){
                txtpassword = value!;
              },
              validator: validatePassword,
            ),
            // DropdownButtonFormField(
            //   decoration: InputDecoration(
            //     labelText: 'Role',
            //   ),
            //   value: txtrole.isNotEmpty ? txtrole : null,
            //   items: <String>['User', 'Admin']
            //     .map<DropdownMenuItem<String>>((String value){
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //     }).toList(),
            //     onChanged: (value) {
            //       setState(() {
            //         txtrole = value.toString();
            //       });
            //     },
            // ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      _resetItem();
                    },
                    child: Text('Reset'),
                                
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // _saveItem();
                        _saveItem2();
                        _saveItem();
                      }
                    },
                    child: Text('Sign up'),
                                
                  ),
                )
              ],
            ),
          ],
        ),
        ),
      ),
      ),
    );
  }

  String? validateName(String? name) {
    if(name!.isEmpty) {
      return 'Enter your name';
    }
    else {
      return null;
    }
  }

  String? validateEmail(String? email) {
    if(email!.isEmpty) {
      return 'Enter your email';
    }
    else {
      return null;
    }   
  }

  String? validatePassword(String? password) {
    if(password!.isEmpty) {
      return 'Enter your password';
    }
    else {
      return null;
    }  
  }
}