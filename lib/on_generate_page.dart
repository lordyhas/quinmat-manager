



import 'package:fluent_ui/fluent_ui.dart';

class OnGeneratePage extends StatelessWidget {
  const OnGeneratePage({Key? key}) : super(key: key);

  static Route route() {
    return FluentPageRoute<void>(builder: (_) => const OnGeneratePage());
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      //backgroundColor: Colors.grey.shade900,
      content:  Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 72),
            child: SizedBox(
              height: 200,
              child:Image.asset("assets/icon_app.png"),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Spacer(),
                Center(
                    child: ProgressRing(
                      activeColor: FluentTheme.of(context).activeColor,
                    )
                ),
                const Spacer(),
                const SizedBox(height: 2.0,),
                const Spacer(),
                const SizedBox(height: 2.0,),
                const Spacer(),
              ],
            ),
          ),
        ],
      )
    );
  }
}

/* Image.asset(
            'assets/img/exploress_icon.png',
            key: const Key('splash_icon_image'),
            width: 150,
        ),
      ) */
