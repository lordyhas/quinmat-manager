import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

//todo: propose it to fluent_ui

class RadioGroup<T> extends StatelessWidget {
  /// Creates a group Fluent UI  radio button.
  ///
  /// The radio button itself does not maintain any state. Instead, when the
  /// radio button is selected, the widget calls the [onChanged] callback. Most
  /// widgets that use a radio button will listen for the [onChanged] callback
  /// and rebuild the radio button with a new [groupValue] to update the visual
  /// appearance of the radio button.
  ///
  /// The following arguments are required:
  ///
  /// * [value] and [groupValue] together determine whether the radio button is
  ///   selected.
  /// * [onChanged] is called when the user selects this radio button.

  const RadioGroup({
    Key? key,
    this.radios = const [],
    required this.groupValue,
    required this.onChanged,
    this.direction = Axis.vertical,
    this.style,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.disabled = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = 0.0,
  }) : super(key: key);


  /// The currently selected value for a group of radio buttons.
  ///
  /// This radio button is considered selected if its [value] matches the
  /// [groupValue].
  final T groupValue;

  /// The direction to use as the main axis.
  ///
  /// The [direction] is required. The default value is [Axis.vertical].
  ///
  /// [RadioGroup] will be a [Row] (if it's horizontal) or
  /// [Column] (if it's vertical)
  final Axis direction;

  /// list of [RadioItem]
  final List<RadioItem<T>> radios;

  /// Called when the value of one of the radio items in the [RadioGroup]
  /// should change.
  ///
  /// The radio item passes the new value to the callback but does
  /// not actually change state until the parent widget rebuilds the
  /// radio group with the new value.
  ///
  /// The provided callback will not be invoked if this radio item is already
  /// selected.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  /// ```dart
  /// RadioGroup<SingingCharacter>(
  ///   direction: Axis.horizontal,
  ///   spacing: 8.0,
  ///   groupValue: _character,
  ///   onChanged: (SingingCharacter? newValue) {
  ///     setState(() {
  ///       _character = newValue;
  ///     });
  ///   },
  ///   radios : [
  ///     RadioItem(
  ///       value: SingingCharacter.lafayette,
  ///       label : Text("Lafayette"),
  ///     ),
  ///     RadioItem(
  ///       value: SingingCharacter.unknown,
  ///       label : Text("Unknown"),
  ///     ),
  ///   ]
  /// )
  /// ```
  final ValueChanged<T> onChanged;

  /// The style of the radio buttonbutton.
  ///
  /// If non-null, this is merged with the closest [RadioButtonTheme].
  /// If null, the closest [RadioButtonTheme] is used.
  final RadioButtonThemeData? style;

  /// {@macro fluent_ui.controls.inputs.HoverButton.semanticLabel}
  final String? semanticLabel;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// If this [disabled] is true, the radio button will be displayed as
  /// disabled and will not respond to input gestures.
  final bool disabled;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;


  /// How much space to place between children in the main axis.
  ///
  /// For example, if [spacing] is 10.0, the children will be spaced at least
  /// 10.0 logical pixels apart in the main axis.
  ///
  /// Defaults to 0.0.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children:  radios.map((item) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: direction == Axis.horizontal ? spacing/2 : 0.0,
          vertical: direction == Axis.vertical ? spacing/2 : 0.0,
        ),
        child: RadioButton(
          checked: item.value == groupValue,
          onChanged: disabled ? null : (value){
            if(value && item.value != groupValue) {
              onChanged(item.value);
            }
          },
          content: item.label,
          style: style,
          focusNode: focusNode,
          semanticLabel: semanticLabel,
          autofocus: autofocus,
        ),
      )).toList(),
    );

  }
}

class RadioItem<T> with Diagnosticable {
  /// The radio item of the [RadioGroup] widget as his children.
  const RadioItem({
    Key? key,
    required this.value,
    this.label,
  });

  /// The value represented by this radio button.
  final T value;

  /// The label of the radio button.
  ///
  /// This, if non-null, is displayed at the right of the radio button,
  /// and is affected by user touch.
  ///
  /// Usually a [Text] or [Icon] widget
  final Widget? label;


}

