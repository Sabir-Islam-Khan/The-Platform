import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Screens/CreateAccount.dart';
import '../Services/MyAuth.dart';

class SignIn extends StatefulWidget {
  // authbase instance
  final MyAuthBase auth;
  SignIn({@required this.auth});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // value controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // signin  with mail method

  Future<void> _signInWithEmail(String mail, String password) async {
    try {
      widget.auth.signInWithEmail(mail, password);
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // total height and width constrains
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        // main body
        backgroundColor: Color.fromARGB(255, 38, 42, 66),

        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: totalHeight * 0.2,
              ),
              // sign in button
              Center(
                child: Text(
                  "The Platform",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: totalWidth * 0.08,
                  ),
                ),
              ),

              SizedBox(
                height: totalHeight * 0.04,
              ),
              // textfiled for email
              Container(
                width: totalWidth * 0.85,
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 111, 116, 255),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 111, 116, 255),
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 111, 116, 255),
                      ),
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                ),
              ),

              SizedBox(
                height: totalHeight * 0.03,
              ),
              // textfield for password
              Container(
                width: totalWidth * 0.85,
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 111, 116, 255),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 111, 116, 255),
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 111, 116, 255),
                      ),
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  controller: passwordController,
                ),
              ),
              SizedBox(
                height: totalHeight * 0.07,
              ),
              Center(
                // sign in button
                child: GestureDetector(
                  onTap: () {
                    String mail = emailController.value.text;
                    String password = passwordController.value.text;

                    print("mail is ..... $mail");
                    print("password is ..... $password");
                    _signInWithEmail(mail, password);

                    emailController.clear();
                    passwordController.clear();
                  },
                  child: Container(
                    // container for button
                    height: totalHeight * 0.08,
                    width: totalWidth * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color.fromARGB(255, 111, 116, 255),
                    ),
                    child: Center(
                      child: Text(
                          // button text
                          "Sign in",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: totalHeight * 0.07,
              ),
              // bottom section
              Row(
                children: [
                  SizedBox(
                    width: totalWidth * 0.2,
                  ),
                  Text(
                    "Don't have an account ?  ",
                    style: GoogleFonts.montserrat(
                      color: Color.fromARGB(255, 111, 116, 255),
                      fontSize: totalWidth * 0.038,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAccount(
                              // auth: widget.auth,
                              ),
                        ),
                      );
                    },
                    child: Text(
                      "Create One",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: totalWidth * 0.038,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
