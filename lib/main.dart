import 'package:flutter/material.dart';
import 'dart:async';

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

    int _emptyIndex = _itens.lastIndexOf('');
    int _previousItem = i - 1;
    int _nextItem = i + 1;
    int _previousRow = i - 4;
    int _nextRow = i + 4;
    int a = 1;
    int j;
    int verificar = 1;

    if (_emptyIndex == _previousItem) {
      _itens[_previousItem] = _itens[i];

      _itens[i] = '';
      cont++;
    } else if (_emptyIndex == _nextItem) {
      _itens[_nextItem] = _itens[i];

      _itens[i] = '';
      cont++;
    } else if (_emptyIndex == _previousRow) {
      _itens[_previousRow] = _itens[i];

      _itens[i] = '';
      cont++;
    } else if (_emptyIndex == _nextRow) {
      _itens[_nextRow] = _itens[i];

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

  void startTimer() {
    const secs = const Duration(seconds: 1);
    // ignore: unnecessary_new
    new Timer.periodic(
      secs,
      (Timer timer) {
        if (_start == 50000) {
          setState(() {
            timer.cancel();
          });
        } else if (ganhador == 1) {
            setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start++;
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
          Text(cont.toString() + " Jogadas  ",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text(_start.toString() + " Tempo  ",
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
                          '${_itens[i]}',
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
