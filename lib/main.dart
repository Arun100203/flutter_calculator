import 'package:flutter/material.dart';
import 'package:dart_eval/dart_eval.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const MyHomeWidget(),
    );
  }
}

class MyHomeWidget extends StatefulWidget {
  const MyHomeWidget({Key? key}) : super(key: key);

  @override
  State<MyHomeWidget> createState() => _MyHomeWidgetState();
}

class _MyHomeWidgetState extends State<MyHomeWidget> {

  String res="",ans="";

  Widget button(String num) {

    void onclick(String n) {

      if(res.length>16) {     //for remove "invalid operation" in the ans value
        ans = res.substring(17, res.length);
      }
      if(n=='c'){   // for clearing the space
        res="";
        ans="";
      }
      if(n!='=' && n!='c'){
        res = ans + n;
      }
      if(n=='='){       // handling exception in eval() function
        try{
          res = eval(ans).toString();
        }on Exception{
          print("invalid operation");
          res = "invalid Operation";
        }

      }

      setState(() {     // for change the value of ans dynamically
          ans = res;
          //print(eval(ans));
      });
    }

    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          onclick(num);
        },
        child: Text(num, style: const TextStyle(fontSize: 50,),),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: AppBar(
            title: const Text(
              'flutter app', style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.black,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.00),
                  alignment: Alignment.bottomRight,
                  child: Text(ans, style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.w700),),
                ),
              ),
              Row(
                children: <Widget>[
                  button("9"),
                  button("8"),
                  button("7"),
                  button("+"),
                ],
              ),
              Row(
                children: <Widget>[
                  button("6"),
                  button("5"),
                  button("4"),
                  button("-"),
                ],
              ), Row(
                children: <Widget>[
                  button("3"),
                  button("2"),
                  button("1"),
                  button("x"),
                ],
              ), Row(
                children: <Widget>[
                  button("c"),
                  button("0"),
                  button("="),
                  button("/"),
                ],
              ),
            ],
          )
      );
  }
}


