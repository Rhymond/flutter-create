import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'dart:async';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Typer',
      theme: ThemeData(fontFamily: 'Ubuntu'),
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  Page({Key key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  int s = 0;
  int h = 0;
  int l = 300;
  List wl = [];
  final ct = TextEditingController();
  Stopwatch st = new Stopwatch();
  List lwl = [];
  int c = 0;
  final w = Colors.white;

  lw() async {
    return await rootBundle.loadString('list.txt');
  }

  gw() {
    return lwl[new Random().nextInt(lwl.length)];
  }

  sy(double h, double v) {
    return EdgeInsets.symmetric(horizontal: h, vertical: v);
  }

  ch(value) {
    int le = ct.text.length;
    if (s != 0 && l == 0) return;

    if (s == 0 && le > 0) {
      setState(() {
        s = 1;
      });
      new Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
        setState(() {
          if (l == 0) {
            t.cancel();
            ct.clear();
            h = s > h ? s : h;
          }
          l--;
          c--;
        });
      });
    }

    if (le > 0 && ct.text[le - 1] == ' ') {
      setState(() {
        ct.text == wl[0] + ' ' ? s += le : c = 10;
        wl.removeAt(0);
        wl.add(gw());
      });
      ct.clear();
    }
  }

  gwl() {
    List<Widget> l = [];
    for (var w in wl) l.add(wc(w));
    return l;
  }

  wc(String t) {
    return Container(
      padding: sy(24, 8),
      margin: sy(8, 16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        t,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  void initState() {
    lw().then((v) {
      setState(() {
        lwl = v.split("\n");
        for (var i = 0; i < 4; i++) wl.add(gw());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Expanded(
          child: Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: SafeArea(
                  child: Column(
                children: <Widget>[
                  Expanded(
                      child: Center(
                          child: l < 0
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      l = 300;
                                      s = 0;
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.replay, color: w, size: 100),
                                      Container(
                                          padding: sy(0, 24),
                                          child: Text("Score: $s",
                                              style: TextStyle(
                                                  color: w, fontSize: 30))),
                                    ],
                                  ),
                                )
                              : Text(
                                  '${l < 0 ? s - 1 : (l / 10).toStringAsFixed(1)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 100,
                                    color: w,
                                  )))),
                  Padding(
                      padding: sy(24, 16),
                      child: Text('High Score: $h',
                          style: TextStyle(
                            fontSize: 16,
                            color: w,
                          ))),
                ],
              )))),
      Container(
          margin: sy(24, 16),
          child: Row(
            children: gwl(),
          )),
      Container(
        margin: sy(24, 0),
        child: TextField(
          autocorrect: false,
          controller: ct,
          onChanged: ch,
          enabled: l > 0,
          decoration: InputDecoration(
              filled: c > 0,
              fillColor: Colors.red[100],
              hintText: 'Start game by entering word',
              contentPadding: sy(24, 16),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24))),
        ),
      ),
      SizedBox(height: 40),
    ]));
  }
}
