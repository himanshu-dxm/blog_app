import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/admin/admin_home.dart';
import 'package:flutter_blog/services/auth.dart';
import 'package:flutter_blog/utils/CommonUtils.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool isLoading = false;


  signIn() async {

    await Firebase.initializeApp();

    if(formKey.currentState!.validate()) {

      setState(() {
        isLoading = true;
      });

      authMethods.signInWithEmailAndPassword(
          emailController.text,
          passwordController.text
      ).then((value) => {
        if(value==1) {
          ScaffoldMessenger.of(context).
      showSnackBar(
          SnackBar(
              content: Text(
                  "No user found for that email."
              )
          ))
        } else if(value==2) {
          ScaffoldMessenger.of(context).
          showSnackBar(
          SnackBar(
              content: Text(
                  "Wrong password provided for that user."
              )
          ))
        } else if(value!=null) {
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminHome()))
        } else {
          ScaffoldMessenger.of(context).
          showSnackBar(
              SnackBar(content: Text("Check Your Credentials Properly")))
        }
      });
    }
  }

  signMeUp() {
    if(formKey.currentState!.validate()) {
      Map<String,String> userMap = {
        "email" : emailController.text,
        "password": passwordController.text,
      };

      setState(() {
        isLoading=true;
      });

      authMethods.signUpWithEmailAndPassword(
          emailController.text,
          passwordController.text,
          userMap
      ).then((value) => print(value));

      // databaseMethods.uploadUserInfo(userMap);
      // HelperFunctions.saveUserLoggedInSharedPreference(true);
      // Navigator.pushReplacementNamed(context, MyRoutes.signinRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonUtils.myAppBar("Admin","Login"),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Form(
            key:formKey ,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!) ?
                    null : "Enter correct email";
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                    alignLabelWithHint:true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 2
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  validator: (value) {
                    if(value!.length < 6) {
                      return "It should be atleast 6 characters in length";
                    } else if(value.isEmpty) {
                      return "Enter Password";
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password ",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                    alignLabelWithHint:true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 2
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
              ],
            ),
          ),
          SizedBox(height: 15,),
          GestureDetector(
            onTap: () {
              signIn();
              // signMeUp();
            },
            child: Container(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xff07EF4),
                          const Color(0xff2A75BC)
                        ]
                    ),
                    border: Border.all(
                        color: Colors.red
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                // margin: EdgeInsets.only(left: 50,right: 50,top: 30),
                // width: 100,
                // height: 50,
                width: MediaQuery.of(context).size.width*0.60,
                padding: EdgeInsets.symmetric(vertical: 18,),
                child: Center(
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.yellowAccent,
                        )
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: 15,),
          SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
