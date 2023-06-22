

import 'package:fluent_ui/fluent_ui.dart';

class NoData extends StatelessWidget {
  final String data;
  const NoData({super.key, this.data = "No data" ,});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(FluentIcons.blocked, size: 62,),
        Text(data),
      ],
    );
  }
}
