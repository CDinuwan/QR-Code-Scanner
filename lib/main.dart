import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home:HomePage(),
));

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result="Hey There!";
  
  Future _scanQR()async{
    try{
      String qrResult=await BarcodeScanner.scan().toString();
      setState(() {
        result=qrResult;
      }
      );
    }on PlatformException catch(ex){
      if(ex.code==BarcodeScanner.cameraAccessDenied){
        setState(() {
          result="Camera permission was denied";
        });
      }
      else{
        setState(() {
          result="Something went wrong $ex";
        });
      }
    }on FormatException{
      setState(() {
        result="You pressed the back button before scanning anything";
      });
    }catch (ex){
      setState(() {
          result="Something went wrong $ex";
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("QR Scanner",),
      ),
      body:Center(
        child:Text(result),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon:Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: (){
          _scanQR();
        },
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
    );
  }
}

