import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:loja_virtual/src/helpers/validators.dart';
import 'package:loja_virtual/src/models/user_manager.dart';
import 'package:loja_virtual/src/models/user.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            child: const Text(
              'CRIAR CONTA',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email ?? 'null@null.com')) {
                          return 'Email inválido';
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      autocorrect: false,
                      obscureText: true,
                      validator: (password) {
                        if (password == null || password.length < 6) {
                          return 'Senha inválida';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('Esqueci minha senha'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState?.validate() ?? false) {
                                  userManager.signIn(
                                    user: User(
                                      emailController.text,
                                      passwordController.text,
                                    ),
                                    onFail: (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          e as String,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        backgroundColor: Colors.red,
                                      ));
                                    },
                                    onSuccess: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Colors.white,
                          onSurface:
                              Theme.of(context).primaryColor.withAlpha(100),
                        ),
                        child: userManager.loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
