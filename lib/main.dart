import 'package:flutter/material.dart';
import 'package:monetariando/screens/homescreen.dart'; // Importamos a nossa nova tela!

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // Agora o nosso widget principal é a HomeScreen, que está em outro arquivo.
      home: HomeScreen(),
      theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: 'Roboto'),
    ),
  );
}
