import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  IO.Socket _socket;

  ServerStatus _serverStatus = ServerStatus.Connecting;
  String _contenido = "";

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  get contenido => this._contenido;

  get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    this._socket = IO.io('http://192.168.0.5:3002', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    //Emit : socket.emit('emitir-mensaje',{nombre:'Diego',apellido:'Sobino'});

    this._socket.on('nuevo-mensaje', (payload) {
      //print('nuevo-mensaje: ${payload}');
      //print('nombre :' + payload['nombre']);
      //print('apellido :' + payload['apellido']);
      final strAux1 = payload.containsKey('nombre') ? payload['nombre'] : 'N/A';
      final strAux2 =
          payload.containsKey('apellido') ? payload['apellido'] : 'N/A';

      print('Nombre y Apellido : $strAux1  $strAux2  ');

      this._contenido = 'Nombre y Apellido :' + strAux1 + ' ' + strAux2;
      notifyListeners();
    });

/*
    this._socket.on('active-bands', (payload) {
      print(payload);
      notifyListeners();
    });
*/
  }

  void fnSaludo(payload) {
    print(payload);
    emit('emitir-mensaje', payload);
  }
}
