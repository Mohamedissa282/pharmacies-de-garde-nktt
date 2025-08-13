// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Nous vous offrons des informations précises et à jour sur les pharmacies de garde disponibles près de chez vous.`
  String get title1 {
    return Intl.message(
      'Nous vous offrons des informations précises et à jour sur les pharmacies de garde disponibles près de chez vous.',
      name: 'title1',
      desc: '',
      args: [],
    );
  }

  /// `Disponible 24h/24 et 7j/7, votre santé ne prend jamais de pause et nous non plus.`
  String get titele2 {
    return Intl.message(
      'Disponible 24h/24 et 7j/7, votre santé ne prend jamais de pause et nous non plus.',
      name: 'titele2',
      desc: '',
      args: [],
    );
  }

  /// `Une interface intuitive qui vous permet de trouver une pharmacie en quelques clics seulement.`
  String get title3 {
    return Intl.message(
      'Une interface intuitive qui vous permet de trouver une pharmacie en quelques clics seulement.',
      name: 'title3',
      desc: '',
      args: [],
    );
  }

  /// `Sauter`
  String get title4 {
    return Intl.message('Sauter', name: 'title4', desc: '', args: []);
  }

  /// `Faite`
  String get title5 {
    return Intl.message('Faite', name: 'title5', desc: '', args: []);
  }

  /// `Suivant`
  String get title6 {
    return Intl.message('Suivant', name: 'title6', desc: '', args: []);
  }

  /// `Arab`
  String get title7 {
    return Intl.message('Arab', name: 'title7', desc: '', args: []);
  }

  /// `Français`
  String get title8 {
    return Intl.message('Français', name: 'title8', desc: '', args: []);
  }

  /// `Se connecter`
  String get title9 {
    return Intl.message('Se connecter', name: 'title9', desc: '', args: []);
  }

  /// `Créer un compte`
  String get title10 {
    return Intl.message('Créer un compte', name: 'title10', desc: '', args: []);
  }

  /// `Bienvenue`
  String get title11 {
    return Intl.message('Bienvenue', name: 'title11', desc: '', args: []);
  }

  /// `Accédez à votre compte et découvrez nos services !`
  String get title12 {
    return Intl.message(
      'Accédez à votre compte et découvrez nos services !',
      name: 'title12',
      desc: '',
      args: [],
    );
  }

  /// `Créez un compte et découvrez notre application`
  String get title0 {
    return Intl.message(
      'Créez un compte et découvrez notre application',
      name: 'title0',
      desc: '',
      args: [],
    );
  }

  /// `Email Adress`
  String get title13 {
    return Intl.message('Email Adress', name: 'title13', desc: '', args: []);
  }

  /// `Password`
  String get title14 {
    return Intl.message('Password', name: 'title14', desc: '', args: []);
  }

  /// `Mot de passe oublié`
  String get title15 {
    return Intl.message(
      'Mot de passe oublié',
      name: 'title15',
      desc: '',
      args: [],
    );
  }

  /// `Se connecter`
  String get title16 {
    return Intl.message('Se connecter', name: 'title16', desc: '', args: []);
  }

  /// `Créer le compte`
  String get title17 {
    return Intl.message('Créer le compte', name: 'title17', desc: '', args: []);
  }

  /// `Ou`
  String get title18 {
    return Intl.message('Ou', name: 'title18', desc: '', args: []);
  }

  /// `Google`
  String get title19 {
    return Intl.message('Google', name: 'title19', desc: '', args: []);
  }

  /// `Entrer une adresse email`
  String get title20 {
    return Intl.message(
      'Entrer une adresse email',
      name: 'title20',
      desc: '',
      args: [],
    );
  }

  /// `Veuillez entrer une adresse email valide`
  String get title21 {
    return Intl.message(
      'Veuillez entrer une adresse email valide',
      name: 'title21',
      desc: '',
      args: [],
    );
  }

  /// `Entrer le password`
  String get title22 {
    return Intl.message(
      'Entrer le password',
      name: 'title22',
      desc: '',
      args: [],
    );
  }

  /// `Contact Nous`
  String get title23 {
    return Intl.message('Contact Nous', name: 'title23', desc: '', args: []);
  }

  /// `Se déconnecter`
  String get title24 {
    return Intl.message('Se déconnecter', name: 'title24', desc: '', args: []);
  }

  /// `Favoris`
  String get title25 {
    return Intl.message('Favoris', name: 'title25', desc: '', args: []);
  }

  /// `Mapharmacie`
  String get title26 {
    return Intl.message('Mapharmacie', name: 'title26', desc: '', args: []);
  }

  /// `Fermé`
  String get title27 {
    return Intl.message('Fermé', name: 'title27', desc: '', args: []);
  }

  /// `Ouvrir`
  String get title28 {
    return Intl.message('Ouvrir', name: 'title28', desc: '', args: []);
  }

  /// `km`
  String get title29 {
    return Intl.message('km', name: 'title29', desc: '', args: []);
  }

  /// `Si vous avez oublié votre mot de passe, veuillez saisir une adresse email valide`
  String get title31 {
    return Intl.message(
      'Si vous avez oublié votre mot de passe, veuillez saisir une adresse email valide',
      name: 'title31',
      desc: '',
      args: [],
    );
  }

  /// `Un message a été envoyé à votre adresse e-mail. Veuillez vérifier et modifier votre mot de passe.`
  String get title30 {
    return Intl.message(
      'Un message a été envoyé à votre adresse e-mail. Veuillez vérifier et modifier votre mot de passe.',
      name: 'title30',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
