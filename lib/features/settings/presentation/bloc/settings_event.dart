part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class UpdateSettingsEvent extends SettingsEvent {
  // final NoteViewType? selectedView;
  // final bool? toggleView;
  // const UpdateSettingsEvent({
  //   this.selectedView,
  //   this.toggleView,
  // });
}

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
