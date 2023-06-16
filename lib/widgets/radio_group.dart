import 'package:fluent_ui/fluent_ui.dart';
//todo: create a radio button group
class RadioGroup<T> extends StatefulWidget {
  final Axis direction;
  final List<RadioItem<T>> children;
  const RadioGroup({
    Key? key,
    this.direction = Axis.vertical,
    this.children = const <RadioItem<T>>[],
  }) : super(key: key);

  @override
  State<RadioGroup> createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  @override
  Widget build(BuildContext context) {
    switch (widget.direction) {
      case Axis.horizontal:
        return Row();
      case Axis.vertical:
        return Column();
    }
  }
}

class RadioItem<T> extends StatelessWidget {
  final T value;
  final void Function(bool)? onChanged;
  const RadioItem({Key? key, required this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioButton(checked: true, onChanged: onChanged);
  }
}

