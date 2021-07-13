import 'package:flutter/material.dart';

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Bonsoir à vous Mdm nous somme vraiment désolé pour le retard de la rémise"
              " de notre projet, nous avons eu un soucis avec notre serveur pour la mise en ligne"
              " du produit fin et cela nous a fait prendre énormément du retard.L'application est"
              " presque fini il ne manque que la partie comptable et une petite partie de chef"
              " projet . Nous vous remercions pour ce projet car ca nous a permis de developper "
              "nos compétences.",
          style: TextStyle(fontSize: 25,color: Colors.orange),),
        ),
      ),
    );
  }
}
