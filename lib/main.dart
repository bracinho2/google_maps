import 'package:flutter/material.dart';
import 'package:google_maps/mapa.dart';
import 'package:google_maps/reponsivity.dart';
import 'package:google_maps/triple_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoogleMaps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class LoginPage extends StatelessWidget {
  final String title;
  const LoginPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Responsive(mobile: MobileLogin(), desktop: DesktopLogin()),
    );
  }
}

class MobileLogin extends StatelessWidget {
  const MobileLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10.0, 80.0, 0.0, 0.0),
                child: const Text(
                  'Hola',
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15.0, 150.0, 0.0, 0.0),
                child: const Text(
                  'Que tal',
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(320.0, 150.0, 0.0, 0.0),
                child: const Text(
                  '\u00A1',
                  style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                const TextField(
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10, top: 30),
                      isDense: true,
                      labelText: 'Usuário',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                    child: const Text(
                      'Esqueci a senha.',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                  height: 50.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      child: const Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GoogleMaps()));
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(
                            child: Icon(Icons.phone),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: Text(
                              'LOGIN COM TELEFONE',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TripleMap()));
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'É novo por aqui\u00BF ',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Registre-se.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          //decoration: TextDecoration.underline,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DesktopLogin extends StatelessWidget {
  const DesktopLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 40.0, 0.0, 0.0),
                    child: const Text(
                      'Hola',
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 150.0, 0.0, 0.0),
                    child: const Text(
                      'Que tal',
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(320.0, 150.0, 0.0, 0.0),
                    child: const Text(
                      '\u00A1',
                      style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    const TextField(
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10, top: 30),
                          isDense: true,
                          labelText: 'Usuário',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: const Text(
                          'Esqueci a senha.',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    SizedBox(
                      height: 50.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          child: const Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            print('On Login =>');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Center(
                                child: Icon(Icons.phone),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Text(
                                  'LOGIN COM TELEFONE',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            print('Login with Phone!');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'É novo por aqui\u00BF ',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Registre-se.',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              //decoration: TextDecoration.underline,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
