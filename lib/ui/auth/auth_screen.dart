import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/admin/admin_screen.dart';
import 'package:flutter_application_1/ui/auth/auth_register.dart';
import 'auth_register.dart';
import 'auth_manager.dart';
import '../../ui/products/products_overview_screen.dart';


class AuthScreen extends StatefulWidget {

  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  late String txtemail, txtpassword;

  final AuthManager _authManager = AuthManager();

    void _login() async {
    try{
      await _authManager.login(txtemail, txtpassword);
      if( await _authManager.check_admin(txtemail, 'admin')){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => ProductsOverviewScreen())
      ); 

      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => AdminScreen())
        );   
      }     
    } catch(error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                            ),
                            labelText: 'Email'
                          ),
                          onSaved: (value){
                            txtemail = value!;
                          },
                          validator: validateEmail,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                            ),
                            labelText: 'Password'
                          ),
                          onSaved: (value){
                            txtpassword = value!;
                          },
                          validator: validatePassword,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: (){
                                  if(_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                  }
                                  _login();
                                },
                                child: Text('Login'),
                                
                              ),
                            )
                          ],
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NewRegister()));
                          },
                          child: Text('Create a new account'),
                        ),
                      ],
                    ),
                  ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }





  String? validateEmail(String? email) {
    if(email!.isEmpty) {
      return 'Enter email address';
    } else {
      return null;
    }
  }

  String? validatePassword(String? password) {
    if(password!.isEmpty) {
      return 'Enter password';
    } else {
      return null;
    }
  }
}
