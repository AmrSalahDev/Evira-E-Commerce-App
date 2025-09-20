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

class EviraLang {
  EviraLang();

  static EviraLang? _current;

  static EviraLang get current {
    assert(
      _current != null,
      'No instance of EviraLang was loaded. Try to initialize the EviraLang delegate before accessing EviraLang.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<EviraLang> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = EviraLang();
      EviraLang._current = instance;

      return instance;
    });
  }

  static EviraLang of(BuildContext context) {
    final instance = EviraLang.maybeOf(context);
    assert(
      instance != null,
      'No instance of EviraLang present in the widget tree. Did you add EviraLang.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static EviraLang? maybeOf(BuildContext context) {
    return Localizations.of<EviraLang>(context, EviraLang);
  }

  /// `We provide high quality products just for you`
  String get onboarding_title_1 {
    return Intl.message(
      'We provide high quality products just for you',
      name: 'onboarding_title_1',
      desc: '',
      args: [],
    );
  }

  /// `Your satisfaction is our number one priority`
  String get onboarding_title_2 {
    return Intl.message(
      'Your satisfaction is our number one priority',
      name: 'onboarding_title_2',
      desc: '',
      args: [],
    );
  }

  /// `Let's fulfill your daily needs with Evira right now!`
  String get onboarding_title_3 {
    return Intl.message(
      'Let\'s fulfill your daily needs with Evira right now!',
      name: 'onboarding_title_3',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Let's you in`
  String get letsYouIn {
    return Intl.message('Let\'s you in', name: 'letsYouIn', desc: '', args: []);
  }

  /// `Continue with Facebook`
  String get continueWithFacebook {
    return Intl.message(
      'Continue with Facebook',
      name: 'continueWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get continueWithApple {
    return Intl.message(
      'Continue with Apple',
      name: 'continueWithApple',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Sign in with password`
  String get signInWithPassword {
    return Intl.message(
      'Sign in with password',
      name: 'signInWithPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message('Sign up', name: 'signUp', desc: '', args: []);
  }

  /// `Sign in`
  String get signIn {
    return Intl.message('Sign in', name: 'signIn', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<EviraLang> {
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
  Future<EviraLang> load(Locale locale) => EviraLang.load(locale);
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
