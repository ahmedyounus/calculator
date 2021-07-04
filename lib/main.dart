import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Calculator",
  theme: ThemeData(primarySwatch: Colors.blue),
      home:SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double eqfs = 38.8;
  double rfs = 48.0;

  buttonPressed(String name){
    setState(() {
      if (name == "C"){
         equation = "0";
         result = "0";
         eqfs = 38.8;
         rfs = 48.0;
      }

      else if (name == "⌫") {
        eqfs = 38.8;
        rfs = 48.0;
        equation = equation.substring(0,equation.length-1);
        if (equation == ""){
          equation = "0";
        }
        }
    else if(name == "=" ){
        eqfs = 38.8;
        rfs = 48.0;
        expression = equation;
        expression = expression.replaceAll("÷", "/");
        expression = expression.replaceAll("×", "*");
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }
      }
    else {eqfs = 38.8;
      rfs = 48.0;
    if (equation == "0"){
      equation = name;}
    else{equation = equation + name;

    }
    }
    });
  }
  Widget buildButton(String name, double butH, Color butCol){
    return Container(height: MediaQuery.of(context).size.height * 0.1 * butH,
      color: butCol,
      child: FlatButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: Colors.white,
              width: 1,
              style: BorderStyle.solid)
      ),
        padding: EdgeInsets.all(16),
        onPressed: () => buttonPressed(name),
        child: Text(name, style: TextStyle(fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.white),),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: (AppBar( centerTitle: true,
      title: Text("Simple Calculator"),

    )
     ),
      body:Column(children:[Container(alignment: Alignment.centerRight
          ,padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child:Text(equation, style: TextStyle(fontSize: eqfs))),


        Container(alignment: Alignment.centerRight
            ,padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child:Text(result, style: TextStyle(fontSize: rfs))),
Expanded(
  child: Divider()
),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: MediaQuery.of(context).size.width*.75,
            child: Table(
              children: [
                TableRow(
                  children: [buildButton("C", 1, Colors.red),
                             buildButton("⌫", 1, Colors.blue),
                             buildButton("÷", 1, Colors.blue),
                  ]
                ),
                TableRow(
                    children: [buildButton("7", 1, Colors.black),
                      buildButton("8", 1, Colors.black),
                      buildButton("9", 1, Colors.black),
                    ]
                ),
                TableRow(
                    children: [buildButton("4", 1, Colors.black),
                      buildButton("5", 1, Colors.black),
                      buildButton("6", 1, Colors.black),
                    ]
                ),
                TableRow(
                    children: [buildButton("1", 1, Colors.black),
                      buildButton("2", 1, Colors.black),
                      buildButton("3", 1, Colors.black),
                    ]
                ),
                TableRow(
                    children: [buildButton(".", 1, Colors.black),
                      buildButton("0", 1, Colors.black),
                      buildButton("00", 1, Colors.black),
                    ]
                ),
              ],
            ),
            ),

    Container(width: MediaQuery.of(context).size.width*.25,
        child: Table(
          children: [
            TableRow(
                children: [buildButton("×", 1, Colors.blue),
                ]
            ),

            TableRow(
                children: [buildButton("-", 1, Colors.blue),
                  ]
            ),

            TableRow(
                children: [buildButton("+", 1, Colors.blue),
                ]
            ),
            TableRow(
                children: [buildButton("=", 2, Colors.red),
                ]
            ),
                      ]
    ),
    ),


          ],
        )
      ]
    )
    );
  }
}

