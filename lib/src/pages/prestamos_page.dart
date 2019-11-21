import 'package:constructor_rajuma/src/models/empleado_model.dart';
import 'package:constructor_rajuma/src/providers/empleado_provider.dart';
import 'package:constructor_rajuma/src/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:constructor_rajuma/src/providers/entrada_salida_provider.dart';

class PrestamosPage extends StatefulWidget {
  @override
  _PrestamosPageState createState() => _PrestamosPageState();
}

class _PrestamosPageState extends State<PrestamosPage> {
  final _provider = EntradaSalidaProvider();
  final _empProvider = EmpleadoProvider();

  String _opcion = 'Seleccione un empleado...';
  String _opcionDetras = '';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _provider.obtenerEnAlmacen(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.blueAccent,
                ),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  bool eliminar = await mostrarAlertaCerrarSesion(context,
                      'Prestar', '¿A quién desea prestar la herramienta?');
                  if (eliminar)
                    //await _provider.updateHerramientaDisponible(key, id, dispo)
                  return eliminar;
                },
                onDismissed: (a) {
                  print(a);
                },
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(snapshot.data[i]),
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }




  //la parte del alert
  Future<bool> mostrarAlertaSelEmpleado(BuildContext context, String titulo, String mensaje) async {
  bool si = false;
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Column(
            children: <Widget>[
              Text(mensaje),
              Text('otre'),
              _crearEmpleados(),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Si'),
              onPressed: () {
                si = true;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
  return si;
}

Widget _crearEmpleados() {
    return FutureBuilder(
      future: getEmpleadosBD(),
      builder: (BuildContext context,
          AsyncSnapshot<List<EmpleadoModel>> snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<EmpleadoModel>(
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
                _opcionDetras = opt.idEmpleado;
              });
            },
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
