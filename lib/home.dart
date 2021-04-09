import 'package:conversor_moedas/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _realChanged(String text) {
    print(text);
  }

  void _dolarChanged(String text) {
    print(text);
  }

  void _euroChanged(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("\$ Conversor \$"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando dados",
                    style: TextStyle(color: Colors.amber, fontSize: 24.0),
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao carregar dados :(",
                        style: TextStyle(color: Colors.amber, fontSize: 24.0)),
                  );
                } else {
                  dolar = snapshot.data['results']['currencies']['USD']['buy'];
                  euro = snapshot.data['results']['currencies']['EUR']['buy'];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.amber,
                        ),
                        buildTextField("Reais", "R\$", realController, _realChanged),
                        buildTextField("Dolar", "US\$", dolarController, _dolarChanged),
                        buildTextField("Euro", "€", euroController, _euroChanged)
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

buildTextField(String label, String prefix, TextEditingController controller,
    Function f) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 24.0),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}
