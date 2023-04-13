import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarComponent extends StatelessWidget{
  const AppBarComponent({super.key});

  @override
  Widget build(BuildContext context){
    return AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFFFFFFF),
            automaticallyImplyLeading: false,
            leadingWidth: 40,
            leading: TextButton(
              onPressed: () {},
              child: Icon(Icons.favorite_rounded,
                                color: Colors.green
                              ),
            ),

            title: const Text("Hello Friend!",style: TextStyle(color: Colors.black),),
          );
  }
}