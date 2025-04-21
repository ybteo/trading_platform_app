import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/signuppage.dart';
import 'package:trading_app/widget/bottom_navi_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Image.asset('assets/logo/trade_sampleLogo.png', width: 150, height: 150)
                ),
                const SizedBox(height: 30),
                const Text(('Email'), style: heading4Bold),
                  const SizedBox(height: 5),
                  TextField(
                    onChanged: (value){
                      setState(() {
                        //_isEmailValid = _isEmailValidFunction(value);
                      });
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: blue.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,                
                      ),
                      isDense: true,
                      hintText: 'Email',
                      hintStyle: bodyMRegular,
                      prefixIcon: const Icon(Icons.message),
                     
                    ),
                  ),
          
                  const SizedBox(height: 25),
          
                  const Text('Password', style: heading4Bold),
                  const SizedBox(height: 5),
                  TextField(
                    onChanged:(value){
                      setState(() {
                        //_isPasswordValid = _isPasswordValidFunction(value);
                      });
                    },
                    controller: passwordController,
                    obscureText: !_isVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: _isVisible? const Icon(Icons.visibility):const Icon(Icons.visibility_off),
                      ),
                      filled: true,
                      fillColor: blue.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,                
                      ),
                      isDense: true,
                      hintText: 'Password',
                      hintStyle: bodyMRegular,
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 85.0),
          
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: (){
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => const BottomNaviBar(isNewUser: false),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => blue.shade700),
                            fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(35)),
                          ),
                          child: const Text(
                            'Log in', 
                            style: bodyMBold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have account?', style: bodySRegular.copyWith(color: grey.shade600),),
                      TextButton(
                        onPressed: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => const SignUpPage()),
                          );
                        }, 
                        child: Text('Sign up now', style: bodySRegular.copyWith(color: blue.shade800),),
                      ),
                    ],
                  ),
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}