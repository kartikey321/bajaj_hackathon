import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PestControlScreen extends StatefulWidget {
  static String id = 'pestControl_screen';

  const PestControlScreen({Key? key}) : super(key: key);

  @override
  _PestControlScreenState createState() => _PestControlScreenState();
}

class _PestControlScreenState extends State<PestControlScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  void connect() {
    IO.Socket socket = IO.io('http://127.0.0.1:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    print(socket.connected);
    socket.on('location', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    // socket = IO.io('http://192.168.10.36:3000', <String, dynamic>{
    //   "transport": ["websocket"],
    //   "autoConnect": false,
    // });
    // socket.connect();r
    // socket.onConnect((data) => print("Connected"));
    // print(socket.connected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}
