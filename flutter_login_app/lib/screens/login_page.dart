import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_validator/string_validator.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../bloc/login_bloc/login_event.dart';
import '../bloc/login_bloc/login_state.dart';
import '../test/home_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String tag = 'login-page';

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const blueColor = Color(0xff4b85ec);
  //instance of Login Bloc
  final _loginBloc = LoginBloc();

//controllers for text fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String country = "Select Country";

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      //providing login bloc
      create: (context) {
        return _loginBloc;
      },
      child: BlocListener<LoginBloc, LoginState>(
//providing listener for login bloc
        listener: (context, state) {
          if (state is LoginValidation) {
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content: Text("${state.value}", style: const TextStyle(color: Colors.red),),
            ));
          }
          if (state is LoginLoaded) {
            //if successfully credentials matches the loaded state called
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Successfully Logged in", style: TextStyle(color: Colors.green),),
            ));
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return  HomePage(); //push to HomeScreen
              },
            ));
          }
        },
       child: Scaffold(
         backgroundColor: Colors.white,
         body: Center(
           child: ListView(
             shrinkWrap: true,
             padding: const EdgeInsets.only(left: 24.0, right: 24.0),
             children: <Widget>[
               _logo(),
               const SizedBox(height: 48.0),
               _email(),
               const SizedBox(height: 8.0),
               _password(),
               const SizedBox(height: 8.0),
               pickCountry(),
               const SizedBox(height: 24.0),
               _button(),

             ],
           ),
         ),
       ),
      ),
    );

  }

  Widget _logo(){
    return Hero(
      tag: 'logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/img.png'),
      ),
    );
  }
  Widget _email(){
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
        validator: (value){
          if (value == TextInputType.emailAddress){
            if (!isEmail(value!)) return 'Enter valid email';
          }
          return null;
        },
      decoration: InputDecoration(
        hintText: 'Email',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
  Widget _password(){
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      controller: passwordController,
      validator: (value){
        if (value == TextInputType.visiblePassword){
          if (value!.length !=  8) return 'Your password should be 8 characters long';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        focusedBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
  Widget _button(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child:  ElevatedButton(
          style: ButtonStyle(
              elevation:
              const MaterialStatePropertyAll(6),
              backgroundColor:
              const MaterialStatePropertyAll(
                  blueColor),
              shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(6)))),
          onPressed: () {
            setState(() {
              //adding event on Widget OnPressed Method
              _loginBloc.add(GetLogin(
                email: emailController.text,
                password: passwordController.text,
                context: context,
                country: country
              ));
            });
            emailController.clear();
            passwordController.clear();
            country="";
          },
          child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 15),
              child: const Text(
                'Login',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ))),
    );
  }
  Widget pickCountry(){
    return CSCPicker(
      showCities: false,
      showStates: false,
      onCountryChanged: (value) {
        setState(() {
          country = value;
        });
      },
      onStateChanged: (value) {
        setState(() {
          ///store value in state variable
          var stateValue = value;
        });
      },
      ///triggers once city selected in dropdown
      onCityChanged: (value) {
        setState(() {
          ///store value in city variable
          var cityValue = value;
        });
      },
      currentCountry: country,
    );
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
