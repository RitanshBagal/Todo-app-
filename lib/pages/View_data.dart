import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ViewData extends StatefulWidget {
  const ViewData({Key? key, required this.document, this.id}) : super(key: key);
  final Map<String, dynamic>document;
  final String? id;
  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  TextEditingController ?_tittleController;
  TextEditingController ?_descriptionController ;
  String? type;
  String? category;
  bool edit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String tittle = widget.document["tittle"] == null
        ? "heyy"
        :widget.document["tittle"];
    _tittleController = TextEditingController(text: tittle);
    _descriptionController = TextEditingController(text: widget.document["description"]);
    type = widget.document["task"];
    category = widget.document["category"];
  }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(CupertinoIcons.arrow_left,color: Colors.white,size: 28,
                  ),
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                       setState(() {
                         FirebaseFirestore.instance.collection("Todo").doc(widget.id).delete().then((value){
                           Navigator.pop(context);
                         });
                       });
                      }, icon: Icon(Icons.delete,
                        color: Colors.red,
                        size: 28,
                      ),
                      ),
                      IconButton(onPressed: (){
                        setState(() {
                          edit= !edit;
                        });
                      }, icon: Icon(CupertinoIcons.pen,
                        color:edit?Colors.red:Colors.white,
                        size: 28,
                      ),
                      ),
                    ],
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(edit?"Edit":"View",
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
                    Text("Your Todo",
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
                    edit?button():Container(),
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
      onTap:(){
        FirebaseFirestore.instance.collection("Todo").doc(widget.id).update(
            {"tittle": _tittleController!.text, "task": type, "category" :category,"description": _descriptionController!.text});
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
          child: Text("Update Todo",
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
        enabled: edit,
        controller: _descriptionController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          enabled: edit,
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
      onTap: edit?(){
        setState(() {
          type = label;
        });

      }:null,
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
      onTap: edit?(){
        setState(() {
          category = label;
        });

      }:null,
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
        enabled: edit,
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
