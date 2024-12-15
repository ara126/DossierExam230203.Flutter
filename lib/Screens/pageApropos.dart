import 'package:flutter/material.dart';
import 'package:examflutter/Screens/accueil_dmc.dart';

class PageApropos extends StatelessWidget {
  const PageApropos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "À propos",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // Titre principal
            Text(
              "À propos de myDMC",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 16),

            // Introduction
            Text(
              "Bienvenue chez myDMC, votre destination en ligne pour l'achat d'ordinateurs et de matériel informatique de qualité. Nous sommes passionnés par la technologie et nous nous engageons à offrir à nos clients une expérience d'achat exceptionnelle, en mettant à leur disposition une large gamme de produits à la pointe de l'innovation.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // Mission
            Text(
              "Notre Mission",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Chez myDMC, notre mission est de rendre la technologie accessible à tous en offrant des produits de haute qualité à des prix compétitifs. Nous croyons que chacun mérite de profiter des avantages de la technologie moderne, que ce soit pour travailler, apprendre, ou simplement se divertir.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // Valeurs
            Text(
              "Nos Valeurs",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "- Qualité : Nous sélectionnons rigoureusement nos produits pour garantir qu'ils répondent aux normes les plus élevées en termes de performance et de fiabilité.\n"
                  "- Service : Votre satisfaction est notre priorité. Nous nous efforçons de fournir un service client exceptionnel, avant, pendant et après votre achat.\n"
                  "- Innovation : Nous sommes toujours à la recherche des dernières tendances technologiques pour vous offrir les meilleurs produits.\n"
                  "- Confiance : Acheter en ligne peut parfois être intimidant. Nous nous engageons à protéger vos informations personnelles et à vous offrir un environnement d'achat sécurisé.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // Pourquoi choisir
            Text(
              "Pourquoi choisir myDMC ?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "- Large sélection : Que vous soyez à la recherche d'un ordinateur portable, d'un PC de bureau ou d'accessoires informatiques, vous trouverez tout ce dont vous avez besoin chez myDMC.\n"
                  "- Prix compétitifs : Nous travaillons directement avec les fabricants pour vous offrir les meilleurs prix possibles.\n"
                  "- Livraison rapide : Profitez d'une livraison rapide et fiable pour que vous puissiez commencer à utiliser votre nouvel équipement sans attendre.\n"
                  "- Assistance personnalisée : Notre équipe est disponible pour vous aider à choisir le produit qui répondra parfaitement à vos besoins.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // Contact
            Text(
              "Contactez-nous",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Nous sommes là pour vous aider à chaque étape de votre parcours d'achat. Si vous avez des questions ou des préoccupations, n'hésitez pas à nous contacter à contact@dmcomputer.sn ou par téléphone au +221 77 236 77 77.\n\n"
                  "Merci de faire confiance à myDMC pour tous vos besoins informatiques !",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
