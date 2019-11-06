import 'package:constructor_rajuma/src/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:constructor_rajuma/src/models/supervisor_model.dart';
import 'package:constructor_rajuma/src/providers/supervisor_provider.dart';

class VerEncargadosPage extends StatefulWidget {
  @override
  _VerEncargadosPageState createState() => _VerEncargadosPageState();
}

class _VerEncargadosPageState extends State<VerEncargadosPage> {
  final _supervisorProvider = new SupervisorProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de encargados'),
      ),
      body: FutureBuilder(
        future: _supervisorProvider.obtenerEncargados(),
        builder: (BuildContext context,
            AsyncSnapshot<List<SupervisorModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int i) {
                return Dismissible(
                  key: UniqueKey(),
                  child: ListTile(
                    //trailing: Icon(Icons.arrow_right),
                    title: Text(
                      snapshot.data[i].nombre,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Usuario: ${snapshot.data[i].idSupervisor}'),
                        Text('Contraseña: ${snapshot.data[i].password}'),
                      ],
                    ),
                    onTap: () {},
                  ),
                  background: Container(
                    color: Colors.red,
                  ),
                  confirmDismiss: (direction) async {
                    bool eliminar = await mostrarAlertaCerrarSesion(context, 'Eliminar', '¿Realmente desea eliminar el encargado?');
                    if (eliminar)
                      await _supervisorProvider.eliminarSupervisor(snapshot.data[i].idSupervisor, snapshot.data[i].idToken);
                    return eliminar;
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
