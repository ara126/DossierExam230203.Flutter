import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:examflutter/Screens/accueil_dmc.dart';

class PageBarreRecherche extends StatefulWidget {
  const PageBarreRecherche({super.key});

  @override
  State<PageBarreRecherche> createState() => _PageBarreRechercheState();
}

class _PageBarreRechercheState extends State<PageBarreRecherche> {
  TextEditingController _controller = TextEditingController();
  List<dynamic> produits = []; // Liste des produits trouvés via la recherche
  bool isLoading = false;

  // Fonction pour rechercher les produits via l'API
  Future<void> rechercherProduit(String query) async {
    setState(() {
      isLoading = true; // Afficher un indicateur de chargement
      produits = []; // Réinitialiser la liste des produits
    });

    const url = 'https://dmcomputer.sn/wp-json/wc/v3/products';
    final String credentials = 'ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35';
    final String encodedCredentials = base64Encode(utf8.encode(credentials));
    final Map<String, String> headers = {
      'Authorization': 'Basic $encodedCredentials',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(Uri.parse('$url?search=$query'), headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          produits = data;
          isLoading = false; // Désactiver l'indicateur de chargement
        });
      } else {
        print('Erreur lors de la récupération des produits');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Erreur réseau : $e');
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
        backgroundColor: Colors.green,
        title: const Text(
          "DMComputer.sn",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Icône de la flèche de retour
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AccueilDMC()),
            );
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.shopping_cart,
              size: 28,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Rechercher un produit...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    String query = _controller.text.trim();
                    if (query.isNotEmpty) {
                      rechercherProduit(query); // Effectuer la recherche
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Affichage des résultats de la recherche
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : produits.isEmpty
                ? const Center(child: Text("Aucun produit trouvé"))
                : Expanded(
              child: ListView.builder(
                itemCount: produits.length,
                itemBuilder: (context, index) {
                  var produit = produits[index];
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
