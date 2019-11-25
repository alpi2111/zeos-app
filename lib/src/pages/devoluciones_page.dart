import 'package:constructor_rajuma/src/models/herramienta_model.dart';
import 'package:constructor_rajuma/src/providers/entrada_salida_provider.dart';
import 'package:constructor_rajuma/src/utils/utils.dart';
import 'package:flutter/material.dart';

class DevolucionesPage extends StatefulWidget {
  @override
  _DevolucionesPageState createState() => _DevolucionesPageState();
}

class _DevolucionesPageState extends State<DevolucionesPage> {
  final _provider = EntradaSalidaProvider();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _provider.obtenerFueraAlmacen(),
      builder: (BuildContext context,
          AsyncSnapshot<List<HerramientaModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.lime,
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    bool eliminar = await mostrarAlertaCerrarSesion(
                        context,
                        'Devolución',
                        '¿Confirma que ya regresaron la herramienta?');
                    if (eliminar)
                      //await _provider.updateHerramientaDisponible(key, id, dispo)
                      //{Navigator.of(context).pushNamed('login');
                      return eliminar;
                    //}
                    else
                      return eliminar;
                  },
                  onDismissed: (i) {
                    //_p
                    _provider.updateStateHerramienta(snapshot.data[index].idFb, true);
                  },
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(snapshot.data[index].nombre),
                        subtitle: Text(snapshot.data[index].idHerramienta),
                        trailing: Text('Prestada'),
                      ),
                      Divider(),
                    ],
                  ),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
