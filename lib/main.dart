import 'dart:math';


import 'package:flutter/material.dart';
import 'package:lab3bmi/info.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});



// This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Body Mass Index'),
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
  double _weight = 0.0;
  double _height = 0.0;

  double _bmi = 0.0;
  String _bmiImage = "assets/images/empty.png";
  String _bmiOutput = "";




  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();


  void _calculatorBMI() {
    _weight = double.tryParse(_weightCtrl.text)!;
    _height = double.tryParse(_heightCtrl.text)!;
    _bmi = _weight/pow(_height/100, 2);


    setState(() {
      if(_bmi < 18.5){
        _bmiImage = "assets/images/under.png";
        //String bmiString = _bmi.toStringAsPrecision(2);
        _bmiOutput = "${_bmi.toStringAsFixed(2)} [Underweight]";
      }else if (_bmi >= 18.5 && _bmi <= 24.5){
        _bmiImage = "assets/images/normal.png";
        _bmiOutput = "${_bmi.toStringAsFixed(2)}[Normal]";
      }else{
        _bmiImage = "assets/images/over.png";
        _bmiOutput = "${_bmi.toStringAsFixed(2)}[Overweight]";
      }
    });
  }


  void _restScreen(){
    _weightCtrl.clear();
    _heightCtrl.clear();
    _bmi = 0.0;
    setState((){
      _bmiImage = "assets/images/empty.png";
      _bmiOutput = "";
    });
  }



  @override
  void dispose(){
    super.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

// Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            spacing: 8,
            children: [
              Image.asset(_bmiImage),
              const Text('Your body mass index is:'),
              Text(
                _bmiOutput,
                style: Theme.of(context).textTheme.headlineMedium,
              ),


              TextField(
                controller: _weightCtrl,
                decoration: InputDecoration(
                    label: Text("Weight (kg)")
                ),
              ),


              TextField(
                controller: _heightCtrl,
                decoration: InputDecoration(
                    label: Text("height (kg)")
                ),
              ),

              IconButton(
                icon: const Icon(Icons.info),
                iconSize: 48.0,
                color: Colors.orangeAccent,
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Info(bmi: _bmiOutput,)),
                  ).then((value){
                    if(value !=null){
                      setState(() { _bmiOutput = value;});
                    }
                  }
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  ElevatedButton(onPressed: _calculatorBMI, child: Text("calculate BMI")),
                  ElevatedButton(onPressed: _restScreen, child: Text("Rest"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}