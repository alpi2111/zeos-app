import 'package:constructor_rajuma/src/pages/alert_page.dart';
import 'package:flutter/material.dart';

//import 'package:constructor_rajuma/src/models/empleado_model.dart';
import 'package:constructor_rajuma/src/models/herramienta_model.dart';
//import 'package:constructor_rajuma/src/providers/empleado_provider.dart';
//import 'package:constructor_rajuma/src/utils/utils.dart';
import 'package:constructor_rajuma/src/providers/entrada_salida_provider.dart';

class PrestamosPage extends StatefulWidget {
  @override
  _PrestamosPageState createState() => _PrestamosPageState();
}

class _PrestamosPageState extends State<PrestamosPage> {
  final _provider = EntradaSalidaProvider();
  //final _empProvider = EmpleadoProvider();

  //String _opcion = 'Seleccione un empleado...';
  //String _opDetras = '';
  //String _opcionDetras = '';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _provider.obtenerEnAlmacen(),
      builder: (context, AsyncSnapshot<List<HerramientaModel>> snapshot) {
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
                  bool eliminar = await mostrarAlertaSelEmpleado(context,
                      'Prestar', '¿A quién desea prestar la herramienta?');
                  if (eliminar)
                    //await _provider.updateHerramientaDisponible(key, id, dispo)
                    //{Navigator.of(context).pushNamed('login');
                    return eliminar;
                    //}
                  else
                    return eliminar;
                },
                onDismissed: (a) {
                  //TODO hacer que se mueva a otro lado
                 _provider.updateStateHerramienta(snapshot.data[i].idFb, false);
                },
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(snapshot.data[i].nombre),
                      subtitle: Text(snapshot.data[i].idHerramienta),
                      //leading: Text(snapshot.data[i].disponible.toString()),
                    ),
                    Divider(),
                    //_crearEmpleados()
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
  Future<bool> mostrarAlertaSelEmpleado(
      BuildContext context, String titulo, String mensaje) async {
    //bool si = false;
    //final aaa = await _crearEmpleados();
    await showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertPage();
        });
        if(AlertPage.isYes) {
          return true;
        } else {
          return false;
        }
    //return si;
  }
}
