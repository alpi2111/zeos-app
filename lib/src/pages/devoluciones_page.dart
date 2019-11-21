import 'package:constructor_rajuma/src/providers/entrada_salida_provider.dart';
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
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        //return ;
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (i) {
                    //_p
                    print(i);
                  },
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(snapshot.data[index]),
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
