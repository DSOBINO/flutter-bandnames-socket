import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    //socketService.socket.emit(event);

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(children: <Widget>[
          Text('ServerStatus: ${socketService.serverStatus}'),
          Text('Contenido : ${socketService.contenido}'),
        ])),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () {
            socketService.emit('emitir-mensaje',
                {'nombre': 'Diegon', 'apellido': 'Sobinowski'});
            //socketService.fnSaludo('Saludoses desde Flutter');
          }),
    );
  }
}
