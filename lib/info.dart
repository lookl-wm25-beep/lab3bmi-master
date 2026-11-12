import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key, required this.bmi});
  final String bmi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Body Mass Index Info"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      const Text('Body mass index (BMI) is a value derived from the mass (weight) and height of'
           'a person.\n\nThe BMI is defined as the body mass divided by the square of the body'
          'height, and is expressed in units of kg/m\u00B2, resulting from mass in kilograms'
          '(kg) and height in metres (m).'),

          bmi ==''?
              const Text('Please enter your body weight and height'):
              Text('Your Body Mass Index is  $bmi'),
          ElevatedButton(onPressed: (){
            Navigator.pop(context, 'Comment');
          },
          child: const Text('Go Back')
          ),
        ],
      ),
    );
  }
}
