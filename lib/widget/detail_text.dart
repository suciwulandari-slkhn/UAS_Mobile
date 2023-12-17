import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailText extends StatefulWidget {
  final String text;
  const DetailText({Key? key, required this.text}) : super(key: key);

  @override
  State<DetailText> createState() => _DetailTextState();
}

class _DetailTextState extends State<DetailText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = 100;

  @override
  void inistate() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: [
                Text(hiddenText
                    ? (firstHalf + ".......")
                    : (firstHalf + secondHalf)),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text("Show More"),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.red,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
