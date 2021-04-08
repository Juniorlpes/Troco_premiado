import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:troco_premiado/app/modules/home/home_controller.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';

class PrintPage extends StatefulWidget {
  final TicketRaffle ticket;

  const PrintPage({Key key, this.ticket}) : super(key: key);

  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  final homeController = Modular.get<HomeController>();
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice _device;
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } catch (e) {
      print(e);
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imprimir biblhete'),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Text(
                'Lembre de ir nas configurações do celular e parear com a impressora bluetooth',
                textAlign: TextAlign.center,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Device:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: DropdownButton(
                      items: _getDeviceItems(),
                      onChanged: (value) => setState(() => _device = value),
                      value: _device,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.brown,
                    onPressed: () {
                      initPlatformState();
                    },
                    child: Text(
                      'Refresh',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    color: _connected ? Colors.red : Colors.green,
                    onPressed: _connected ? _disconnect : _connect,
                    child: Text(
                      _connected ? 'Disconnect' : 'Connect',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
                child: RaisedButton(
                  color: Colors.brown,
                  onPressed: () {
                    printTicket();
                  },
                  child: Text('Imprimir bilhete',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  void printTicket() {
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT

    //bluetooth.printImage(pathImage);   //path of your image/logo

    // var response = await http.get("IMAGE_URL");
    // Uint8List bytes = response.bodyBytes;
    //  bluetooth.printImageBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    // bluetooth.printCustom(" čĆžŽšŠ-H-ščđ", 1, 1, charset: "windows-1250");
    // bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
    // bluetooth.printLeftRight("LEFT", "RIGHT", 1);
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.printCustom('Troco Premiado', 4, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom(widget.ticket.formattedRaffleNumber, 4, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom(
            'Com esse numero você concorre a um premio de R\$ 100 quinzenalmente ate o dia ${DateFormat('dd/MM/yyyy').format(widget.ticket.bigLuckyaffleDate)}.',
            1,
            1);
        bluetooth.printCustom(
            'O ultimo premio é de 1000 vezes o troco deixado na loja!', 1, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom('Cliente: ${widget.ticket.clientName}', 1, 0);
        bluetooth.printCustom('Troco: R\$ ${widget.ticket.ticketValue}', 1, 0);
        bluetooth.printCustom(
            'Premio final: ${(widget.ticket.ticketValue * 1000).toStringAsFixed(2)}',
            1,
            0);
        bluetooth.printCustom('Loja: ${homeController.mainCompany.name}', 1, 0);
        bluetooth.printCustom(
            'Endereco: ${homeController.mainCompany.address}', 1, 0);
        bluetooth.printCustom(
            'Emitido em: ${DateFormat('dd/MM/yyyy').format(widget.ticket.createdDate)}',
            1,
            0);
        bluetooth.printNewLine();
        bluetooth.printCustom("Boa Sorte", 2, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }

  void _connect() {
    if (_device == null) {
      Toast.show('No device selected.', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth.connect(_device).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = true);
  }
}
