part of 'theme_bloc.dart';

abstract class ThemeState {
  final bool theme;
  ThemeState(this.theme);
}

class ThemeInitState extends ThemeState {
  ThemeInitState() : super(false);
}

class ThemechangeState extends ThemeState {
  ThemechangeState(bool isdark) : super(isdark);
}
