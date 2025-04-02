// Versão 2.0 - Criação da página de autenticação
// Este arquivo implementa a interface de login e cadastro do aplicativo Yami
// Inclui funcionalidades de:
// - Login com telefone e senha
// - Cadastro de novos usuários
// - Login social (Google, Facebook e Apple)
// - Validação de formulários
// - Interface moderna com animações e feedback visual

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// Widget principal da página de autenticação
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

// Estado da página de autenticação com suporte a animações de tab
class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  // Controlador para as abas de login e cadastro
  late TabController _tabController;

  // Controladores para os campos de texto do login
  final _loginPasswordController = TextEditingController();

  // Controladores para os campos de texto do cadastro
  final _registerPasswordController = TextEditingController();
  final _registerConfirmPasswordController = TextEditingController();

  // Chaves para validação dos formulários
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

  // Estados para controlar a visibilidade das senhas
  bool _loginPasswordVisible = false;
  bool _registerPasswordVisible = false;
  bool _registerConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Inicializa o controlador de abas com 2 abas
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Libera os recursos quando o widget é destruído
    _tabController.dispose();
    _loginPasswordController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmPasswordController.dispose();
    super.dispose();
  }

  // Método para navegar para a página principal após validação
  void _navigateToHome() {
    final currentFormKey =
        _tabController.index == 0 ? _loginFormKey : _registerFormKey;
    if (currentFormKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  // Método para lidar com login social
  void _handleSocialLogin(String provider) {
    // Aqui você implementará a lógica de login social
    // Não precisa validar campos
    Navigator.pushReplacementNamed(context, '/main');
  }

  // Método para construir botões de login social
  Widget _buildSocialLoginButton(String provider, String assetPath) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: IconButton(
        onPressed: () => _handleSocialLogin(provider),
        icon: Image.asset(
          assetPath,
          width: 30,
          height: 30,
        ),
      ),
    );
  }

  // Método para construir a aba de login
  Widget _buildLoginTab() {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          // Container para o campo de telefone
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(50),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Telefone',
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                prefixIcon: const Icon(Icons.phone, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: Color(0xFF4CAF50), width: 1),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              initialCountryCode: 'AO',
              onChanged: (phone) {
                // _loginPhoneNumber = phone.completeNumber;
              },
              validator: (value) {
                if (value == null || value.number.isEmpty) {
                  return 'Por favor, insira seu telefone';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          // Container para o campo de senha
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(30),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: _loginPasswordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    _loginPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _loginPasswordVisible = !_loginPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: Color(0xFF4CAF50), width: 1),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              obscureText: !_loginPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua senha';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 24),
          // Botão de login
          ElevatedButton(
            onPressed: _navigateToHome,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Entrar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          // Texto para login social
          const Text(
            'Ou continue com',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          // Botões de login social
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialLoginButton('google', 'assets/google.png'),
              _buildSocialLoginButton('facebook', 'assets/facebook.png'),
              _buildSocialLoginButton('apple', 'assets/apple.png'),
            ],
          ),
        ],
      ),
    );
  }

  // Método para construir a aba de cadastro
  Widget _buildRegisterTab() {
    return Form(
      key: _registerFormKey,
      child: Column(
        children: [
          // Container para o campo de telefone
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(30),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Telefone',
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                prefixIcon: const Icon(Icons.phone, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: Color(0xFF4CAF50), width: 1),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              initialCountryCode: 'AO',
              onChanged: (phone) {
                // _registerPhoneNumber = phone.completeNumber;
              },
              validator: (value) {
                if (value == null || value.number.isEmpty) {
                  return 'Por favor, insira seu telefone';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          // Container para o campo de senha
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(30),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: _registerPasswordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    _registerPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _registerPasswordVisible = !_registerPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: Color(0xFF4CAF50), width: 1),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              obscureText: !_registerPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua senha';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          // Container para o campo de confirmação de senha
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(30),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: _registerConfirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    _registerConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _registerConfirmPasswordVisible =
                          !_registerConfirmPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: Color(0xFF4CAF50), width: 1),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              obscureText: !_registerConfirmPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, confirme sua senha';
                }
                if (value != _registerPasswordController.text) {
                  return 'As senhas não coincidem';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 24),
          // Botão de cadastro
          ElevatedButton(
            onPressed: _navigateToHome,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Cadastrar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          // Texto para login social
          const Text(
            'Ou continue com',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          // Botões de login social
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialLoginButton('google', 'assets/google.png'),
              _buildSocialLoginButton('facebook', 'assets/facebook.png'),
              _buildSocialLoginButton('apple', 'assets/apple.png'),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                // Logo do aplicativo
                Image.asset(
                  'assets/logo.jpg',
                  height: 120,
                ),
                const SizedBox(height: 40),
                // Barra de abas
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Login'),
                    Tab(text: 'Cadastro'),
                  ],
                ),
                const SizedBox(height: 30),
                // Conteúdo das abas
                SizedBox(
                  height: 500,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildLoginTab(),
                      _buildRegisterTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
