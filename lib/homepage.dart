import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitledsqflite/add_contact.dart';
import 'package:untitledsqflite/edit_student.dart';
import 'package:untitledsqflite/main.dart';
import 'package:untitledsqflite/service/db.dart';


class ListContacts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ListContacts();
  }

}

class _ListContacts extends State<ListContacts>{

  List<Map> slist = [];


  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata(){
    Future.delayed(Duration(milliseconds: 500),() async {
      //use delay min 500 ms, because database takes time to initilize.
      slist = await db.db.rawQuery('SELECT * FROM contacts');

      setState(() { }); //refresh UI after getting data from table.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          ///ADD CONTACTS
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
                return AddContact();
              })).then((value) => getdata());
        },
        child: Icon(Icons.add),
      ),
        appBar: AppBar(backgroundColor: Colors.purple.shade200,elevation: 0,
      title: Text("Contacts"),
      actions: []),
      body: SingleChildScrollView(
        child: Container(
          child: slist.length == 0?Text("No any Contacts to show."): //show message if there is no any student
          Column(  //or populate list to Column children if there is student data.
            children: slist.map((stuone){
              return ListTile(
                leading: const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.green,
                //  child: ,
                ),
                title: Text(stuone["name"]),
                subtitle: Text("Number:" + stuone["number"].toString() + ", Add: " + stuone["number"]),
                trailing:



                Wrap(children: [

                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                      return Edit(rollno: stuone["number"]);
                    })).then((value) => getdata()); //navigate to edit page, pass student roll no to edit
                  }, icon: Icon(Icons.edit)),


                  IconButton(onPressed: () async {
                    await db.db.rawDelete("DELETE FROM contacts WHERE number = ?", [stuone["number"]]);
                    //delete student data with roll no.
                    print("Data Deleted");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Data Deleted")));
                    getdata();
                  }, icon: Icon(Icons.delete, color:Colors.red))


                ],),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}