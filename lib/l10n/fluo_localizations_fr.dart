// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class FluoLocalizationsFr extends FluoLocalizations {
  FluoLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get acceptTerms =>
      'En continuant, vous acceptez nos <terms>conditions générales</terms> et notre <privacy>politique de confidentialité</privacy>.';

  @override
  String get enterCode => 'Entrez le code de vérification';

  @override
  String enterCodeHelper(String email) {
    return 'Le code a été envoyé à <email>$email</email>. Si vous n\'avez pas reçu d\'e-mail, vous pouvez vérifier votre dossier de spam.';
  }

  @override
  String get enterEmail => 'Entrez votre adresse e-mail';

  @override
  String get enterEmailPlaceholder => 'exemple@domaine.fr';

  @override
  String get enterFirstName => 'Entrez votre prénom';

  @override
  String get enterFirstNamePlaceholder => 'Prénom';

  @override
  String get enterLastName => 'Entrez votre nom';

  @override
  String get enterLastNamePlaceholder => 'Nom';

  @override
  String get errorUnknown =>
      'Une erreur est survenue lors du traitement de votre demande.';

  @override
  String get errorCodeExpired => 'Le code a expiré.';

  @override
  String get errorCodeInvalid => 'Le code n\'est pas valide.';

  @override
  String get errorInternal => 'Une erreur interne au serveur est survenue.';

  @override
  String get errorNotFound => 'La ressource est introuvable.';

  @override
  String get errorParameterInvalid => 'La valeur envoyée n\'est pas valide.';

  @override
  String get errorParameterMissing =>
      'Des paramètres sont manquants dans la requête.';

  @override
  String get errorSessionRevoked => 'Votre session n\'est plus valide.';

  @override
  String get errorUnauthorized =>
      'Vous n\'avez pas les autorisations nécessaires.';

  @override
  String get next => 'Suivant';

  @override
  String get continueWithEmail => 'Continuer avec l\'e-mail';

  @override
  String get termsAndConditions => 'Conditions générales';

  @override
  String get privacyPolicy => 'Politique de confidentialité';
}
