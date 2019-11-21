import 'dart:math';
import 'package:flutter/material.dart';

import 'package:constructor_rajuma/src/models/sucursal_model.dart';
import 'package:constructor_rajuma/src/providers/sucursal_provider.dart';
import 'package:constructor_rajuma/src/providers/empleado_provider.dart';
import 'package:constructor_rajuma/src/models/empleado_model.dart';
import 'package:constructor_rajuma/src/utils/utils.dart';

class AgregarEmpleadoPage extends StatefulWidget {
  _AgregarEmpleadoPageState createState() => _AgregarEmpleadoPageState();
}

class _AgregarEmpleadoPageState extends State<AgregarEmpleadoPage> {
  final _empleado = EmpleadoModel();
  final _provider = EmpleadoProvider();
  final _txtController = TextEditingController();
  final _keyScaEmp = GlobalKey<ScaffoldState>();
  final _keyFormEmp = GlobalKey<FormState>();
  final _providerSuc = SucursalProvider();
  String _opcion = 'Seleccione una sucursal...';
  //tring _opcionDetras = '';
  String _opcionDetras = '';
  @override
  Widget build(BuildContext context) {
    final idSuc = ModalRoute.of(context).settings.arguments;
    //0 -> nombre, 1 -> Id
    //final List<String> arg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: _keyScaEmp,
      appBar: AppBar(
        title: Text(
          //'Agregar Herramienta Sucursal ${arg[0]}',
          'Agregar Nuevo Empleado',
          //style: TextStyle(fontSize: 14.0),
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
                      _txtController.text = generarCodEmp();
                    }
                  });
                  _hacerSubmit(idSuc);
                },
                child: Text('Agregar Empleado'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearForm() {
    return Form(
      key: _keyFormEmp,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: <Widget>[
            _crearNomE(),
            _crearIdE(),
            SizedBox(height: 20.0,),
            _crearEncargadoSuc(),
            //_crearDisp(),
          ],
        ),
      ),
    );
  }

  Widget _crearNomE() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nombre Empleado',
        icon: Icon(Icons.person_add),
        hintText: 'Juan Salas Perez',
      ),
      onSaved: (valor) {
        _empleado.nombre = valor;
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

  Widget _crearIdE() {
    return TextFormField(
      //keyboardType: TextInputType,
      textCapitalization: TextCapitalization.words,
      enabled: false,
      controller: _txtController,
      decoration: InputDecoration(
          labelText: 'Código de empleado',
          icon: Icon(Icons.spellcheck),
          hintText: 'emp001'),
      onSaved: (valor) {
        //print(valor);
        _empleado.idEmpleado = valor;
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

  Widget _crearEncargadoSuc() {
    return FutureBuilder(
      future: getSucursalBD(),
      builder:
          (BuildContext context, AsyncSnapshot<List<SucursalModel>> snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<SucursalModel>(
            hint: Text(_opcion),
            items: snapshot.data
                .map((val) => DropdownMenuItem<SucursalModel>(
                      child: Text(val.nombre),
                      value: val,
                    ))
                .toList(),
            onChanged: (opt) {
              setState(() {
                _opcion = opt.nombre;
                _opcionDetras = opt.idSucursal;
              });
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<SucursalModel>> getSucursalBD() async {
    List<SucursalModel> supervisores = List();

    supervisores = await _providerSuc.cargarSucursales();

    return supervisores;
  }

  /*Widget _crearDisp() {
    return SwitchListTile(
      title: Text('Disponible'),
      onChanged: (val) {
        setState(() {
          _disponible = val;
          _empleado.disponible = val;
        });
      },
      value: _disponible,
    );
  }*/

  Future<bool> _hacerSubmit(String id) async {
    if (!_keyFormEmp.currentState.validate()) return false;

    _keyFormEmp.currentState.save();

    //print("$_opcionDetras detras");

    _empleado.idSucursal = _opcionDetras;

    mostrarAlertaProgreso(context, 'Cargando...');
    if (await _provider.agregarEmpleado(_empleado)) {
      Navigator.of(context).pop();
      Future.delayed(Duration(milliseconds: 500)).whenComplete(() {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
      return true;
    } else {
      Navigator.of(context).pop();
      mostrarSnackbar(_keyScaEmp, 'Ocurrió un error, intente otra vez');
      return false;
    }
  }

  String generarCodEmp() {
    Random r = new Random();
    //String c = '';
    String usuario = 'emp';

    usuario += r.nextInt(99999).toString();

    return usuario;
  }
}
