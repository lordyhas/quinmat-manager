
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
class StarRating extends StatelessWidget {
  final int starCount;
  final bool allowHalfRating;
  final double rating;
  final double size;
  final Color? color;
  final Color? borderColor;

  const StarRating({
      Key? key,
      required this.starCount,
      this.allowHalfRating = true,
      this.rating = 0,
      this.size = 15,
      this.color,
      this.borderColor
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:List<Icon>.generate(starCount, (index) {
        double value = rating - index.toDouble();
        //print('StarRating(index => $index : $value) ####');
        if(value > 1) {
          return Icon(CupertinoIcons.star_fill, color: color ?? Colors.yellow, size: size,);
        } else if(value > 0 && value < 1){
          return Icon(CupertinoIcons.star_lefthalf_fill, color: color, size: size,);
        } else {
          return Icon(CupertinoIcons.star, color: color, size: size,);
        }
      }) ,
    );
  }
}
