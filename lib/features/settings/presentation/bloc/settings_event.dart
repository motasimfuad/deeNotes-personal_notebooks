part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class UpdateSettingsEvent extends SettingsEvent {}

class NoteViewSettingsChangedEvent extends SettingsEvent {
  final NoteViewType selectedView;
  const NoteViewSettingsChangedEvent({required this.selectedView});
  @override
  List<Object> get props => [selectedView];
}

class ToggleNoteContentViewEvent extends SettingsEvent {
  final bool toggleView;
  const ToggleNoteContentViewEvent({required this.toggleView});
  @override
  List<Object> get props => [toggleView];
}

// intro watched
class MakeIntroWatchedEvent extends SettingsEvent {
  const MakeIntroWatchedEvent();
  @override
  List<Object> get props => [];
}

class CheckIntroWatchedEvent extends SettingsEvent {
  const CheckIntroWatchedEvent();
  @override
  List<Object> get props => [];
}

// clear database
class ClearDatabaseEvent extends SettingsEvent {}
