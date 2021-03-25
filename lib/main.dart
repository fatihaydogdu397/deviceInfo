import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DeviceInfo(),
    );
  }
}

class DeviceInfo extends StatefulWidget {
  DeviceInfo({Key key}) : super(key: key);

  @override
  _DeviceInfoState createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  static const deviceInfo =
      const MethodChannel('samples.flutter.dev/deviceInfo');

  String _battery = 'Unknown';
  String _board = 'Unknown';
  String _bootloader = 'Unknown';
  String _brand = 'Unknown';
  String _fingerprint = 'Unknown';
  String _hardware = 'Unknown';
  String _host = 'Unknown';
  String _id = 'Unknown';
  String _manufacturer = 'Unknown';
  String _model = 'Unknown';
  String _product = 'Unknown';
  String _tags = 'Unknown';
  String _type = 'Unknown';

  Future<void> _getDeviceInfo() async {
    var deviceModel;

    final result = await deviceInfo.invokeMethod('deviceInfo');

    var deviceData = result;
    setState(() {
      _battery = deviceData["battery"].toString();
      _board = deviceData["board"];
      _bootloader = deviceData["bootloader"];
      _brand = deviceData["brand"];
      _fingerprint = deviceData["fingerprint"];
      _hardware = deviceData["hardware"];
      _host = deviceData["host"];
      _id = deviceData["id"];
      _manufacturer = deviceData["manufacturer"];
      _model = deviceData["model"];
      _product = deviceData["product"];
      _tags = deviceData["tags"];
      _type = deviceData["type"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Device Info",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    FlatButton(
                      onPressed: _getDeviceInfo,
                      child: Text(
                        'Get Device Info',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.grey,
                    )
                  ],
                ),
                Divider(),
                DeviceInfoItem(
                  infoText: "Battery Level",
                  infoItem: "$_battery%",
                ),
                DeviceInfoItem(
                  infoText: "Board",
                  infoItem: _board,
                ),
                DeviceInfoItem(
                  infoText: "Bootloader",
                  infoItem: _bootloader,
                ),
                DeviceInfoItem(
                  infoText: "Brand",
                  infoItem: _brand,
                ),
                DeviceInfoItem(
                  infoText: "Fingerprint",
                  infoItem: _fingerprint,
                ),
                DeviceInfoItem(
                  infoText: "Hardware",
                  infoItem: _hardware,
                ),
                DeviceInfoItem(
                  infoText: "ID",
                  infoItem: _id,
                ),
                DeviceInfoItem(
                  infoText: "Manufacturer",
                  infoItem: _manufacturer,
                ),
                DeviceInfoItem(
                  infoText: "Model",
                  infoItem: _model,
                ),
                DeviceInfoItem(
                  infoText: "Product",
                  infoItem: _product,
                ),
                DeviceInfoItem(
                  infoText: "Tags",
                  infoItem: _tags,
                ),
                DeviceInfoItem(
                  infoText: "Type",
                  infoItem: _type,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DeviceInfoItem extends StatelessWidget {
  final String infoItem;
  final String infoText;
  const DeviceInfoItem({
    Key key,
    this.infoItem,
    this.infoText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  width: 150,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    infoText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
              Expanded(
                child: AutoSizeText("$infoItem",
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    )),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
