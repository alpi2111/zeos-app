import 'package:flutter/material.dart';

import 'package:constructor_rajuma/src/providers/sucursal_provider.dart';
import 'package:constructor_rajuma/src/utils/utils.dart';

class VerHerramientasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> arg = ModalRoute.of(context).settings.arguments;
    final _sucursalProvider = new SucursalProvider();
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
                  bool eliminado = await _sucursalProvider.eliminarSucursal(arg[1]);
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
      body: Center(
        child: Text('Datoos de herramientas ${arg[0]}'),
      ),
    );
  }
}
