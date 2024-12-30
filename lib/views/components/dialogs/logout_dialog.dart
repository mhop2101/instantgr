import 'package:flutter/foundation.dart';
import 'package:instantgramclonexyz/views/components/dialogs/alert_dialog_model.dart';

import '../constants/strings.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
          buttons: const {
            'Yes': true,
            'No': false,
          },
        );
}
