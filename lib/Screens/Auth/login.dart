import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:settle_loans/Screens/Auth/signup.dart';
import '../../Components/shared_prefs.dart';
import '../../Constrains/textstyles.dart';
import '../Client/client_data.dart';
import '../Client/client_home.dart';
import '/Components/icons.dart';
import '/Constrains/Buttons.dart';
import '/Constrains/colors.dart';
import '/Constrains/textfields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
//  SignUp  with Email Ad Password
  signInHandler() async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _EmailController.text.trim(),
        password: _PasswordController.text.trim(),
      )
          .then((value) {
        ConnectToDb(value);
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

// Signup with Google

  signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) => {ConnectToDb(value)});
    } on PlatformException catch (e) {
      print('Platform Exception');
      print(e);
    } catch (e) {
      print('Catch Exception');
      print(e);
    }
  }

  ConnectToDb(value) {
    FirebaseFirestore.instance
        .collection('userDetails')
        .doc(value.user?.uid)
        .get()
        .then((doc) {
      if (doc.data() == null) {
        putBool('profileComplete', false);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ClientDataScreen1(),
            ),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ClientHome(),
            ),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg_Yellow,
        elevation: 0,
        title: LogoBlack,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign In to get a consultation',
                  style: HeadingTextStyle1(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ButtonWithIcon(
                  leading: Container(
                    height: 35,
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: IconGoogle,
                  ),
                  text: 'Sign in with Google',
                  centerTitle: true,
                  onPressed: signInWithGoogle),
              SizedBox(
                height: 25,
              ),
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Divider(
                      endIndent: 5,
                    )),
                    Text("OR"),
                    Expanded(
                        child: Divider(
                      indent: 5,
                    )),
                  ]),
              TextField_1(
                controller: _EmailController,
                label: 'Email',
              ),
              const SizedBox(
                height: 30,
              ),
              TextField_1(
                controller: _PasswordController,
                label: 'Password ',
                obscure: true,
              ),
              SizedBox(
                height: 38,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Color(0xFF636363),
                      fontSize: 16,
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF4285F4),
                        fontSize: 16,
                        fontFamily: GoogleFonts.rubik().fontFamily,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        height: 0.10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 80),
                color: bg_Yellow,
                width: MediaQuery.of(context).size.width,
                child: SizedBox(
                  height: 60,
                  child: RoundedButton1(
                    text: 'Sign In',
                    onPressed: signInHandler,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
