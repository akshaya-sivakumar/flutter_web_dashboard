part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class ThemechangeEvent extends ThemeEvent {
  final bool darkTheme;

  ThemechangeEvent(this.darkTheme);
}

class FetchthemeEvent extends ThemeEvent {}
