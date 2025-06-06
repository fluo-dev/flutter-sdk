import 'package:flutter/material.dart';

import 'fluo_localizations.dart';

class FluoLocalizedModels {
  static String error(BuildContext context, String messageId) {
    final fluoLocalizations = FluoLocalizations.of(context)!;
    switch (messageId) {
      case 'unauthorized':
        return fluoLocalizations.errorUnauthorized;
      case 'parameter_missing':
        return fluoLocalizations.errorParameterMissing;
      case 'parameter_invalid':
        return fluoLocalizations.errorParameterInvalid;
      case 'not_found':
        return fluoLocalizations.errorNotFound;
      case 'internal':
        return fluoLocalizations.errorInternal;
      case 'session_revoked':
        return fluoLocalizations.errorSessionRevoked;
      case 'code_expired':
        return fluoLocalizations.errorCodeExpired;
      case 'code_invalid':
        return fluoLocalizations.errorCodeInvalid;
    }
    return fluoLocalizations.errorUnknown;
  }
}
