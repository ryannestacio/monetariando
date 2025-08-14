import 'package:flutter/material.dart';
import 'package:monetariando/screens/customer_registration_screen.dart';

//import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:uuid/uuid.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dashboard de Vendas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Aqui teremos os relatórios de clientes e vendas.',
                  style: TextStyle(color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContractsRegistrationScreem extends StatefulWidget {
  const ContractsRegistrationScreem({super.key});

  @override
  State<ContractsRegistrationScreem> createState() =>
      _ContractsRegistrationScreemState();
}

class _ContractsRegistrationScreemState
    extends State<ContractsRegistrationScreem> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Contratos'));
  }
}

class MachineRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Cadastro de Máquina',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// --- Código da tela principal da nossa aplicação ---
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Telas para a navegação
  final List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    ContractsRegistrationScreem(),
    ClientRegistrationScreen(),
    MachineRegistrationScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> initializeFirebase() async {
    try {
      // Código de inicialização do Firebase aqui...
    } catch (e) {
      print("Erro ao inicializar o Firebase: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'fernando - cliente - projeto - 14',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo[700],
        foregroundColor: Colors.white,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, color: Colors.indigo),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_rounded, color: Colors.indigo),
            label: 'Contratos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add, color: Colors.indigo),
            label: 'Clientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card, color: Colors.indigo),
            label: 'Máquinas',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo[700],
        onTap: _onItemTapped,
      ),
    );
  }
}
