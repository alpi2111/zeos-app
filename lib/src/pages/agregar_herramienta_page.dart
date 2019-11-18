import 'dart:math';

import 'package:constructor_rajuma/src/models/herramienta_model.dart';
import 'package:constructor_rajuma/src/providers/herramienta_provider.dart';
import 'package:constructor_rajuma/src/utils/utils.dart';
import 'package:flutter/material.dart';

class AgregarHerramientaPage extends StatefulWidget {
  _AgregarHeramietaPageState createState() => _AgregarHeramietaPageState();
}

class _AgregarHeramietaPageState extends State<AgregarHerramientaPage> {
  bool _disponible = true;
  final _herramienta = HerramientaModel();
  final _provider = HerramientaProvider();
  final _txtController = TextEditingController();
  final _keyScaHer = GlobalKey<ScaffoldState>();
  final _keyFormHerr = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //0 -> nombre, 1 -> Id
    final List<String> arg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: _keyScaHer,
      appBar: AppBar(
        title: Text(
          'Agregar Herramienta Sucursal ${arg[0]}',
          style: TextStyle(fontSize: 14.0),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _crearForm(),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (_txtController.text == '') {
                      _txtController.text = generarCodHerr();
                    }
                  });
                  _hacerSubmit(arg[1]);
                },
                child: Text('Agregar Herramineta'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearForm() {
    return Form(
      key: _keyFormHerr,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: <Widget>[
            _crearNomH(),
            _crearIdH(),
            _crearDisp(),
          ],
        ),
      ),
    );
  }

  Widget _crearNomH() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nombre Herramienta',
        icon: Icon(Icons.fitness_center),
        hintText: 'Pulidor',
      ),
      onSaved: (valor) {
        _herramienta.nombre = valor;
      },
      validator: (valor) {
        if (valor == "") {
          return 'Debe ingresar datos';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearIdH() {
    return TextFormField(
      //keyboardType: TextInputType,
      textCapitalization: TextCapitalization.words,
      enabled: false,
      controller: _txtController,
      decoration: InputDecoration(
          labelText: 'Código de herramienta',
          icon: Icon(Icons.spellcheck),
          hintText: 'her001'),
      onSaved: (valor) {
        //print(valor);
        _herramienta.idHerramienta = valor;
      },
      /*validator: (valor) {
        if (valor == "") {
          return 'Debe ingresar datos';
        } else {
          return null;
        }
      },*/
    );
  }

  Widget _crearDisp() {
    return SwitchListTile(
      title: Text('Disponible'),
      onChanged: (val) {
        setState(() {
          _disponible = val;
          _herramienta.disponible = val;
        });
      },
      value: _disponible,
    );
  }

  Future<bool> _hacerSubmit(String id) async {
    if (!_keyFormHerr.currentState.validate()) return false;

    _keyFormHerr.currentState.save();

    _herramienta.idSucursal = id;
    _herramienta.disponible = _disponible;

    mostrarAlertaProgreso(context, 'Cargando...');
    if (await _provider.agregarHerramienta(_herramienta)) {
      Navigator.of(context).pop();
      Future.delayed(Duration(milliseconds: 500)).whenComplete(() {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
      return true;
    } else {
      Navigator.of(context).pop();
      mostrarSnackbar(_keyScaHer, 'Ocurrió un error, intente otra vez');
      return false;
    }
  }

  String generarCodHerr() {
    Random r = new Random();
    //String c = '';
    String usuario = 'her';

    usuario += r.nextInt(9999).toString();

    return usuario;
  }
}
