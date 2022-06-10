import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:notebooks/core/constants/constants.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SharedPreferences pref;
  SettingsBloc({
    required this.pref,
  }) : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) async {
      if (event is NoteViewSettingsChangedEvent) {
        var getValue = event.selectedView.getValue;
        await pref.setString(
          Strings.noteViewTypeKey,
          getValue,
        );
        var val = pref.getString(Strings.noteViewTypeKey);
        emit(NoteViewSettingsChangedState(
          selectedView: val!.getNoteViewType,
        ));
        var view = pref.getBool(Strings.isNoteContentHiddenKey);

        emit(AllSettingsFetchedState(
          isNoteContentHidden: view,
          selectedView: val.getNoteViewType,
        ));
      }

      if (event is ToggleNoteContentViewEvent) {
        print("bloc event.toggleView: ${event.toggleView}");
        await pref.setBool(
          Strings.isNoteContentHiddenKey,
          event.toggleView,
        );

        var view = pref.getBool(Strings.isNoteContentHiddenKey);
        emit(NoteContentViewToggledState(
          isNoteContentHidden: view!,
        ));

        var val = pref.getString(Strings.noteViewTypeKey);
        emit(AllSettingsFetchedState(
          isNoteContentHidden: view,
          selectedView: val?.getNoteViewType,
        ));
      }

      if (event is UpdateSettingsEvent) {
        // NoteViewType? eventViewType = event.selectedView;
        // bool? eventToggleContentView = event.toggleView;

        // String? prefViewTypeString = pref.getString(Strings.noteViewTypeKey);
        // NoteViewType? prefViewType = prefViewTypeString?.noteViewTypeValue;
        // bool? prefToggleContentView =
        //     pref.getBool(Strings.isNoteContentHiddenKey);

        // await pref.setString(
        //   Strings.noteViewTypeKey,
        //   eventViewType?.toString() ??
        //       prefViewType?.toString() ??
        //       NoteViewType.grid.toString(),
        // );
        // await pref.setBool(
        //   Strings.isNoteContentHiddenKey,
        //   eventToggleContentView ?? prefToggleContentView ?? false,
        // );

        //! next

        var view = pref.getBool(Strings.isNoteContentHiddenKey);
        var noteViewType = pref.getString(Strings.noteViewTypeKey);
        print("bloc get >> noteViewType: $noteViewType");
        print("bloc get >> view: $view");

        NoteViewType selectedView;
        if (noteViewType == null) {
          selectedView = NoteViewType.grid;
          await pref.setString(
            Strings.noteViewTypeKey,
            selectedView.getValue,
          );
        } else {
          selectedView = noteViewType.getNoteViewType;
        }

        bool isNoteContentHidden;
        if (view == null) {
          isNoteContentHidden = false;
          await pref.setBool(
            Strings.isNoteContentHiddenKey,
            isNoteContentHidden,
          );
        } else {
          isNoteContentHidden = view;
        }
        "bloc noteViewType: $selectedView, isNoteContentHidden: $isNoteContentHidden";
        emit(AllSettingsFetchedState(
          selectedView: selectedView,
          isNoteContentHidden: isNoteContentHidden,
        ));
      }
    });
  }
}
