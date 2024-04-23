import 'package:flutter/material.dart';

import 'counter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title, super.key});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CounterBloc _counterBloc = CounterBloc(initialCount: 0, testModel: TestModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              StreamBuilder(
                  stream: _counterBloc.counterObservable,
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    return Text('${snapshot.data}',
                        style: Theme.of(context).textTheme.bodyMedium);
                  }),
              StreamBuilder(
                  stream: _counterBloc.testModelObservable,
                  builder: (context, AsyncSnapshot<TestModel> snapshot) {
                    return Text('${snapshot.data?.count ?? ''}',
                        style: Theme.of(context).textTheme.bodyMedium);
                  }),
            ],
          ),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: _counterBloc.increment,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              )),
          FloatingActionButton(
            onPressed: _counterBloc.decrement,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: _counterBloc.incrementModel,
            tooltip: 'ads click',
            child: const Icon(Icons.ads_click),
          ),
        ]));
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }
}
