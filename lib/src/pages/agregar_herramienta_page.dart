import 'package:flutter/material.dart';

class AgregarHerramientaPage extends StatefulWidget {
  _AgregarHeramietaPageState createState() => _AgregarHeramietaPageState();
}

class _AgregarHeramietaPageState extends State<AgregarHerramientaPage> {
  @override
  Widget build(BuildContext context) {
    final List<String> arg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Herramienta Sucursal ${arg[0]}', style: TextStyle(fontSize: 15.0),),
      ),
    );
  }
}
