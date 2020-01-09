import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(title: "Tip Calculator", home: TipCalculator()));

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  var selectorRange = RangeValues(0, 100);
  num peopleSplitting = 1;
  num sliderValue = 0;
  num totalPerPerson = 0;
  num totalBillAmt = 250;
  num totalTipAmnt = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(0, 50.0, 0, 50),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent.shade100,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Text(
                      "Total Per Person",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      "\$ $totalPerPerson",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ))),
            Card(
                child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    Text("Bill Amount"),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                    ),
                    Text(
                      "$totalBillAmt",
                      style: TextStyle(color: Colors.lightBlueAccent.shade100),
                    )
                  ]),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Split btn"),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              reducePersonCount();
                            },
                            color: Colors.lightBlueAccent.shade100,
                          ),
                          Text('$peopleSplitting'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              addPersonCount();
                            },
                            color: Colors.lightBlueAccent.shade100,
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total Tip"),
                      Text(
                        "\$ $totalTipAmnt",
                        style:
                            TextStyle(color: Colors.lightBlueAccent.shade100),
                      )
                    ],
                  ),
                  Slider.adaptive(
                    min: 0,
                    max: 100,
                    divisions: 10,
                    value: sliderValue.toDouble(),
                    label: sliderValue.toString(),
                    onChanged: (double newValue) {
                      setState(() {
                        sliderValue = newValue;
                        if (newValue == 0) {
                          totalPerPerson = 0;
                          return;
                        }
                        calculateTip(sliderValue);
                      });
                    },
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void reducePersonCount() {
    setState(() {
      peopleSplitting = peopleSplitting == 1 ? 1 : peopleSplitting -= 1;
      calculateTip(sliderValue);
    });
  }

  void addPersonCount() {
    setState(() {
      peopleSplitting += 1;
      calculateTip(sliderValue);
    });
  }

  void calculateTip(double newValue) {
    totalTipAmnt = totalBillAmt * (newValue.toInt() / 100);
    totalPerPerson = totalTipAmnt ~/ peopleSplitting;
  }
}
