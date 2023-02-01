import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pokedex_project/components/alert-dialog/change-theme.dart';
import 'package:provider/provider.dart';
import '../../components/alert-dialog/change-language.dart';
import '../../models/model-theme.dart';

class Config extends StatefulWidget {
  const Config({Key? key}) : super(key: key);

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> with WidgetsBindingObserver {
  PermissionStatus? _notificationStatus;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Permission.notification.status.then(_updateStatus);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Permission.notification.status.then(_updateStatus);
    }
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _notificationStatus) {
      setState(() {
        _notificationStatus = status; // update
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Configurações"),
              elevation: 3,
              automaticallyImplyLeading: true,
            ),
            body: Center(
              child: Column(
                children: [
                  MaterialButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) => ChangeLanguage());
                    },
                    child: ListTile(
                      title: Text("Idioma da interface"),
                      subtitle: Text("Português (Portuguese)"),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) => ChangeTheme());
                    },
                    child: ListTile(
                      title: Text("Tema do aplicativo"),
                      subtitle: Text(themeNotifier.isDark ? "Modo escuro" : themeNotifier.isSystem ? "Definido pelo sistema" : "Modo claro"),
                    ),
                  ),

                  MaterialButton(
                    onPressed: () async {
                      openAppSettings();
                    },
                    child: ListTile(
                      title: Text("Notificações"),
                      subtitle: Text("Você receberá notificações sobre novas atualizações e correções de bugs"),
                      trailing: Switch(
                          onChanged: (value) {
                          },
                          value: _notificationStatus!.isGranted
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
