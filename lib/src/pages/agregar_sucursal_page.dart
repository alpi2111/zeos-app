import 'dart:math';
import 'package:flutter/material.dart';

import 'package:constructor_rajuma/src/models/sucursal_model.dart';
import 'package:constructor_rajuma/src/models/supervisor_model.dart';
import 'package:constructor_rajuma/src/providers/sucursal_provider.dart';
import 'package:constructor_rajuma/src/utils/utils.dart';
import 'package:constructor_rajuma/src/providers/supervisor_provider.dart';

class AgregarSucursalPage extends StatefulWidget {
  _AgregarSucursalPage createState() => _AgregarSucursalPage();
}

class _AgregarSucursalPage extends State<AgregarSucursalPage> {
  final GlobalKey<FormState> _formSucursal = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldSucursal =
      new GlobalKey<ScaffoldState>();
  String _opcion = 'Seleccione un encargado...';
  String _opcionDetras = '';
  final _supervisorProvider = new SupervisorProvider();
  final _sucursalModel = new SucursalModel();
  final _sucursalProvider = new SucursalProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldSucursal,
      appBar: AppBar(
        title: Text('Agregar Sucursal'),
      ),
      body: Container(
        child: _crearForm(),
      ),
    );
  }

  Widget _crearForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formSucursal,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: Column(
            children: <Widget>[
              _crearNombreSuc(),
              _crearDireccionSuc(),
              SizedBox(
                height: 30.0,
              ),
              _crearEncargadoSuc(),
              SizedBox(
                height: 30.0,
              ),
              _crearBtnSubmit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearNombreSuc() {
    return TextFormField(
      onSaved: (val) {
        _sucursalModel.nombre = val;
      },
      autocorrect: false,
      validator: (valor) {
        if (valor == '') {
          return 'Debe ingresar datos';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          labelText: 'Nombre de la Sucursal',
          icon: Icon(Icons.text_rotation_none)),
    );
  }

  Widget _crearDireccionSuc() {
    return TextFormField(
      onSaved: (val) {
        _sucursalModel.direccion = val;
      },
      autocorrect: false,
      validator: (valor) {
        if (valor == '') {
          return 'Debe ingresar datos';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          labelText: 'Dirección', icon: Icon(Icons.location_city)),
    );
  }

  Widget _crearEncargadoSuc() {
    return FutureBuilder(
      future: getEncargadosBD(),
      builder: (BuildContext context,
          AsyncSnapshot<List<SupervisorModel>> snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<SupervisorModel>(
            hint: Text(_opcion),
            items: snapshot.data
                .map((val) => DropdownMenuItem<SupervisorModel>(
                      child: Text(val.nombre),
                      value: val,
                    ))
                .toList(),
            onChanged: (opt) {
              setState(() {
                _opcion = opt.nombre;
                _opcionDetras = opt.idSupervisor;
              });
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<SupervisorModel>> getEncargadosBD() async {
    List<SupervisorModel> supervisores = List();

    supervisores = await _supervisorProvider.obtenerEncargados();

    return supervisores;
  }

  Widget _crearBtnSubmit() {
    return RaisedButton(
      onPressed: _hacerSubmit,
      child: Text(
        'Agregar',
        style: TextStyle(fontSize: 18.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 100.0),
    );
  }

  _hacerSubmit() async {
    if (!_formSucursal.currentState.validate()) {
      mostrarSnackbar(_scaffoldSucursal, 'Algo anda mal...');
      return false;
    }
    if (_opcionDetras == '') {
      mostrarSnackbar(_scaffoldSucursal, 'Debe Seleccionar un encargado');
      return false;
    }
    _formSucursal.currentState.save();

    _sucursalModel.idSucursal = generarSucursal();
    _sucursalModel.idSupervisor = _opcionDetras;

    if(await _sucursalProvider.agregarSucursal(_sucursalModel)) {
      mostrarAlerta(_scaffoldSucursal.currentContext, 'Agregado Correcto', 'Sucursal agregada correctamente');
      //return null;
      await Future.delayed(Duration(seconds: 3));
      if(Navigator.of(context).canPop())
        Navigator.of(context).pop();
      await Future.delayed(Duration(microseconds: 500));
      if(Navigator.of(context).canPop())
        Navigator.of(context).pop();
    } else {
      mostrarAlerta(_scaffoldSucursal.currentContext, 'Error', 'Ha ocurrido un error, verifique los datos e intente nuevamente por favor.');
    }

  }

  String generarSucursal() {
    Random r = new Random();
    String sucursal = 'suc';

    sucursal += r.nextInt(999).toString();

    return sucursal;
  }
}
