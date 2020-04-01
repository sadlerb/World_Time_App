import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Map data  = {};   


class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data :ModalRoute.of(context).settings.arguments ;

    String  bgImage = data['isDayTime'] ? 'day.png': 'night.png';
    Color bgColor = data['isDayTime'] ? Colors.blue: Colors.indigo[700];
    String flag = data['flag'];

    return Scaffold(
      backgroundColor: bgColor ,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )
        ),
              child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 60.0, 0, 0),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('assets/$flag'),
                  radius: 45.0,
                ),
                FlatButton.icon(
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState((){
                    data = {
                      'time' : result['time'],
                      'location': result['location'],
                      'isDayTime': result['isDayTime'],
                      'flag': result['flag'],
                    };
                  });
                },
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.grey,
                  ), 
                label: Text(
                  'Edit Location',
                  style: TextStyle(
                    color: Colors.grey[300]
                  ),
                )
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(data['location'], 
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: Colors.white
                    )
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white
                  ),
                )
              ],
              )
          ),
        ),
      ),
    );
  }
}