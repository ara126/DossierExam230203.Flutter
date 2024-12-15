import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'pageConnexion.dart'; // Assurez-vous que le fichier pageConnexion.dart est bien importé

class PageInscription extends StatefulWidget {
  const PageInscription({Key? key}) : super(key: key);

  @override
  State<PageInscription> createState() => _PageInscriptionState();
}

class _PageInscriptionState extends State<PageInscription> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  Future<void> _register() async {
    setState(() {
      isLoading = true;
    });

    const String registerUrl = 'https://dmcomputer.sn/wp-json/wc/v3/customers';

    try {
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic Y2tfY2UyMTc1Mjg3ZjEzYmUzZWRiOGM4YmI4ODRlMmU5MDUxY2ZlMDhhZDpjc19jOTVjNWJiNjAyN2ZkOTE4NDY2ZGQxODgyM2E3OGEyMjdhMmQwYjM1"
        },
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "username": nameController.text.trim(),
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Inscription réussie !")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PageConnexion()),
        );
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Erreur d'inscription.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : ${e.toString()}")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text("Inscription",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Coins arrondis
              ),

              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Bienvenue",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Inscrivez-vous pour entrer",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 30,),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            labelText: "Nom d'utilisateur",
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)
                            )
                        ),
                      ),
                      // Champ Email
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16), // Espacement vertical
                      // Champ Mot de passe
                      TextFormField(
                        controller: passwordController,

                        decoration: const InputDecoration(
                          labelText: "Mot de passe",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: const Icon(Icons.visibility_off),
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true, // Cache le mot de passe
                      ),
                      const SizedBox(height: 16),

                      // Bouton de connexion
                      ElevatedButton(
                        onPressed: isLoading ? null : _register,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("S'inscrire"),

                      ),
                      SizedBox(height: 30,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              const Text("Vous avez déjà un compte ?",
                                style: TextStyle(color: Colors.grey),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                      builder: (context) => PageConnexion()
                                  )
                                  );
                                },
                                child: Text("Se connecter",
                                  style: TextStyle(
                                      color: Colors.green
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


