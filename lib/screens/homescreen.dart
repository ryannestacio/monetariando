import 'package:flutter/material.dart';
import 'package:monetariando/screens/customer_registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

// Importações simuladas para o ambiente Canvas
// Em um projeto real, você precisaria adicionar dependências no pubspec.yaml
// e usar `main` assíncrono para inicializar o Firebase.

// --- Componentes para as Telas ---
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Lista para armazenar os documentos dos clientes
  List<DocumentSnapshot> _clients = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Inicia a busca pelos clientes quando a tela é carregada
    _fetchClients();
  }

  // Função para buscar os dados dos clientes no Firestore
  Future<void> _fetchClients() async {
    try {
      // Obtenha a instância do Firestore
      final db = FirebaseFirestore.instance;

      // Ouve as mudanças na coleção 'clientes' em tempo real
      db
          .collection('clientes')
          .snapshots()
          .listen(
            (snapshot) {
              if (mounted) {
                setState(() {
                  _clients = snapshot.docs;
                  _isLoading = false;
                });
              }
            },
            onError: (e) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                  _errorMessage = 'Erro ao carregar clientes: $e';
                  print('Erro ao carregar clientes: $e');
                });
              }
            },
          );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Erro ao inicializar Firestore: $e';
          print('Erro ao inicializar Firestore: $e');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Dashboard de Vendas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _errorMessage.isNotEmpty
                  ? Center(
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : _clients.isEmpty
                  ? Center(child: Text('Nenhum cliente cadastrado ainda.'))
                  : ListView.builder(
                      itemCount: _clients.length,
                      itemBuilder: (context, index) {
                        final clientData =
                            _clients[index].data() as Map<String, dynamic>;
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(
                              clientData['nome'] ?? 'Nome não disponível',
                            ),
                            subtitle: Text(
                              clientData['cpf'] ?? 'CPF não disponível',
                            ),
                          ),
                        );
                      },
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
