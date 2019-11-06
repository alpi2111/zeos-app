import 'dart:math';
import 'package:flutter/material.dart';

import 'package:constructor_rajuma/src/models/supervisor_model.dart';
import 'package:constructor_rajuma/src/providers/supervisor_provider.dart';
import 'package:constructor_rajuma/src/utils/utils.dart';

class AgregarEncargadoPage extends StatefulWidget {
  _AgregarEncargadoPage createState() => _AgregarEncargadoPage();
}

class _AgregarEncargadoPage extends State<AgregarEncargadoPage> {
  final GlobalKey<FormState> _formEncargado = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldEncargado =
      new GlobalKey<ScaffoldState>();
  final _supervisorModel = new SupervisorModel();
  final _provider = SupervisorProvider();
  //final GlobalKey<EditableTextState> _keyTxtPass = new GlobalKey<EditableTextState>();
  final _textEditingControllerUsuario = new TextEditingController();
  final _textEditingControllerPass = new TextEditingController();
  //String genPass = '';
  final lista = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldEncargado,
      appBar: AppBar(
        title: Text('Agregar Encargado'),
      ),
      body: _crearForm(),
    );
  }

  Widget _crearForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formEncargado,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: <Widget>[
              _crearNombreEncargado(),
              _crearUsuarioEncargado(),
              // SizedBox(
              //   height: 15.0,
              // ),
              _crearLabeContra(),
              SizedBox(
                height: 30.0,
              ),
              _btnCrearContra(),
              SizedBox(
                height: 10.0,
              ),
              _btnSubmit()
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearNombreEncargado() {
    return TextFormField(
      validator: (value) {
        if (value == '') {
          return 'Debe ingresar Datos';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        _supervisorModel.nombre = value;
      },
      decoration: InputDecoration(
          labelText: 'Nombre del encargado', icon: Icon(Icons.person)),
    );
  }

  Widget _crearUsuarioEncargado() {
    return TextFormField(
      validator: (value) {
        if (value == '') {
          return 'Debe ingresar Datos';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        _supervisorModel.idSupervisor = value;
      },
      enabled: false,
      controller: _textEditingControllerUsuario,
      decoration: InputDecoration(
          //enabled: false,
          labelText: 'Usuario del encargado',
          //helperText: 'hola',
          icon: Icon(Icons.supervisor_account),
          hintText: 'sup123'),
    );
  }

  Widget _crearLabeContra() {
    return TextFormField(
      validator: (value) {
        if (value == '') {
          return 'Debe ingresar Datos';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        _supervisorModel.password = value;
      },
      decoration:
          InputDecoration(labelText: 'Contraseña', icon: Icon(Icons.lock)),
      controller: _textEditingControllerPass,
      enabled: false,
    );
  }

  Widget _btnCrearContra() {
    return RaisedButton(
      color: Colors.purple,
      onPressed: () {
        setState(() {
          //genPass = generarPassword();
          _textEditingControllerPass.text = generarPassword();
          if (_textEditingControllerUsuario.text == '')
            _textEditingControllerUsuario.text = generarUsuario();
        });
      },
      child: Text('Generar Usuario y Contraseña'),
    );
  }

  Widget _btnSubmit() {
    return RaisedButton(
      onPressed: () {
        _validarForm();
      },
      child: Text('Registrar Usuario'),
    );
  }

  _validarForm() async {
    if (!_formEncargado.currentState.validate()) {
      mostrarSnackbar(_scaffoldEncargado, 'Algo anda mal xd');
      return false;
    }

    _formEncargado.currentState.save();

    mostrarAlertaProgreso(_scaffoldEncargado.currentContext, 'Cargando...');
    final dataLog = await _provider.nuevoLoginSupervisor(_supervisorModel);
    //print(dataLog['token']);
    _supervisorModel.idToken = dataLog['token'];
    //print(_supervisorModel.idToken);
    if (dataLog['ok']) {
      final data = await _provider.agregarSupervisor(_supervisorModel);

      if (data != null) {
        Navigator.of(_scaffoldEncargado.currentContext, rootNavigator: true)
            .pop('dialog');
      }
      if (data['ok']) {
        mostrarAlerta(_scaffoldEncargado.currentContext, 'Correcto', 'El encargado se agrego de manera exitosa, ahora puede asignarle una sucursal e iniciar sesión');
        await Future.delayed(Duration(seconds: 5));
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        await Future.delayed(Duration(milliseconds: 500));
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
      } else {
        Navigator.of(_scaffoldEncargado.currentContext, rootNavigator: true)
            .pop('dialog');
        mostrarAlerta(context, 'Información',
            'Sin conexión a internet para iniciar sesión. Conéctese a internet e intente nuevamente');
      }
    } else {
      Navigator.of(_scaffoldEncargado.currentContext, rootNavigator: true)
          .pop('dialog');
      mostrarAlerta(context, 'Error', 'El encargado ya existe');
    }
  }

  String generarPassword() {
    Random r = new Random();
    String c = '';
    String pass = '';

    for (int i = 0; i < 8; i++) {
      c = lista[r.nextInt(lista.length - 1)];
      if (r.nextBool()) {
        c = c.toUpperCase();
      }
      pass += c;
    }

    return pass;
  }

  String generarUsuario() {
    Random r = new Random();
    //String c = '';
    String usuario = 'sup';

    usuario += r.nextInt(999).toString();

    return usuario;
  }
}
