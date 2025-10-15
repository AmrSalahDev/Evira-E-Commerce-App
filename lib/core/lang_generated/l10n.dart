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

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Create your Account`
  String get createYourAccount {
    return Intl.message(
      'Create your Account',
      name: 'createYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login to your Account`
  String get loginToYourAccount {
    return Intl.message(
      'Login to your Account',
      name: 'loginToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message('Remember me', name: 'rememberMe', desc: '', args: []);
  }

  /// `or continue with`
  String get orContinueWith {
    return Intl.message(
      'or continue with',
      name: 'orContinueWith',
      desc: '',
      args: [],
    );
  }

  /// `Forgot the password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot the password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Fill Your Profile`
  String get fillYourProfile {
    return Intl.message(
      'Fill Your Profile',
      name: 'fillYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message('Select Date', name: 'selectDate', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Nickname`
  String get nickName {
    return Intl.message('Nickname', name: 'nickName', desc: '', args: []);
  }

  /// `Date of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `Continue`
  String get continuee {
    return Intl.message('Continue', name: 'continuee', desc: '', args: []);
  }

  /// `Create New PIN`
  String get createNewPin {
    return Intl.message(
      'Create New PIN',
      name: 'createNewPin',
      desc: '',
      args: [],
    );
  }

  /// `Add a PIN number to make your account more secure.`
  String get addPin {
    return Intl.message(
      'Add a PIN number to make your account more secure.',
      name: 'addPin',
      desc: '',
      args: [],
    );
  }

  /// `Set Your Fingerprint`
  String get setYourFingerprint {
    return Intl.message(
      'Set Your Fingerprint',
      name: 'setYourFingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Add a fingerprint to make your account\nmore secure.`
  String get addFingerprint {
    return Intl.message(
      'Add a fingerprint to make your account\nmore secure.',
      name: 'addFingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Please put your finger on the fingerprint\nscanner to get started`
  String get putYourFinger {
    return Intl.message(
      'Please put your finger on the fingerprint\nscanner to get started',
      name: 'putYourFinger',
      desc: '',
      args: [],
    );
  }

  /// `Confirm biometric`
  String get confirmBiometric {
    return Intl.message(
      'Confirm biometric',
      name: 'confirmBiometric',
      desc: '',
      args: [],
    );
  }

  /// `Biometric aren't set up`
  String get biometricAreNotSetUpTitle {
    return Intl.message(
      'Biometric aren\'t set up',
      name: 'biometricAreNotSetUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `To enable this feature, first set up face or fingerprint unlock in your device settings.`
  String get setUpBiometricDescription {
    return Intl.message(
      'To enable this feature, first set up face or fingerprint unlock in your device settings.',
      name: 'setUpBiometricDescription',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Too many attempts. Try again after 30 seconds.`
  String get tooManyAttempts {
    return Intl.message(
      'Too many attempts. Try again after 30 seconds.',
      name: 'tooManyAttempts',
      desc: '',
      args: [],
    );
  }

  /// `Your account is ready to use. You will be redirected to the Home page in a\nfew seconds..`
  String get accountIsReady {
    return Intl.message(
      'Your account is ready to use. You will be redirected to the Home page in a\nfew seconds..',
      name: 'accountIsReady',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congratulations {
    return Intl.message(
      'Congratulations!',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forgetPasswordTitle {
    return Intl.message(
      'Forget Password',
      name: 'forgetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select which contact details should we use to reset your password`
  String get forgetPasswordDescription {
    return Intl.message(
      'Select which contact details should we use to reset your password',
      name: 'forgetPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `via Email:`
  String get viaEmail {
    return Intl.message('via Email:', name: 'viaEmail', desc: '', args: []);
  }

  /// `via SMS:`
  String get viaSMS {
    return Intl.message('via SMS:', name: 'viaSMS', desc: '', args: []);
  }

  /// `Code has been send to `
  String get codeHasBeenSend {
    return Intl.message(
      'Code has been send to ',
      name: 'codeHasBeenSend',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Resend code in`
  String get resendCode {
    return Intl.message(
      'Resend code in',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
  }

  /// `Create new password`
  String get createNewPassword {
    return Intl.message(
      'Create new password',
      name: 'createNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create your new password`
  String get createYourNewPassword {
    return Intl.message(
      'Create your new password',
      name: 'createYourNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password too weak`
  String get passwordTooWeak {
    return Intl.message(
      'Password too weak',
      name: 'passwordTooWeak',
      desc: '',
      args: [],
    );
  }

  /// `Email already in use`
  String get emailAlreadyInUse {
    return Intl.message(
      'Email already in use',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Too many requests`
  String get tooManyRequests {
    return Intl.message(
      'Too many requests',
      name: 'tooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Operation not allowed`
  String get operationNotAllowed {
    return Intl.message(
      'Operation not allowed',
      name: 'operationNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Network error`
  String get networkError {
    return Intl.message(
      'Network error',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknownError {
    return Intl.message(
      'Unknown error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Email or password is incorrect`
  String get invalid_credentials {
    return Intl.message(
      'Email or password is incorrect',
      name: 'invalid_credentials',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon`
  String get comingSoon {
    return Intl.message('Coming soon', name: 'comingSoon', desc: '', args: []);
  }

  /// `Incorrect PIN`
  String get incorrectPIN {
    return Intl.message(
      'Incorrect PIN',
      name: 'incorrectPIN',
      desc: '',
      args: [],
    );
  }

  /// `Error verifying PIN`
  String get errorverifyingPIN {
    return Intl.message(
      'Error verifying PIN',
      name: 'errorverifyingPIN',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save PIN`
  String get failedToSavePIN {
    return Intl.message(
      'Failed to save PIN',
      name: 'failedToSavePIN',
      desc: '',
      args: [],
    );
  }

  /// `Oops! No internet!`
  String get noInternet {
    return Intl.message(
      'Oops! No internet!',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `You're back online!`
  String get backOnline {
    return Intl.message(
      'You\'re back online!',
      name: 'backOnline',
      desc: '',
      args: [],
    );
  }

  /// `Connected but no internet!`
  String get connectedWithoutInternet {
    return Intl.message(
      'Connected but no internet!',
      name: 'connectedWithoutInternet',
      desc: '',
      args: [],
    );
  }

  /// `No Internet`
  String get noInternetTitle {
    return Intl.message(
      'No Internet',
      name: 'noInternetTitle',
      desc: '',
      args: [],
    );
  }

  /// `Still no internet connection.`
  String get stillNoInternetConnection {
    return Intl.message(
      'Still no internet connection.',
      name: 'stillNoInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection!`
  String get noInternetConnection {
    return Intl.message(
      'No Internet Connection!',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please check your Wi-Fi or mobile data and try again.`
  String get noInternetDescription {
    return Intl.message(
      'Please check your Wi-Fi or mobile data and try again.',
      name: 'noInternetDescription',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Good Morning `
  String get goodMorning {
    return Intl.message(
      'Good Morning ',
      name: 'goodMorning',
      desc: '',
      args: [],
    );
  }

  /// `Good Afternoon `
  String get goodAfternoon {
    return Intl.message(
      'Good Afternoon ',
      name: 'goodAfternoon',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening `
  String get goodEvening {
    return Intl.message(
      'Good Evening ',
      name: 'goodEvening',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message('See All', name: 'seeAll', desc: '', args: []);
  }

  /// `Special Offers`
  String get specialOffers {
    return Intl.message(
      'Special Offers',
      name: 'specialOffers',
      desc: '',
      args: [],
    );
  }

  /// `Most Popular`
  String get mostPopular {
    return Intl.message(
      'Most Popular',
      name: 'mostPopular',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Orders`
  String get orders {
    return Intl.message('Orders', name: 'orders', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Wallet`
  String get wallet {
    return Intl.message('Wallet', name: 'wallet', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `sold`
  String get sold {
    return Intl.message('sold', name: 'sold', desc: '', args: []);
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Account setup successful!`
  String get acountSetupSuccessfully {
    return Intl.message(
      'Account setup successful!',
      name: 'acountSetupSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been created!`
  String get yourAccountHasBeenCreated {
    return Intl.message(
      'Your account has been created!',
      name: 'yourAccountHasBeenCreated',
      desc: '',
      args: [],
    );
  }

  /// `No notifications yet.`
  String get noNotifications {
    return Intl.message(
      'No notifications yet.',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete?`
  String get areYouSureToDelete {
    return Intl.message(
      'Are you sure you want to delete?',
      name: 'areYouSureToDelete',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `My Wishlist`
  String get wishlist {
    return Intl.message('My Wishlist', name: 'wishlist', desc: '', args: []);
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
