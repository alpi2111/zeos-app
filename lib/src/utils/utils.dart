//import 'package:constructor_rajuma/src/models/empleado_model.dart';
import 'package:flutter/material.dart';

//import 'package:constructor_rajuma/src/preferences/preferencias_usuario.dart';

//final _prefs = PreferenciasUsuario();

void mostrarAlerta(BuildContext context, String titulo, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      });
}

Future<bool> mostrarAlertaCerrarSesion(BuildContext context, String titulo, String mensaje) async {
  bool si = false;
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
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
                //_prefs.token = null;
                si = true;
                Navigator.of(context).pop();

                //Navigator.pushReplacementNamed(context, 'login');
                //Navigator.of(context, rootNavigator: true).pop('dialog');
                //Navigator
              },
            ),
          ],
        );
      });
  return si;
}

void mostrarAlertaProgreso(BuildContext context, String titulo) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(titulo)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        );
      });
}

mostrarSnackbar(GlobalKey<ScaffoldState> key, String mensaje) {
  final SnackBar snackBar = new SnackBar(
    content: Text(mensaje),
    //behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Cerrar',
      onPressed: () {},
      textColor: Colors.yellow,
    ),
  );
  key.currentState.showSnackBar(snackBar);
}