import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController _tittleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String type = "";
  String category = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff1d1e26),
            Color(0xff252041),
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(CupertinoIcons.arrow_left,color: Colors.white,size: 28,
              ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create",
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("New Todo",
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label("Task Tittle"),
                    SizedBox(height: 12),
                    tittle(),
                    SizedBox(height: 30),
                    label("Task Type"),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        taskSelect("Important",0xffff6d6e),
                        SizedBox(width: 30),
                        taskSelect("Planned", 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(height: 25),
                    label("Description"),
                    SizedBox(height: 12),
                    descreption(),
                    SizedBox(height: 30),
                    label("Category"),
                    SizedBox(height: 12),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        categorySelect("Workout",0xffff6d6e),
                        SizedBox(width: 20),
                        categorySelect("Food", 0xff2bc8d9),
                        SizedBox(width: 20),
                        categorySelect("Work",0xffff6d6e),
                        SizedBox(width: 20),
                        categorySelect("Academics", 0xff2bc8d9),
                        SizedBox(width: 20),
                        categorySelect("Self Development", 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(height: 50),
                    button(),
                    SizedBox(height: 30),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget button(){
    return InkWell(
      onTap: (){
        FirebaseFirestore.instance.collection("Todo").add(
            {"tittle": _tittleController.text, "task": type, "category" :category,"description": _descriptionController.text});
        Navigator.pop(context);
      },
        child: Container(
          height: 56,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  colors: [
                    Color(0xfffd746c),
                    Color(0xffff9068),
                    Color(0xfffd746c)
                  ]
              )
          ),
          child: Center(
            child: Text("Add Todo",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
    );

  }
  Widget descreption(){
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xff2a2e3d),
      ),
      child: TextField(
        controller: _descriptionController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          errorMaxLines: null,
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(left: 20,right: 20),
        ),
      ),
    );
  }
  Widget taskSelect(String label, int color){
    return InkWell(
      onTap: (){
        setState(() {
          type = label;
        });

      },
      child: Chip(
        backgroundColor: type==label?Colors.black:Color(color),
        label: Text(label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 3.8),

      ),
    );
  }
  Widget categorySelect(String label, int color){
    return InkWell(
      onTap: (){
        setState(() {
          category = label;
        });

      },
      child: Chip(
        backgroundColor: category == label? Colors.black:Color(color),
        label: Text(label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 3.8),

      ),
    );
  }
  Widget tittle(){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xff2a2e3d),
      ),
      child: TextField(
        controller: _tittleController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(left: 20,right: 20),
        ),
      ),
    );
  }
  Widget label(String label){
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: 16.5,
        letterSpacing: 0.2,
      ),
    );
  }
}
