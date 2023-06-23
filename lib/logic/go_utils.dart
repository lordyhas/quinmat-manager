
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class Go {
  static void to(
    BuildContext context, {
    required String routeName,
    //@Deprecated("not use no more") Widget? page,
    String? path,
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    dynamic args,
  }) {
    return GoRouter.of(context).goNamed(routeName,
        pathParameters: params, queryParameters: queryParams, extra: args);
  }

  static _GoNavigator params(
    BuildContext context, {
    required String routeName,
    String? path,
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    dynamic args,
  }) =>
      _GoNavigator(
        context: context,
        routeName: routeName,
        path: path,
        queryParams: queryParams,
        args: args,
      );

  static GoRouter of(BuildContext context) => GoRouter.of(context);
}

@protected
class _GoNavigator {
  final BuildContext context;
  final String routeName;
  final String? path;
  final Map<String, dynamic> queryParams;
  final dynamic args;

  _GoNavigator({
    required this.context,
    required this.routeName,
    this.path,
    this.queryParams = const <String, dynamic>{},
    this.args,
  });

  void show() {
    GoRouter.of(context)
        .goNamed(routeName, queryParameters: queryParams, extra: args);
  }

  void push() {
    GoRouter.of(context)
        .goNamed(routeName, queryParameters: queryParams, extra: args);
  }
}