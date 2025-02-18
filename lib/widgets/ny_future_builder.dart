import 'package:flutter/material.dart';
import 'package:ttld/helppers/loading_styles.dart';

class NyFutureBuilder<T> extends StatelessWidget {
  const NyFutureBuilder(
      {super.key,
      required this.future,
      required this.child,
      this.loadingStyle,
      this.onError});

  final Future<T>? future;
  final Widget Function(BuildContext context, T? data) child;
  final Widget Function(AsyncSnapshot snapshot)? onError;
  final LoadingStyle? loadingStyle;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (
        BuildContext context,
        AsyncSnapshot<T> snapshot,
      ) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            {
              if (loadingStyle == null) {
                return CircularProgressIndicator();
              }
              return loadingStyle!.render();
            }
          case ConnectionState.active:
            {
              return const SizedBox.shrink();
            }
          case ConnectionState.done:
            {
              if (snapshot.hasError) {
                if (onError != null) {
                  return onError!(snapshot);
                }
                return const SizedBox.shrink();
              }

              return child(context, snapshot.data);
            }
          case ConnectionState.none:
            {
              return const SizedBox.shrink();
            }
        }
      },
    );
  }
}
