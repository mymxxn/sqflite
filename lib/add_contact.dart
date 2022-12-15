import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitledsqflite/main.dart';
import 'package:untitledsqflite/service/db.dart';

class AddContact extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddContact();
  }
}

class _AddContact extends State<AddContact>{

  TextEditingController name = TextEditingController();
  TextEditingController group = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();

  //test editing controllers for form

   //mydb new object from db.dart

  @override
  void initState() {
    db.open(); //initilization database
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.purple.shade200,elevation: 0,
          title: Text("Add Contact"),leading:IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.close,color: Colors.white,)),
          actions: [TextButton(onPressed: (){

            db.db.rawInsert("INSERT INTO contacts (name, groupa, number, email) VALUES (?, ?, ?, ?);",
                [name.text, group.text, number.text,email.text]); //add student from form to database

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Contact Added")));
            //show snackbar message after adding student

            name.text = "";
            group.text = "";
            number.text = "";
            email.text = "";
            //clear form to empty after adding data

          }, child: Text("Save",style: TextStyle(color: Colors.white),))],
        ),
        body:Container(
          padding: EdgeInsets.all(30),
          child: Column(children: [
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
              children: [Icon(Icons.cases_rounded,color: Colors.purple.shade200,),
                Expanded(
                  child: TextField(
                    controller: group,
                    decoration: InputDecoration(
                      labelText: "group",
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [Icon(Icons.call,color: Colors.purple.shade200,),
                Expanded(
                  child: TextField(
                    controller: number,
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
                    controller: email,
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