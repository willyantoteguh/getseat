part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordVaild = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());

        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 4),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(text);
                        });
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Email Address",
                        hintText: "Email Address",
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isPasswordVaild = text.length >= 6;
                        });
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Password",
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        Text(
                          "Dont have an account? ",
                          style: greyTextFont.copyWith(
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Sign Up",
                          style: purpleTextFont,
                        ),
                      ],
                    ),
                     SizedBox(height: defaultMargin),
                    Center(
                      child: Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(top: 40, bottom: 30),
                          child: isSigningIn
                              ? SpinKitFadingCircle(
                                  color: mainColor,
                                )
                              : FloatingActionButton(
                                  elevation: 0,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: isEmailValid && isPasswordVaild
                                        ? Colors.white
                                        : Color(0xFFE4E4E4),
                                  ),
                                  backgroundColor:
                                      isEmailValid && isPasswordVaild
                                          ? mainColor
                                          : Color(0xFFE4E4E4),
                                  onPressed: isEmailValid && isPasswordVaild
                                      ? () async {
                                          setState(() {
                                            isSigningIn = true;
                                          });

                                          SignSignUpResult result =
                                              await AuthRepository.signIn(
                                                  emailController.text,
                                                  passwordController.text);

                                          if (result.user == null) {
                                            setState(() {
                                              isSigningIn = false;
                                            });

                                            Flushbar(
                                              duration: Duration(seconds: 4),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              backgroundColor:
                                                  Color(0xFFFF5C83),
                                              message: result.message,
                                            )..show(context);
                                          }
                                        }
                                      : null)),
                    ),
                  
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
