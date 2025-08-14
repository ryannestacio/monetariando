import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClientRegistrationScreen extends StatefulWidget {
  @override
  _ClientRegistrationScreenState createState() =>
      _ClientRegistrationScreenState();
}

class _ClientRegistrationScreenState extends State<ClientRegistrationScreen> {
  // Você irá gerenciar o estado dos campos do formulário aqui.

  final TextEditingController _nameCustomer = TextEditingController();
  final TextEditingController _adressCustomer = TextEditingController();
  final TextEditingController _contactCustomer = TextEditingController();
  final TextEditingController _cpfCustomer = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget _buildInputCustomer(
    TextEditingController controler,
    String hintText,
    String labelText,
    String? Function(String?)? validator,
  ) {
    return TextFormField(
      controller: controler,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hint: Text(hintText),
        label: Text(labelText),
      ),
    );
  }

  Widget _espacador() {
    return SizedBox(height: 10);
  }

  void _onRegisterButtonPressed() async {
    // Validação de formulário
    if (_formKey.currentState!.validate()) {
      // Se a validação for bem-sucedida, mostramos uma SnackBar de carregamento.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Cadastrando cliente...')));

      // Criamos um mapa com os dados do cliente.
      Map<String, dynamic> clientData = {
        'nome': _nameCustomer.text,
        'endereco': _adressCustomer.text,
        'contato': _contactCustomer.text,
        'cpf': _cpfCustomer.text,
        'dataCadastro':
            FieldValue.serverTimestamp(), // Adiciona o timestamp do servidor.
      };

      try {
        // Obtenha a instância do Firestore.
        final db = FirebaseFirestore.instance;

        // Adiciona um novo documento na coleção 'clientes'.
        await db.collection('clientes').add(clientData);

        // Mostra uma SnackBar de sucesso.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cliente cadastrado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        // Limpa os campos após o cadastro.
        _nameCustomer.clear();
        _adressCustomer.clear();
        _contactCustomer.clear();
        _cpfCustomer.clear();
      } catch (e) {
        // Em caso de erro, mostramos uma SnackBar com a mensagem de erro.
        print("Erro ao cadastrar cliente: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao cadastrar cliente. Tente novamente.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Se a validação falhar, mostramos uma mensagem de erro.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cadastro de Cliente',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildInputCustomer(
                      _nameCustomer,
                      'Digite o nome do cliente...',
                      'Nome',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome do cliente';
                        }
                        return null;
                      },
                    ),
                    _espacador(),
                    _buildInputCustomer(
                      _adressCustomer,
                      'Digite o endereço do cliente...',
                      'Endereço',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o endereço do cliente';
                        }
                        return null;
                      },
                    ),
                    _espacador(),
                    _buildInputCustomer(
                      _contactCustomer,
                      'Digite o contatato do cliente...',
                      'Contato',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o contato do cliente';
                        }
                        return null;
                      },
                    ),
                    _espacador(),
                    _buildInputCustomer(
                      _cpfCustomer,
                      'Digite o CPF do cliente...',
                      'CPF',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o CPF do cliente';
                        }
                        return null;
                      },
                    ),
                    _espacador(),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _onRegisterButtonPressed();
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),

                        child: Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
