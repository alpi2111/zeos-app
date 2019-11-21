import 'package:flutter/material.dart';

import 'package:constructor_rajuma/src/models/herramienta_model.dart';
import 'package:constructor_rajuma/src/providers/herramienta_provider.dart';

import 'package:constructor_rajuma/src/providers/sucursal_provider.dart';
import 'package:constructor_rajuma/src/utils/utils.dart';

class VerHerramientasPage extends StatelessWidget {
  final _sucursalProvider = new SucursalProvider();
  final _herramientaProvider = new HerramientaProvider();
  @override
  Widget build(BuildContext context) {
    //_sucursalProvider.obtenerHerramientasSucursal();
    final List<String> arg = ModalRoute.of(context).settings.arguments;
    _herramientaProvider.obtenerTodasHerramientasSucursal(arg[1]);
    //final List a = arg;
    //print(arg[0]);

    return Scaffold(
      persistentFooterButtons: <Widget>[
        Row(
          children: <Widget>[
            RaisedButton(
              color: Colors.red,
              child: Text(
                'Eliminar esta sucursal',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                bool eliminar = await mostrarAlertaCerrarSesion(
                  context,
                  'Eliminar Sucursal',
                  '¿Realmente desea eliminar esta sucursal?. Todos los datos se perderán y no podrán recuperarse',
                );
                if (eliminar) {
                  bool eliminado =
                      await _sucursalProvider.eliminarSucursal(arg[1]);
                  if (Navigator.of(context).canPop() && eliminado)
                    Navigator.of(context).pop();
                }
              }, //TODO implmentar el eliminar sucursal
            ),
            SizedBox(width: 20.0),
            RaisedButton(
              child: Text(
                'Agregar nueva herramienta',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context)
                  .pushNamed('agregar_herramienta', arguments: arg),
            ),
          ],
        ),
      ],
      appBar: AppBar(
        title: Text('Ver Herramientas'),
      ),
      body: FutureBuilder(
        future: _herramientaProvider.obtenerTodasHerramientasSucursal(arg[1]),
        //initialData: InitialData,
        builder: (BuildContext context,
            AsyncSnapshot<List<HerramientaModel>> snapshot) {
          //print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                //print(snapshot.data);
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (index) {},
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (dir) async {
                    bool eliminar = await mostrarAlertaCerrarSesion(
                        context,
                        'Eliminar Herramienta',
                        '¿Realmente desea eliminar ${snapshot.data[index].nombre} definitivamente?');

                    if (eliminar) {
                      print(snapshot.data[index].idFb);
                      await _herramientaProvider
                          .eliminarHerramienta(snapshot.data[index].idFb);
                    }
                    return eliminar;
                  },
                  background: Container(color: Colors.redAccent),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(snapshot.data[index].nombre),
                        subtitle: Text(snapshot.data[index].idHerramienta),
                        //leading: Text(snapshot.data[index].disponible.toString()),
                        leading: Switch(
                          onChanged: (v) {},
                          value: snapshot.data[index].disponible,
                        ),
                        //trailing: Text(snapshot.data[index].disponible.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.arrow_back),
                            Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'Actualmente no hay herramientas en la sucursal $arg[0]',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            );
          }
        },
      ),
    );
  }
}
