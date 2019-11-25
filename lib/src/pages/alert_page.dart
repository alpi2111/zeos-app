import 'package:flutter/material.dart';

import 'package:constructor_rajuma/src/models/empleado_model.dart';
import 'package:constructor_rajuma/src/providers/empleado_provider.dart';

class AlertPage extends StatefulWidget {
  static bool isYes = false;
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final _empProvider = EmpleadoProvider();

  String _opcion = 'Seleccione un empleado...';
  String _opDetras = '';

  @override
  Widget build(BuildContext context) {
    //bool si = false;
    return AlertDialog(
      title: Text('Prestar'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('¿A quien desea prestar la herramienta?'),
          SizedBox(height: 30.0),
          //Text('otre'),
          _crearEmpleados(),
          //aaa
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      actions: <Widget>[
        FlatButton(
            child: Text('Cancelar'),
            onPressed: () {
              AlertPage.isYes = false;
              Navigator.of(context).pop();
            }),
        FlatButton(
          child: Text('Si'),
          onPressed: () {
            AlertPage.isYes = true;
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _crearEmpleados() {
    //return Navigator.push(context, MaterialPageRoute());
    return FutureBuilder(
      future: getEmpleadosBD(),
      builder:
          (BuildContext context, AsyncSnapshot<List<EmpleadoModel>> snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: DropdownButton<EmpleadoModel>(
              hint: Text(_opcion),
              items: snapshot.data
                  .map((val) => DropdownMenuItem<EmpleadoModel>(
                        child: Text(val.nombre),
                        value: val,
                      ))
                  .toList(),
              onChanged: (opt) {
                setState(() {
                  _opcion = opt.nombre;
                  _opDetras = opt.idEmpleado;
                });
              },
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<EmpleadoModel>> getEmpleadosBD() async {
    List<EmpleadoModel> empleados = List();

    //empleados = await _empProvider.obtenerEmpleadoSucursal("suc322");
    empleados = await _empProvider.obtenerTodosEmpleados();

    return empleados;
  }
}
