import 'package:artista_button/artista_button.dart';
import 'package:artista_config/artista_config.dart';
import 'package:flutter/material.dart';

void main()  async {
  try {
    await initializeArtista();
    final gg = getArtistaConfig<ArtistaConfig>();
    gg.setConfig(ArtistaConfigModel(
        colors: ArtistaColorModel(primary: Colors.green),
        spacing: SpacinConfig(baseUnit: 52)
    ));

  } catch (e) {}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ArtistaButton.outline(
              buttonSize: ButtonSize.lg,
              buttonColor: ButtonColor.primary,
              child: const Text("button"),
              onPressed: () {},
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
