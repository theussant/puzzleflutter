import 'package:flutter/material.dart';
import 'dart:async';
const IconData shuffle = IconData(0xe5a1, fontFamily: 'MaterialIcons');


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> ganhouWidget = <Widget>[
    const Text('Jogando...'),
    const Text('Parabéns você ganhou!')
  ];

  final List<String> _itens = List.generate(16, (index) => index == 0 ? '' : index.toString());
  int ganhador = 0;
  int cont = 0;
  _changeIndex(int i) {
    if (cont == 0) {
      startTimer();
    }

    int emptyIndex = _itens.lastIndexOf('');
    int previousItem = i - 1;
    int nextItem = i + 1;
    int previousRow = i - 4;
    int nextRow = i + 4;
    int a = 1;
    int j;
    int verificar = 1;

    if (emptyIndex == previousItem) {
      _itens[previousItem] = _itens[i];

      _itens[i] = '';
      cont++;
    } else if (emptyIndex == nextItem) {
      _itens[nextItem] = _itens[i];

      _itens[i] = '';
      cont++;
    } else if (emptyIndex == previousRow) {
      _itens[previousRow] = _itens[i];

      _itens[i] = '';
      cont++;
    } else if (emptyIndex == nextRow) {
      _itens[nextRow] = _itens[i];

      _itens[i] = '';
      cont++;
    }

    for (j = 1; j <= 15; j++) {
      ganhouWidget[verificar];
      print(_itens[j]);
      print(a);

      if (verificar == 1) {
        if (_itens[j] == a.toString()) {
          a++;
        } else {
          verificar = 0;
        }
      }
    }

    if (verificar == 1) {
      ganhouWidget[verificar];
    }

    teste(verificar);

    setState(() {});
  }

  teste(int verificar) {
    setState(() {
      ganhador = verificar;
    });
  }


  int _start = 0;

  String minutes = "00";
  String seconds = "00";
  int m = 0;

  void startTimer() {
    const secs = Duration(seconds: 1);
    // ignore: unnecessary_new
    new Timer.periodic(
      secs,
      (Timer timer) {
        if (ganhador == 1) {
            setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start++;
            if (_start == 60){
              m++;
              _start = 0;
            }
            if (_start >= 10 ){
              seconds = _start.toString();
            }
            else {
              seconds = "0$_start";
            }
            if (m >= 10){
              minutes = m.toString();
            }
            else {
              minutes = "0$m";
            }
          });
        }
      },
    );
  }


  @override
  void initState() {
    //_itens.shuffle();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: ganhouWidget[ganhador]),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            tooltip: 'Randomizar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Randomizando')));
                  _itens.shuffle();
            },
          ),
          Text("$cont Jogadas  ",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text("$minutes:$seconds",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
      
      body: Center(
        child: AspectRatio(
            aspectRatio: 1,
            child: GridView.count(
              crossAxisCount: 4,
              children: [
                for (int i = 0; i < 16; i++)
                  InkWell(
                    onTap: () {
                      _changeIndex(i);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: _itens[i].isEmpty ? Colors.white : Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          _itens[i],
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
              ],
            )),
      ),
    );
  }
}
