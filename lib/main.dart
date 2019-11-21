import 'package:flutter/material.dart';

//import 'package:constructor_rajuma/src/utils/con.dart';

import 'package:constructor_rajuma/src/pages/agregar_empleado_page.dart';
import 'package:constructor_rajuma/src/pages/ver_empleados_page.dart';
import 'package:constructor_rajuma/src/pages/ver_herramientas_page.dart';
import 'package:constructor_rajuma/src/preferences/preferencias_usuario.dart';
import 'package:constructor_rajuma/src/pages/login_page.dart';
import 'package:constructor_rajuma/src/pages/home_page.dart';
import 'package:constructor_rajuma/src/pages/agregar_sucursal_page.dart';
import 'package:constructor_rajuma/src/pages/agregar_herramienta_page.dart';
import 'package:constructor_rajuma/src/pages/agregar_encargado_page.dart';
import 'package:constructor_rajuma/src/pages/ver_encargados_page.dart';

void main() async {
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  //await initCon();
  /*final con = new Con();
  con.initCon();*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zeos App',
      initialRoute: (_prefs.token == null) ? 'login' : 'home',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'ver_herramientas': (BuildContext context) => VerHerramientasPage(),
        'agregar_herramienta': (BuildContext context) => AgregarHerramientaPage(),
        'agregar_sucursal': (BuildContext context) => AgregarSucursalPage(),
        'agregar_encargado': (BuildContext context) => AgregarEncargadoPage(),
        'agregar_empleado': (BuildContext context) => AgregarEmpleadoPage(),
        'ver_encargados': (BuildContext context) => VerEncargadosPage(),
        'ver_empleados': (BuildContext context) => VerEmpleadosPage(),
      },
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(185, 221, 237, 1.0),
        primaryColor: Color.fromRGBO(60, 112, 164, 1.0),
        //accentColor: Color.fromARGB(a, r, g, b),
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Color.fromRGBO(217, 238, 236, 1.0)),
        ),
        ////buttonColor: Theme.of(context).primaryColor
        ////buttonColor: Color.fromRGBO(60, 112, 164, 1.0),
        buttonTheme: ButtonThemeData(
            buttonColor: Color.fromRGBO(60, 112, 164, 1.0),
            textTheme: ButtonTextTheme.primary,
            disabledColor: Colors.grey),
        ////appBarTheme: Color.fromRGBO(185, 221, 237, 1.0),
        ////scaffoldBackgroundColor: Color.fromRGBO(185, 221, 237, 1.0),
      ),
    );
  }
}
