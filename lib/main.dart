import 'package:chat_record/chat_bubble.dart';
import 'package:flutter/material.dart';

///聊天记录
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '聊天记录',
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data = ['歪比歪比', '歪比巴卜'];
  TextEditingController textC = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Center(child: new Text('聊天')),
      ),
      body: KeyboardRetraction(
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new ListView.builder(
                itemBuilder: (context, index) {
                  return new MsgView(
                    isMyself: index.isEven,
                    content: data[index],
                  );
                },
                itemCount: data.length,
              ),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new TextField(
                    controller: textC,
                    onSubmitted: (String str) {
                      textC.clear();
                      setState(() => data.insert(data.length, str));
                    },
                  )),
                  new Icon(Icons.insert_emoticon, size: 30),
                  new SizedBox(width: 5),
                  new Icon(Icons.add, size: 30),
                  new SizedBox(width: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MsgView extends StatelessWidget {
  final bool isMyself;
  final String content;
  MsgView({this.isMyself, this.content});
  @override
  Widget build(BuildContext context) {
    List<Widget> body = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: new CircleAvatar(radius: 25),
      ),
      new ClipPath(
        clipper: TextPath(isMyself ? 'right' : 'left'),
        child: new Container(
          padding: isMyself
              ? EdgeInsets.only(right: 7.0)
                  .add(EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 5.0))
              : EdgeInsets.only(left: 7.0)
                  .add(EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 5.0)),
          color: Colors.green,
          child: new Text(content, style: TextStyle(color: Colors.white)),
        ),
      ),
      new Spacer(),
    ];
    if (isMyself) body = body.reversed.toList();

    return new Container(
      width: MediaQuery.of(context).size.width,
      child: new Row(children: body),
    );
  }
}

///键盘收回
class KeyboardRetraction extends StatelessWidget {
  final Widget child;

  KeyboardRetraction({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
      child: child,
    );
  }
}
