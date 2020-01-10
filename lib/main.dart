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
  num sliderValue = 0.0;
  num totalPerPerson = 0;
  num totalBillAmt = 0;
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
                margin: EdgeInsets.only(bottom: 20),
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
                    Expanded(
                      child: TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(color: Colors.grey.shade700),
                        decoration: InputDecoration(prefixText: "Total Bill"),
                        onChanged: (String str) {
                          totalBillAmt = int.tryParse(str) ?? totalBillAmt;
                          calculateTip();
                        },
                      ),
                    ),
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
                      Text("Split btn",
                          style: TextStyle(color: Colors.grey.shade700)),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              reducePersonCount();
                            },
                            child: Container(
                                width: 25,
                                height: 25,
                                color: Colors.lightBlueAccent.shade100,
                                margin: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                )),
                          ),
                          Text('$peopleSplitting',
                              style: TextStyle(color: Colors.grey.shade700)),
                          InkWell(
                            onTap: () {
                              addPersonCount();
                            },
                            child: Container(
                                width: 25,
                                height: 25,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent.shade100,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total Tip",
                          style: TextStyle(color: Colors.grey.shade700)),
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
                      sliderValue = newValue;
                      if (newValue == 0) {
                        totalPerPerson = 0;
                        return;
                      }
                      calculateTip();
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
      calculateTip();
    });
  }

  void addPersonCount() {
    setState(() {
      peopleSplitting += 1;
      calculateTip();
    });
  }

  void calculateTip() {
    setState(() {
      totalTipAmnt = totalBillAmt * (sliderValue.toInt() / 100);
      totalPerPerson = totalTipAmnt ~/ peopleSplitting;
    });
  }
}
