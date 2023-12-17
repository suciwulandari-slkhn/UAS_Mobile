import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uas/widget/big_text.dart';
import 'package:uas/widget/dimensions.dart';
import 'package:uas/widget/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: text,
            size: Dimensions.font26,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Wrap(
                children: List.generate(
                    5,
                    (index) => Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        )),
              ),
              SizedBox(
                width: 5,
              ),
              SmallText(text: "5.0"),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          BigText(
            text: "Keterangan",
            size: Dimensions.font20,
          ),
        ],
      ),
    );
  }
}
