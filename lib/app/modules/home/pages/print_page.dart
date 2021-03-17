import 'package:flutter/material.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';

class PrintPage extends StatefulWidget {
  final TicketRaffle ticket;

  const PrintPage({Key key, this.ticket}) : super(key: key);

  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  // BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  // bool _connected = false;
  // BluetoothDevice _device;
  // String tips = 'no device connect';

  // @override
  // void initState() {
  //   super.initState();
  //   initBluetooth();
  // }

  // Future<void> initBluetooth() async {
  //   bluetoothPrint.startScan(timeout: Duration(seconds: 4));

  //   bool isConnected = await bluetoothPrint.isConnected;

  //   bluetoothPrint.state.listen((state) {
  //     print('cur device status: $state');

  //     switch (state) {
  //       case BluetoothPrint.CONNECTED:
  //         setState(() {
  //           _connected = true;
  //           tips = 'connect success';
  //         });
  //         break;
  //       case BluetoothPrint.DISCONNECTED:
  //         setState(() {
  //           _connected = false;
  //           tips = 'disconnect success';
  //         });
  //         break;
  //       default:
  //         break;
  //     }
  //   });

  //   if (!mounted) return;

  //   if (isConnected) {
  //     setState(() {
  //       _connected = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imprimir biblhete'),
        centerTitle: true,
      ),
//       floatingActionButton: StreamBuilder<bool>(
//         stream: bluetoothPrint.isScanning,
//         initialData: false,
//         builder: (c, snapshot) {
//           if (snapshot.data) {
//             return FloatingActionButton(
//               child: Icon(Icons.stop),
//               onPressed: () => bluetoothPrint.stopScan(),
//               backgroundColor: Colors.red,
//             );
//           } else {
//             return FloatingActionButton(
//                 child: Icon(Icons.search),
//                 onPressed: () =>
//                     bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
//           }
//         },
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                   child: Text(tips),
//                 ),
//               ],
//             ),
//             Divider(),
//             StreamBuilder<List<BluetoothDevice>>(
//               stream: bluetoothPrint.scanResults,
//               initialData: [],
//               builder: (c, snapshot) => Column(
//                 children: snapshot.data
//                     .map((d) => ListTile(
//                           title: Text(d.name ?? ''),
//                           subtitle: Text(d.address),
//                           onTap: () async {
//                             setState(() {
//                               _device = d;
//                             });
//                           },
//                           trailing:
//                               _device != null && _device.address == d.address
//                                   ? Icon(
//                                       Icons.check,
//                                       color: Colors.green,
//                                     )
//                                   : null,
//                         ))
//                     .toList(),
//               ),
//             ),
//             Divider(),
//             Container(
//               padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       OutlineButton(
//                         child: Text('connect'),
//                         onPressed: _connected
//                             ? null
//                             : () async {
//                                 if (_device != null &&
//                                     _device.address != null) {
//                                   await bluetoothPrint.connect(_device);
//                                 } else {
//                                   setState(() {
//                                     tips = 'please select device';
//                                   });
//                                   print('please select device');
//                                 }
//                               },
//                       ),
//                       SizedBox(width: 10.0),
//                       OutlineButton(
//                         child: Text('disconnect'),
//                         onPressed: _connected
//                             ? () async {
//                                 await bluetoothPrint.disconnect();
//                               }
//                             : null,
//                       ),
//                     ],
//                   ),
//                   OutlineButton(
//                     child: Text('imprimir bilhete'),
//                     onPressed: _connected
//                         ? () async {
//                             Map<String, dynamic> config = Map();
//                             List<LineText> list = List();
//                             list.add(LineText(
//                                 type: LineText.TYPE_TEXT,
//                                 content: 'A Title',
//                                 weight: 1,
//                                 align: LineText.ALIGN_CENTER,
//                                 linefeed: 1));
//                             list.add(LineText(
//                                 type: LineText.TYPE_TEXT,
//                                 content: 'this is conent left',
//                                 weight: 0,
//                                 align: LineText.ALIGN_LEFT,
//                                 linefeed: 1));
//                             list.add(LineText(
//                                 type: LineText.TYPE_TEXT,
//                                 content: 'this is conent right',
//                                 align: LineText.ALIGN_RIGHT,
//                                 linefeed: 1));
//                             list.add(LineText(linefeed: 1));
// //                            list.add(LineText(type: LineText.TYPE_BARCODE, content: 'A12312112', size:10, align: LineText.ALIGN_CENTER, linefeed: 1));
// //                            list.add(LineText(linefeed: 1));
// //                            list.add(LineText(type: LineText.TYPE_QRCODE, content: 'qrcode i', size:10, align: LineText.ALIGN_CENTER, linefeed: 1));
// //                            list.add(LineText(linefeed: 1));

//                             ByteData data = await rootBundle
//                                 .load("assets/images/bluetooth_print.png");
//                             List<int> imageBytes = data.buffer.asUint8List(
//                                 data.offsetInBytes, data.lengthInBytes);
//                             String base64Image = base64Encode(imageBytes);
//                             list.add(LineText(
//                                 type: LineText.TYPE_IMAGE,
//                                 content: base64Image,
//                                 align: LineText.ALIGN_CENTER,
//                                 linefeed: 1));

//                             await bluetoothPrint.printReceipt(config, list);
//                           }
//                         : null,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
    );
  }
}
