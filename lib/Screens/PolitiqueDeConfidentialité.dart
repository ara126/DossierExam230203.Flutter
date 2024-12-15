import 'package:flutter/material.dart';
import 'package:examflutter/Screens/accueil_dmc.dart';

class PolitiqueDeConfidentialite extends StatelessWidget {
  const PolitiqueDeConfidentialite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "Politique de Confidentialité",
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
              "Politique de Confidentialité de myDMC",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Dernière mise à jour : 13 Août 2024",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),

            // Introduction
            Text(
              "Chez myDMC, la confidentialité et la sécurité de vos informations personnelles sont d'une importance primordiale. Cette politique de confidentialité décrit comment nous recueillons, utilisons, divulguons et protégeons vos informations lorsque vous utilisez notre application e-commerce de vente d'ordinateurs.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // Section 1
            Text(
              "1. Collecte des informations",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "- Informations personnelles : nom, adresse e-mail, numéro de téléphone, adresse de livraison.\n"
                  "- Informations de compte : identifiant, mot de passe.\n"
                  "- Informations de paiement : détails de carte de crédit ou autres informations de facturation (gérés par nos partenaires de paiement sécurisé).\n"
                  "- Informations techniques : adresse IP, type d'appareil, système d'exploitation, comportement de navigation et d'achat.\n"
                  "- Informations sur les achats : historique des commandes, préférences de produit.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // Section 2
            Text(
              "2. Utilisation des informations",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Nous utilisons vos informations pour :\n"
                  "- Gérer votre compte et traiter vos commandes.\n"
                  "- Faciliter la livraison de vos achats.\n"
                  "- Améliorer votre expérience utilisateur en personnalisant nos services et nos offres.\n"
                  "- Vous informer sur l'état de vos commandes, les nouvelles offres ou les mises à jour.\n"
                  "- Répondre à vos demandes d'assistance et améliorer notre service clientèle.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // Section 3
            Text(
              "3. Partage des informations",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Nous respectons votre vie privée et ne partageons vos informations personnelles avec des tiers que dans les cas suivants :\n"
                  "- Lorsque vous nous en donnez l'autorisation explicite.\n"
                  "- Pour se conformer à des obligations légales ou des demandes des autorités.\n"
                  "- Avec nos partenaires de confiance qui nous aident à fournir nos services (comme les services de livraison et de paiement).\n"
                  "- Pour protéger les droits, la propriété ou la sécurité de myDMC, de nos utilisateurs ou du public.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // Section 4
            Text(
              "4. Sécurité des données",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Nous utilisons des mesures de sécurité robustes pour protéger vos informations personnelles contre l'accès non autorisé, la perte ou l'altération. Toutefois, aucune méthode de transmission ou de stockage des données n'est entièrement sécurisée et nous ne pouvons garantir une sécurité absolue.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // Section 5
            Text(
              "5. Conservation des données",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Nous conservons vos informations personnelles aussi longtemps que nécessaire pour remplir les objectifs décrits dans cette politique, ou pour répondre à nos obligations légales, résoudre des litiges et faire respecter nos accords.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // Section 6
            Text(
              "6. Vos droits",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "En tant qu'utilisateur de myDMC, vous avez le droit de :\n"
                  "- Accéder aux informations personnelles que nous détenons sur vous.\n"
                  "- Demander la correction de toute information incorrecte ou incomplète.\n"
                  "- Demander la suppression de vos informations personnelles, sous réserve des exigences légales.\n"
                  "- Retirer votre consentement au traitement de vos données à tout moment.\n\n"
                  "Pour exercer ces droits, veuillez nous contacter à l'adresse suivante : contact@dmcomputer.sn.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // Conclusion
            Text(
              "Merci d'avoir choisi myDMC. Nous sommes engagés à protéger vos données et à vous offrir une expérience sécurisée.",
              style: TextStyle(fontSize: 16, height: 1.5, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
