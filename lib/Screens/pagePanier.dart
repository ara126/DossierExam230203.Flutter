import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:examflutter/Screens/accueil_dmc.dart';

class pagePanier extends StatefulWidget {
  const pagePanier({super.key});

  @override
  State<pagePanier> createState() => _pagePanierState();
}

class _pagePanierState extends State<pagePanier> {
  List<dynamic> panier = []; // Liste des produits dans le panier

  // Fonction pour ajouter un produit au panier
  void ajouterAuPanier(dynamic produit) {
    setState(() {
      panier.add(produit);
    });
  }

  // Fonction pour augmenter la quantité d'un produit
  void augmenterQuantite(int index) {
    setState(() {
      panier[index]['quantite']++;
    });
  }

  // Fonction pour diminuer la quantité d'un produit
  void diminuerQuantite(int index) {
    setState(() {
      if (panier[index]['quantite'] > 1) {
        panier[index]['quantite']--;
      }
    });
  }

  // Fonction pour supprimer un produit du panier
  void supprimerProduit(int index) {
    setState(() {
      panier.removeAt(index);
    });
  }

  // Fonction pour récupérer les produits depuis l'API WooCommerce
  Future<void> fetchProducts() async {
    const url = 'https://dmcomputer.sn/wp-json/wc/v3/products';
    final String credentials = 'ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35';
    final String encodedCredentials = base64Encode(utf8.encode(credentials));
    final Map<String, String> headers = {
      'Authorization': 'Basic $encodedCredentials',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> products = jsonDecode(response.body);
        // Assurez-vous que chaque produit contient une clé 'quantite'
        for (var product in products) {
          product['quantite'] = 1;
        }
        setState(() {
          panier = products; // Mise à jour des produits avec leur quantité
        });
      } else {
        print('Erreur lors de la récupération des produits : ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur réseau : $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Charger les produits à l'initialisation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "Mon Panier",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AccueilDMC()),
            );
          },
        ),
      ),
      body: panier.isEmpty
          ? const Center(child: Text("Votre panier est vide"))
          : ListView.builder(
        itemCount: panier.length,
        itemBuilder: (context, index) {
          var produit = panier[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  produit['images'][0]['src'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(produit['name']),
              subtitle: Text('${produit['price']} FCFA'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => diminuerQuantite(index),
                  ),
                  Text(produit['quantite'].toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => augmenterQuantite(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => supprimerProduit(index),
                  ),
                ],
              ),
              onTap: () {
                // Ajouter au panier via cœur
                ajouterAuPanier(produit);
              },
            ),
          );
        },
      ),

    );
  }
}
