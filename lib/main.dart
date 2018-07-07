import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Mood Tracker',
      theme: new ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Mood Tracker'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _moodIndex = 0.0;
  final _submitted = List<Map>();

  void _submitMoodIndex() {
    // click submit button
    setState(() {
      var now = new DateTime.now();
      var formatter = new DateFormat('MM月dd日 HH:mm');
      var moodInfo = {
        '_moodIndex': _moodIndex,
        'timestamp': now,
        'timestamp_parsed': formatter.format(now).toString()
      };
      _submitted.insert(0, moodInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildSliderDiscrete(),
            new Text(
              '拖动滑条选择当前的心情指数（-5到5），并点击右下角按钮提交~',
            ),
            new Text(
              '${_moodIndex.toInt()}',
              style: Theme.of(context).textTheme.display1,
            ),
            // TODO: implement mood tracked list
            new Expanded(child: _buildMoodTrackedList()) ,
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _submitMoodIndex,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget _buildSliderDiscrete() {
    return Slider(
      value: _moodIndex,
      min: -5.0,
      max: 5.0,
      divisions: 10,
      onChanged: (double value) {
        setState(() {
          _moodIndex = value;
        });
      },
    );
  }

  Widget _buildMoodTrackedList() {
      return ListView.builder(
        itemCount: _submitted.length,
        itemBuilder: (context, i) {
          return _buildRow(_submitted[i]);
        }
      );

  }

  Widget _buildRow(Map moodInfo) {
    return ListTile(
      title: Text('${moodInfo['timestamp_parsed']}'),
      trailing:  Text('${moodInfo['_moodIndex'].toInt()}'),
    );
  }
}
