import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({Key?key, this.title, this.iconData, this.iconColor, this.time, this.check,this.iconBgColor, this.onChange,this.index}) : super(key: key);
  final String? title;
  final IconData? iconData;
  final Color? iconColor;
  final String? time;
  final bool? check;
  final Color? iconBgColor;
  final Function? onChange;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: Colors.blue,
                checkColor: Colors.black,
                value: check,
                onChanged: (bool? change) {
                  onChange!(index);
                },
              ),
            ),
            data: ThemeData(
              primarySwatch: Colors.blue,
              unselectedWidgetColor: Color(0xff5e616a),
            ),
          ),
          Expanded(child: Container(
            height: 75,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Color(0xff2a2e3d),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Container(
                    height: 33,
                    width: 36,
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(iconData,color: iconColor,),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(title!,
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                  ),
                  Text(time!,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
