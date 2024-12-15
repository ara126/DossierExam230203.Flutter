import 'dart:async';
import 'dart:convert';
import 'package:examflutter/Screens/pageDeconnexion.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:examflutter/Screens/PolitiqueDeConfidentialit%C3%A9.dart';
import 'package:examflutter/Screens/pageApropos.dart';
import 'package:examflutter/Screens/pageConnexion.dart';
import 'package:examflutter/Screens/pageFavorite.dart';
import 'package:examflutter/Screens/pagePanier.dart';
import 'package:examflutter/Screens/pageBarreRecherche.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class AccueilDMC extends StatefulWidget {
  const AccueilDMC({super.key});  // Si vous utilisez Flutter 3 ou une version plus récente
  // const AccueilDMC({Key? key}) : super(key: key); // Alternative pour les versions antérieures

  @override
  State<AccueilDMC> createState() => _AccueilDMCState();
}


class _AccueilDMCState extends State<AccueilDMC> {
  final List<String> images = [
    'image/dmc2.jpg',
    'image/tablettehp.jpg',
    'image/ordinateur.jpg',
    'image/bafflehp.jpg',
  ];

  List<dynamic> categories = [];
  List<dynamic> products = [];
  String selectedCategory = "Toutes";
  bool isLoadingCategories = false;
  bool isLoadingProducts = false;
  Set<int> favoriteProducts = {}; // Liste des produits favoris (utilisation d'un Set pour éviter les doublons)

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchProducts();
  }

  // Ajouter un produit aux favoris ou le retirer
  void toggleFavorite(int productId) {
    setState(() {
      if (favoriteProducts.contains(productId)) {
        favoriteProducts.remove(productId);
      } else {
        favoriteProducts.add(productId);
      }
    });
  }

  // Récupérer les produits
  Future<void> fetchProducts([int? categoryId]) async {
    setState(() {
      isLoadingProducts = true;
    });

    String url = 'https://dmcomputer.sn/wp-json/wc/v3/products';
    if (categoryId != null) {
      url += '?category=$categoryId';
    }

    final String credentials = 'ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35';
    final String encodedCredentials = base64Encode(utf8.encode(credentials));
    final Map<String, String> headers = {
      'Authorization': 'Basic $encodedCredentials',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          products = jsonDecode(response.body);
        });
      } else {
        print('Erreur lors de la récupération des produits : ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur réseau : $e');
    } finally {
      setState(() {
        isLoadingProducts = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "DMComputer.sn",
          style: TextStyle(color: Colors.white),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CarouselSlider(
              items: images.map((imagePath) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: true,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Catégories",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Voir tout",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (isLoadingCategories)
              const Center(child: CircularProgressIndicator())
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = "Toutes";
                          fetchProducts();
                        });
                      },
                      child: const Text("Toutes"),
                    ),
                    ...categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedCategory = category['name'];
                              fetchProducts(category['id']);
                            });
                          },
                          child: Text(category['name']),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final isFavorite = favoriteProducts.contains(product['id']);

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image du produit
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.network(
                            product['images']?.isNotEmpty == true
                                ? product['images'][0]['src']
                                : 'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                            height: 120,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'] ?? 'Produit inconnu',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${product['price'] ?? 'Non disponible'} FCFA",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    // Ajoute ou retire des favoris
                                    toggleFavorite(product['id']);
                                  });

                                  // Navigue vers la page des favoris après avoir mis à jour les favoris
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PageFavorite(
                                        favoriteProducts: products
                                            .where((product) => favoriteProducts.contains(product['id']))
                                            .cast<Map<String, dynamic>>() // Conversion explicite du type
                                            .toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),


                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: const LateralMenu(),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: Colors.green,
            tabBackgroundColor: Colors.grey.shade400,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(icon: Icons.home, text: "Accueil"),
              GButton(icon: Icons.search, text: "Rechercher"),
              GButton(icon: Icons.shopping_bag_sharp, text: "Magasin"),
              GButton(icon: Icons.person, text: "Login"),
            ],
            onTabChange: (index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccueilDMC()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PageBarreRecherche()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const pagePanier()),
                );
              } else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PageConnexion()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
  Future<void> fetchCategories() async {
    setState(() {
      isLoadingCategories = true;
    });

    const url = 'https://dmcomputer.sn/wp-json/wc/v3/products/categories';
    final String credentials = 'ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35';
    final String encodedCredentials = base64Encode(utf8.encode(credentials));
    final Map<String, String> headers = {
      'Authorization': 'Basic $encodedCredentials',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          categories = jsonDecode(response.body);
        });
      } else {
        print('Erreur lors de la récupération des catégories : ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur réseau : $e');
    } finally {
      setState(() {
        isLoadingCategories = false;
      });
    }
  }
}
class LateralMenu extends StatelessWidget {
  const LateralMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            enteteDuMenuLateral(context),
            elementDuMenuLateral(context),
          ],
        ),
      ),
    );
  }
}
Widget enteteDuMenuLateral(BuildContext context) => Container(
  padding: EdgeInsets.only(
    top: MediaQuery.of(context).padding.top,
    bottom: 20,
  ),
  child: Column(
    children: [
      Image.asset(
        'image/entetenavdmc2.png',
        fit: BoxFit.cover,
        width: 600,
      ),
    ],
  ),
);

Widget elementDuMenuLateral(BuildContext context) => Container(
  padding: const EdgeInsets.all(24),
  child: Wrap(
    runSpacing: 16,
    children: [
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text("Accueil"),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AccueilDMC()),
          );
        },
      ),


      ListTile(
        leading: const Icon(Icons.search),
        title: const Text("Recherche"),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PageBarreRecherche()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.shopping_cart),
        title: const Text("Panier"),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => pagePanier()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.share),
        title: const Text("Partager"),
        onTap: () {
          Share.share(
            "Bonjour ! Découvrez notre application : DMComputer.sn",
            subject: "Rejoignez-nous sur DMComputer.sn !",
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text("Mon Compte"),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PageConnexion()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.info),
        title: const Text("À propos"),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PageApropos()),
          );
        },
      ),

      ListTile(
        leading: const Icon(Icons.lock),
        title: const Text("Politique de Confidentialité"),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PolitiqueDeConfidentialite()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text("Déconnexion"),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PageDeconnexion()),
          );
        },
      ),
    ],
  ),
);

