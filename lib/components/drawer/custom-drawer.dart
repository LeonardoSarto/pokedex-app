import 'package:flutter/material.dart';
import 'package:pokedex_project/components/text-style/pokemon-solid-style.dart';
import 'package:pokedex_project/pages/config/config.dart';
import 'package:pokedex_project/utils/create-route.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: Column(
                children: [
                  Image.network(
                      "https://i0.wp.com/multarte.com.br/wp-content/uploads/2019/03/pokemon-png-logo.png?fit=2000%2C736&ssl=1",
                      scale: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.person_outline, color: Colors.white, size: 40),
                    title: Text("Bem-vindo Treinador(a)",
                        style: Theme.of(context).textTheme.titleSmall),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(child: Text("Perfil"),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(child: Text("Entrar"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: (){},
            child: ListTile(
              leading: Icon(Icons.catching_pokemon, color: Colors.white),
              title:
              Text("Pokédex", style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: (){},
            child: ListTile(
              leading: Icon(Icons.catching_pokemon, color: Colors.white),
              title:
              Text("Moves", style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: (){},
            child: ListTile(
              leading: Icon(Icons.catching_pokemon, color: Colors.white),
              title:
              Text("Itens ", style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: (){},
            child: ListTile(
              leading: Icon(Icons.catching_pokemon, color: Colors.white),
              title:
              Text("Habilidades", style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: (){},
            child: ListTile(
              leading: Icon(Icons.catching_pokemon, color: Colors.white),
              title:
              Text("Tipos", style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: (){},
            child: ListTile(
              leading: Icon(Icons.catching_pokemon, color: Colors.white),
              title:
              Text("Localização", style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          Divider(),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.push(context, CreateRoute.createRoute(const Config()));
            },
            child: ListTile(
              leading: Icon(Icons.settings_outlined, color: Colors.white),
              title: Text("Configurações", style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: (){},
            child: ListTile(
              leading: Icon(Icons.help_outline, color: Colors.white),
              title:
              Text("O que há de novo?", style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: (){},
            child: ListTile(
              leading: Icon(Icons.info_outline, color: Colors.white),
              title:
              Text("Sobre", style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
        ],
      ),
    );
  }
}
