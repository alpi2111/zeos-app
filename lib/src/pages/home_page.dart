//es la pagina home del administrador de la matriz
import 'package:flutter/material.dart';

import 'package:connectivity_widget/connectivity_widget.dart';

import 'package:constructor_rajuma/src/providers/herramienta_provider.dart';
import 'package:constructor_rajuma/src/providers/sucursal_provider.dart';
import 'package:constructor_rajuma/src/preferences/preferencias_usuario.dart';
import 'package:constructor_rajuma/src/utils/utils.dart';
import 'package:constructor_rajuma/src/models/sucursal_model.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _prefs = PreferenciasUsuario();
  final _scaffoldKeyHome = GlobalKey<ScaffoldState>();
  final _sucursalProvider = new SucursalProvider();
  final _herramientaProvider = new HerramientaProvider();
  int _index = 0;

  //final con = new Con();

  //var connectivityResult = await (Connectivity().checkConnectivity());
  //bool isConnected =
  @override
  Widget build(BuildContext context) {
    //ConnectivityUtils.instance.setCallback((response) => response.contains('other'));
    //ConnectivityUtils.instance.setServerToPing('https://google.com.mx');
    return Scaffold(
        bottomNavigationBar: _prefs.isAdmin
            ? null
            : BottomNavigationBar(
                currentIndex: _index,
                onTap: (index) {
                  setState(() {
                    _index = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: RotatedBox(
                        child: Icon(Icons.system_update_alt),
                        quarterTurns: 2,
                      ),
                      title: Text('Préstamos')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.system_update_alt),
                      title: Text('Devoluciones'))
                ],
              ),
        floatingActionButton: _prefs.isAdmin ? _fabAdmin() : _fabNoAdmin(),
        persistentFooterButtons: _prefs.isAdmin ? _pbtnAdmin() : _pbtnNoAdmin(),
        key: _scaffoldKeyHome,
        appBar: AppBar(
          title: _prefs.isAdmin
              ? Text('Selección de sucursal')
              : Text('Sucursal del encargado'),
        ),
        body: /*con.connectivityResult ?*/ ConnectivityWidget(
            offlineCallback: () {
              print('offline');
            },
            onlineCallback: () {
              print('online');
              mostrarSnackbar(
                  _scaffoldKeyHome, 'Comenzando carga de datos a internet.');
            },
            offlineBanner: Container(
              height: 40.0,
              color: Colors.red,
              child: Center(
                child:
                    Text('Sin Conexión', style: TextStyle(color: Colors.white)),
              ),
            ),
            showOfflineBanner: true,
            builder: _prefs.isAdmin
                ? (context, isOnline) =>
                    _crearBtnSucursales(isOnline) //es el supervisor
                : (context, isOnline) => _crearHerramientasSucursal(
                    isOnline, _index) //no es el supervisor
            ) /*: Center(
                                                child: Text('Sin Conexion'),
                                              ),*/
        );
  }

  Widget _crearBtnSucursales(bool isOnline) {
    /* final aaa = Container(
                                          key: UniqueKey(),
                                        ); */

    return FutureBuilder(
      future: _sucursalProvider.cargarSucursales(),
      builder:
          (BuildContext context, AsyncSnapshot<List<SucursalModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              return Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('ver_herramientas',
                          arguments: [
                            snapshot.data[i].nombre,
                            snapshot.data[i].idSucursal
                          ]);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Almacen ${snapshot.data[i].nombre}"),
                        Icon(
                          Icons.arrow_right,
                          size: 40.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  )
                ],
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

    //TODO regresar lo de abajo a su normalidad

    //print('LA jey es ' + aaa.key.toString());
    /*
                                        return Container(
                                          padding: EdgeInsets.symmetric(horizontal: 100.0),
                                          child: Column(
                                            //crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("Sucursales Disponibles"),
                                    
                                              //botones que deberian ir
                                              SizedBox(height: 10.0),
                                              RaisedButton(
                                                child: Text('Almacen Chapultepec'),
                                                onPressed: () {},
                                              ),
                                              SizedBox(height: 20.0),
                                              RaisedButton(
                                                child: Text('Almacen Lomas Verdes'),
                                                onPressed: () {},
                                              ),
                                              /* SizedBox(height: 20.0),
                                              RaisedButton(
                                                child: Text('Almacen 3'),
                                                onPressed: () {},
                                              ), */
                                              SizedBox(height: 20.0),
                                              //fin de botones que deberian ir
                                    
                                              RaisedButton(
                                                child: Text('Cerrar Sesion'),
                                                onPressed: () => _cerrarSesion(isOnline),
                                              ),
                                            ],
                                          ),
                                        );
                                    */
  }

  //TODO hacer la parte del encargado sin admin
  Widget _crearHerramientasSucursal(bool isOnline, int index) {
    switch (index) {
      case 0:
        return FutureBuilder(
          future: _herramientaProvider.obtenerHerramientasSucursal('j'),
          //initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container();
          },
        );
      case 1:
        return Container(
          color: Colors.red,
        );

        break;
      default:
        return Center(
          child: Text('Pagina no encontrada'),
        );
    }
  }

  /*_cerrarSesion(bool isOn) async {
    //if(isOn)
    final cerrar = await mostrarAlertaCerrarSesion(
        _scaffoldKeyHome.currentContext,
        'Precuación',
        '¿Realmente desea cerrar la sesión?');
    if (cerrar) {
      Navigator.pushReplacementNamed(_scaffoldKeyHome.currentContext, 'login');
      print('cerrar');
    }
    //else
    ////mostrarSnackbar(_scaffoldKeyHome, 'No tienes conexion para cerrar sesuin');
    //mostrarAlerta(context, 'Información', 'No tiene conexión para poder cerrar sesión');
    ////print(_prefs.token);
  }*/

  _fabAdmin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _fabNoAdmin(),
        SizedBox(height: 10.0),
        FloatingActionButton(
          heroTag: 'btnVerEncargados',
          onPressed: () {
            Navigator.of(context).pushNamed('ver_encargados');
          },
          child: Icon(Icons.perm_contact_calendar),
          tooltip: 'Ver Encargados',
        )
      ],
    );
  }

  _fabNoAdmin() {
    return FloatingActionButton(
      heroTag: 'btnCerrarSesion',
      onPressed: () async {
        bool cerrar = await mostrarAlertaCerrarSesion(
            context, 'Cerrar Sesión', '¿Desea Cerrar Sesión?');
        if (cerrar) {
          _prefs.token = null;
          Navigator.of(context).pushReplacementNamed('login');
        }
      },
      child: Icon(Icons.exit_to_app),
      tooltip: 'Cerrar Sesion',
    );
  }

  List<Widget> _pbtnAdmin() {
    return <Widget>[
      RaisedButton(
        child: Text(
          'Crear nueva sucursal',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => Navigator.of(context).pushNamed('agregar_sucursal'),
      ),
      RaisedButton(
        child: Text(
          'Crear nuevo encargado',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => Navigator.of(context).pushNamed('agregar_encargado'),
      ),
    ];
  }

  List<Widget> _pbtnNoAdmin() {
    return <Widget>[
      RaisedButton(
        onPressed: () {},
        child: Text(
          'Agregar Herramienta',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ];
  }
}
