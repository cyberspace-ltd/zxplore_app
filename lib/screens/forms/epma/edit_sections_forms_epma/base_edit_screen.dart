import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';

// Base Edit screen template
class BaseEditForm extends ConsumerWidget {
  final String title;
  final Widget? child;
  final Widget? addMore;
  final Widget? button;
  final Widget widgetToGoOnCancel;
  final Function()? onCancel;
  final dynamic data;
  final bool showAddMore;

  const BaseEditForm(
      {Key? key,
      this.addMore,
      this.button,
      this.showAddMore=true,
      required this.title,
      required this.widgetToGoOnCancel,
      required this.data,
      this.onCancel,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: button,
      appBar: AppBar(
        leading: IconButton(
            onPressed: onCancel ??
                () {
                  widgetToGoOnCancel!=null?
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => widgetToGoOnCancel),
                  ):Navigator.pop(context);

                },
            icon: Icon(
              Icons.close,
              color: ZxplorePrimaryColor,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
            width: MediaQuery.of(context).size.width*0.60,
            child: Text(title,overflow: TextOverflow.ellipsis,)),this.showAddMore? (this.addMore ?? SizedBox.shrink()):SizedBox.shrink()],
        ),
      ),
      body: child,
    );
  }
}

// Base Edit screen template
class BaseAddForm extends ConsumerWidget {
  final String title;
  final Widget? child;
  final Widget widgetToGoOnSave;
  final Function()? onCancel;
  final dynamic data;

  const BaseAddForm(
      {Key? key,
      required this.title,
      required this.widgetToGoOnSave,
      required this.data,
      this.onCancel,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: onCancel ??
                () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => widgetToGoOnSave),
                  );
                },
            icon: Icon(
              Icons.close,
              color: ZxplorePrimaryColor,
            )),
        title: Text(title),
      ),
      body: child,
    );
  }
}
