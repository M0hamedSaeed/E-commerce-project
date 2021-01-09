import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Container(
          color: Colors.amber,
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              AddingBotton1(),
              AddingBotton2(),
            ],
          ),
        ),
      ),
    );
  }
}

class AddingBotton1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 270),
      width: 150.0,
      height: 50.0,
      child: RaisedButton(
        child: Text("Add Restaurant"),
        elevation: 7.0,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ThirdScreen()));
        },
      ),
    );
  }
}

class AddingBotton2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 200.0,
      height: 50.0,
      child: RaisedButton(
        child: Text("Show Your Restaurant"),
        elevation: 7.0,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SecondScreen()));
        },
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Restaurants')),
      body: Center(
        child: Container(
          color: Colors.amber,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String name, des;
  int numOftables;
  String dropval;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Restaurants')),
      body: Container(
        color: Colors.amber,
        child: Form(
          key: _globalKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              Container(
                color: Colors.white,
                child: TextFormField(
                  onSaved: (txt) {
                    name = txt;
                  },
                  validator: newMethod,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 20),
                    hintText: "Enter Name",
                    hintStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 20),
                child: TextFormField(
                  onSaved: (txt) {
                    des = txt;
                  },
                  validator: (val) {
                    if (val == "" || val == null) return "Missing Field";
                  },
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(fontSize: 20),
                    hintText: "Enter Description",
                    hintStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 20),
                child: TextFormField(
                  onSaved: (txt) {
                    numOftables = int.parse(txt);
                  },
                  validator: (val) {
                    if (val == "" || val == null) return "Missing Field";
                  },
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(fontSize: 20),
                    hintText: "Enter Description",
                    hintStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              DropdownButton(
                iconSize: 40.0,
                isDense: true, style: TextStyle(),

                isExpanded: true,
                value: dropval,
                icon: Icon(Icons.keyboard_arrow_down),
                iconEnabledColor: Colors.black,
                hint: Text("Select Food category..."),
                //disabledHint: Text("Enter Major.."),
                onChanged: (val) {
                  setState(() {
                    dropval = val;
                  });
                },
                items: <String>[
                  "Select Food category...",
                  "Italian",
                  "Egyption",
                  "Indian"
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if (_globalKey.currentState.validate()) {
                    _globalKey.currentState.save();
                    FirebaseFirestore firestore = FirebaseFirestore.instance;

                    try {
                      firestore.collection("Restaurants").add({
                        "name": name,
                        "description": des,
                        "numOfTables": numOftables,
                        "category": dropval
                      }).then((j) {
                        Navigator.pop(context);
                        Toast.show("Added Successfully !!!!!!!!!!!!", context,
                            duration: 5, gravity: Toast.BOTTOM);
                      });
                    } catch (e) {
                      Toast.show("Failed  !!!!!!!!!!!!", context,
                          duration: 5, gravity: Toast.BOTTOM);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String newMethod(val) {
    if (val == "" || val == null) return "Missing Field";
  }
}
