import 'package:constructor_rajuma/src/models/empleado_model.dart';
import 'package:constructor_rajuma/src/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:constructor_rajuma/src/preferences/preferencias_usuario.dart';
import 'package:constructor_rajuma/src/providers/empleado_provider.dart';

class VerEmpleadosPage extends StatefulWidget {
  @override
  _VerEmpleadosPageState createState() => _VerEmpleadosPageState();
}

class _VerEmpleadosPageState extends State<VerEmpleadosPage> {
  final _prefs = new PreferenciasUsuario();
  final _provider = EmpleadoProvider();
  //String _idSucursal;
  @override
  Widget build(BuildContext context) {
    final String _idSucursal = ModalRoute.of(context).settings.arguments;
    //print("$_idSucursal lalalala");
    //print(_prefs.isAdmin);
    //print(_provider.obtenerTodosEmpleados());
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Empleados'),
      ),
      body: _prefs.isAdmin ? _crearListAdmin() : _crearListNoAdmin(_idSucursal),
      persistentFooterButtons: <Widget>[
        _prefs.isAdmin
            ? RaisedButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed('agregar_empleado', arguments: _idSucursal),
                child: Text(
                  'Agregar nuevo empleado',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : null
      ],
    );
  }

  Widget _crearListAdmin() {
    return FutureBuilder(
      future: _provider.obtenerTodosEmpleados(),
      //initialData: InitialData,
      builder:
          (BuildContext context, AsyncSnapshot<List<EmpleadoModel>> snapshot) {
        //print(snapshot.data.length);
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            /*if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {*/
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              confirmDismiss: (direction) async {
                bool eliminar = await mostrarAlertaCerrarSesion(context,
                    'Eliminar', '¿Realmente desea eliminar el empleado?');
                if (eliminar)
                  await _provider.eliminarEmpleado(
                    snapshot.data[index].idEmpleado,
                    //snapshot.data[index].idToken);
                  );
                return eliminar;
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      snapshot.data[index].nombre,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(snapshot.data[index].idEmpleado),
                        Text(snapshot.data[index].idSucursal),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            );
            /*} else {
              return Center(child: Text('No hay datos'));
            }*/
          },
        );
      },
    );
  }

  //TODO cambiar esta parte del codigo

  Widget _crearListNoAdmin(String idSucursal) {
    _provider.obtenerEmpleadoSucursal(idSucursal);
    return FutureBuilder(
      future: _provider.obtenerEmpleadoSucursal(idSucursal),
      builder:
          (BuildContext context, AsyncSnapshot<List<EmpleadoModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            //print("len ${snapshot.data.length}");
            /*if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {*/
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    snapshot.data[index].nombre,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(snapshot.data[index].idEmpleado),
                      Text(snapshot.data[index].idSucursal),
                    ],
                  ),
                ),
                Divider()
              ],
            );
            /*} else {
              return Center(child: Text('No hay datos'));
            }*/
          },
        );
      },
    );
  }
}
