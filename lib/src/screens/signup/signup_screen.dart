import 'package:flutter/material.dart';

import 'package:loja_virtual/src/helpers/validators.dart';
import 'package:loja_virtual/src/models/user.dart' as us;
import 'package:loja_virtual/src/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final us.User user = us.User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Nome completo'),
                    enabled: !userManager.loading,
                    validator: (name) {
                      if (name == null) {
                        return 'Campo obrigatório';
                      } else if (name.trim().split(' ').length <= 1) {
                        return 'Preencha seu nome completo';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (name) => user.name = name,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    enabled: !userManager.loading,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email == null) {
                        return 'Campo obrigatório';
                      } else if (!emailValid(email)) {
                        return 'E-mail inválido';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (email) => user.email = email,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Senha'),
                    enabled: !userManager.loading,
                    obscureText: true,
                    validator: (password) {
                      if (password == null) {
                        return 'Campo obrigatório';
                      } else if (password.length < 6) {
                        return 'Senha muito curta';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (password) => user.password = password,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Repita a senha'),
                    enabled: !userManager.loading,
                    obscureText: true,
                    validator: (password) {
                      if (password == null) {
                        return 'Campo obrigatório';
                      } else if (password.length < 6) {
                        return 'Senha muito curta';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (password) => user.confirmPassword = password,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                        onSurface:
                            Theme.of(context).primaryColor.withAlpha(100),
                      ),
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (formKey.currentState?.validate() ?? false) {
                                formKey.currentState?.save();

                                if (user.password != user.confirmPassword) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Senhas não coincidem!',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                userManager.signUp(
                                  user: user,
                                  onSuccess: () {
                                    Navigator.of(context).pop();
                                  },
                                  onFail: (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          e as String,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                      child: userManager.loading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text(
                              'Criar conta',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
