import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoode/pages/AddTodoPage.dart';
import 'package:todoode/pages/SignUpPage.dart';
import 'package:todoode/pages/TodoCard.dart';
import 'package:todoode/pages/View_data.dart';
import 'package:todoode/service/Auth_Service.dart';
import 'package:todoode/service/Auth_Service.dart';
import 'package:todoode/pages/View_data.dart';
 class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection("Todo").snapshots();
  List<Select>selected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.black,
        title: Text("Today's Schedule",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("images/Rits2.jpg"),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Text("What all you are supposed to do today :)",
              style: TextStyle(
                fontSize:16,
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(35),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: InkWell(
              onLongPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SignUpPage();
                }));
              },
              child: Icon(
                  Icons.home,
                size: 32,
                color: Colors.white,
              ),
            ),
            label: " ",
          ),
          BottomNavigationBarItem(icon: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>AddTodoPage()));
            },
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xfffd746c),
                    Color(0xffff9068),
                    Color(0xfffd746c)
                  ]
                )
              ),
              child: Icon(Icons.add,
              size: 32,
              ),
            ),
          ),
            label: " ",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 32,
              color: Colors.white,
            ),
            label: " ",
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
        return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context,index){
              IconData? iconData;
              Color? iconColor;
              Map<String, dynamic> document =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;
              switch(document["category"]){
                case "Work":
                  iconData = Icons.run_circle_outlined;
                  iconColor = Colors.red;
                  break;
                case "Workout":
                  iconData = Icons.alarm;
                  iconColor = Colors.teal;
                  break;
                case "Food":
                  iconData = Icons.local_grocery_store;
                  iconColor = Colors.blue;
                  break;
                case "Academics":
                  iconData = Icons.school;
                  iconColor = Colors.black;
                  break;
                case "Self Development":
                  iconData = Icons.self_improvement;
                  iconColor = Colors.deepOrangeAccent;
                  break;
                default:
                  iconData: Icons.pattern_outlined;
                  iconColor: Colors.red;
              }
              selected.add(Select(
                id: snapshot.data?.docs[index].id, checkValue: false));
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>ViewData(
                document: document,
                id: snapshot.data?.docs[index].id,
              ),
              ),
              );
            },
            child: TodoCard(
              title: document["tittle"] == null?"Hey there":  document["tittle"],
              check: selected[index].checkValue,
              iconBgColor: Colors.white,
              iconColor: iconColor,
              iconData: iconData,
              time: " ",
              index: index,
              onChange: onChange,
            ),
          );
        });
    }
    )
    );
  }
  void onChange(int index){
    setState(() {
      selected[index].checkValue = selected[index].checkValue;
    });
  }
}
class Select{
  String ?id;
  bool? checkValue = false;
  Select({this.id, this.checkValue});
}
