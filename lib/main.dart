import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final List<String> _itens =
      List.generate(16, (index) => index == 0 ? '' : index.toString());
  _changeIndex(int i) {
    int _emptyIndex = _itens.lastIndexOf('');
    int _previousItem = i - 1;
    int _nextItem = i + 1;
    int _previousRow = i - 4;
    int _nextRow = i + 4;

    if (_emptyIndex == _previousItem) {
      _itens[_previousItem] = _itens[i];

      _itens[i] = '';
    } else if (_emptyIndex == _nextItem) {
      _itens[_nextItem] = _itens[i];

      _itens[i] = '';
    } else if (_emptyIndex == _previousRow) {
      _itens[_previousRow] = _itens[i];

      _itens[i] = '';
    } else if (_emptyIndex == _nextRow) {
      _itens[_nextRow] = _itens[i];

      _itens[i] = '';
    }
    setState(() {});
  }

  @override
  void initState() {
    _itens.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner:
    false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku'),
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
