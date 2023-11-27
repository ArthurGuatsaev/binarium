import 'package:binarium/posts/model/note_model.dart';
import 'package:binarium/posts/view/bloc/post_bloc.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/trade/domain/bloc/trade_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';

Future<void> showMyIosResetDataPop(BuildContext context) {
  return showCupertinoDialog(
    context: context,
    useRootNavigator: false,
    builder: (context) {
      return Theme(
        // Wrap the Cupertino dialog with a Material theme
        data: Theme.of(context).copyWith(
          platform: TargetPlatform.iOS,
        ),
        child: CupertinoAlertDialog(
          content: const Column(children: [
            Text(
              'Delete note?',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5),
            Text(
              'You will not be able to restore it',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ]),
          actions: [
            CupertinoDialogAction(
                onPressed: () => MyNavigatorManager.instance.simulatorPop(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                )),
            CupertinoDialogAction(
                onPressed: () {
                  context.read<TradeBloc>().add(ResetAllEvent());
                  MyNavigatorManager.instance.simulatorPop();
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                )),
          ],
        ),
      );
    },
  );
}

Future<void> showMyIosPop(BuildContext context, VNotesIssar note) {
  return showCupertinoDialog(
    context: context,
    useRootNavigator: false,
    builder: (context) {
      return Theme(
        // Wrap the Cupertino dialog with a Material theme
        data: Theme.of(context).copyWith(
          platform: TargetPlatform.iOS,
        ),
        child: CupertinoAlertDialog(
          content: const Column(children: [
            Text(
              'Reset all data?',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5),
            Text(
              'You will not be able to restore it',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ]),
          actions: [
            CupertinoDialogAction(
                onPressed: () => MyNavigatorManager.instance.postPop(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                )),
            CupertinoDialogAction(
                onPressed: () {
                  context.read<PostBloc>().add(DelNoteEvent(note: note));
                  MyNavigatorManager.instance.postPop();
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                )),
          ],
        ),
      );
    },
  );
}

Future<void> showErrorPop(BuildContext context, String message) {
  return showCupertinoDialog(
    context: context,
    useRootNavigator: false,
    builder: (context) {
      return Theme(
        // Wrap the Cupertino dialog with a Material theme
        data: Theme.of(context).copyWith(
          platform: TargetPlatform.iOS,
        ),
        child: CupertinoAlertDialog(
          content: Column(children: [
            const Text(
              "Couldn't get in",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(
              message,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ]),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => MyNavigatorManager.instance.simulatorPop(),
            )
          ],
        ),
      );
    },
  );
}
