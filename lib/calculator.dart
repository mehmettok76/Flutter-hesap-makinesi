import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<String> butonlar = [
    "7",
    "8",
    "9",
    "X",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    "=",
    "<",
    "/",
    "CE"
  ];
  var operatorler = ["X", "-", "+", "/"];
  String sonuc = "";
  String operator = "";
  void butonTikla(String btn) {
    setState(() {
      if (int.tryParse(btn) != null) {
        sonuc += btn;
      } else if (btn == "CE") {
        sonuc = "";
        operator = "";
      } else if (btn == "<") {
        if (sonuc.length > 0) {
          if (sonuc[sonuc.length - 1] == "X" ||
              sonuc[sonuc.length - 1] == "-" ||
              sonuc[sonuc.length - 1] == "+" ||
              sonuc[sonuc.length - 1] == "/") {
            operator = "";
          }
          sonuc = sonuc.substring(0, sonuc.length - 1);
        }
      } else if (btn == "=") {
        if (sonuc.length > 0 && operator.length != null) {
          var sayilar = sonuc.split(operator);
          if (sayilar.length == 2) {
            int sayi1 = int.parse(sayilar[0]);
            int sayi2 = int.parse(sayilar[1]);
            if (operator == "+") {
              sonuc = (sayi1 + sayi2).toString();
            } else if (operator == "X") {
              sonuc = (sayi1 * sayi2).toString();
            } else if (operator == "-") {
              sonuc = (sayi1 - sayi2).toString();
            } else if (operator == "/") {
              sonuc = (sayi1 ~/ sayi2).toString();
            }
            operator = "";
          }
        }
      } else {
        if (operator == "") {
          operator = btn;
          sonuc += btn;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(sonuc,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 35, height: 2))),
          Divider(thickness: 2.0, color: Colors.black),
          Expanded(
              child: GridView.builder(
                  itemCount: butonlar.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemBuilder: ((context, index) {
                    return InkWell(
                        splashColor: Colors.amber,
                        onTap: () {
                          butonTikla(butonlar[index]);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: int.tryParse(butonlar[index]) != null
                                  ? Colors.orangeAccent
                                  : butonlar[index] == "CE"
                                      ? Colors.redAccent
                                      : Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              butonlar[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                              ),
                            )));
                  })))
        ],
      ),
    );
  }
}
