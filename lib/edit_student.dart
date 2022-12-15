import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitledsqflite/main.dart';
import 'package:untitledsqflite/service/db.dart';


class Edit extends StatefulWidget{

  String rollno;
  Edit({required this.rollno}); //constructor for class

  @override
  State<StatefulWidget> createState() {
    return _Edit();
  }
}

class _Edit extends State<Edit>{

  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController address = TextEditingController();



  @override
  void initState() {
    db.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await db.getStudent(widget.rollno); //widget.rollno is passed paramater to this class
      if(data != null){
        name.text = data["name"];
        rollno.text = data["number"].toString();
        address.text = data["email"];
        setState(() {});
      }else{
        print("No any data" + widget.rollno.toString());
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit"),actions: [TextButton(onPressed: (){
          db.db.rawInsert("UPDATE contacts SET name = ?, number = ?, address = ? WHERE number = ?",
              [name.text, rollno.text, address.text, widget.rollno]);
          //update table with roll no.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Data Updated")));

        }, child: Text("Update Student Data"))],
        ),
        body:Container(
          padding: EdgeInsets.all(30),
          child:  Column(children: [
            Row(
              children: [Icon(Icons.person,color: Colors.purple.shade200,),
                Expanded(
                  child: TextField(
controller: name,
                    decoration: InputDecoration(
                      labelText: "Name",
                    ),
                  ),
                ),
              ],
            ),



            Row(
              children: [Icon(Icons.call,color: Colors.purple.shade200,),
                Expanded(
                  child: TextField(
controller: rollno,
                    decoration: InputDecoration(
                      labelText: "number",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [Icon(Icons.email,color: Colors.purple.shade200,)
                ,                Expanded(
                  child: TextField(
controller: address,
                    decoration: InputDecoration(
                      labelText: "email",
                    ),
                  ),
                ),
              ],
            ),


          ],),


        )
    );
  }

}