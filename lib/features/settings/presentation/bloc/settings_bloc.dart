import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:notebooks/core/constants/constants.dart';

import '../../../../data/repositories/data_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SharedPreferences pref;
  DataRepository dataRepo;
  SettingsBloc({
    required this.pref,
    required this.dataRepo,
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
        var view = pref.getBool(Strings.isNoteContentHiddenKey);
        var noteViewType = pref.getString(Strings.noteViewTypeKey);
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
        print(
            "bloc noteViewType: $selectedView, isNoteContentHidden: $isNoteContentHidden");
        emit(AllSettingsFetchedState(
          selectedView: selectedView,
          isNoteContentHidden: isNoteContentHidden,
        ));
      }

      if (event is MakeIntroWatchedEvent) {
        emit(const IntroLoadingState());
        await pref.setBool(
          Strings.isIntroWatchedKey,
          true,
        );
        emit(const IntroWatchedState());
      }

      if (event is CheckIntroWatchedEvent) {
        emit(const IntroLoadingState());
        bool? isWatched = pref.getBool(Strings.isIntroWatchedKey);
        if (isWatched == null) {
          isWatched = false;
          await pref.setBool(
            Strings.isIntroWatchedKey,
            isWatched,
          );
          emit(const IntroNotWatchedState());
        } else if (isWatched == false) {
          emit(const IntroNotWatchedState());
        } else {
          emit(const IntroWatchedState());
          var view = pref.getBool(Strings.isNoteContentHiddenKey);
          var val = pref.getString(Strings.noteViewTypeKey);
          emit(AllSettingsFetchedState(
            isNoteContentHidden: view,
            selectedView: val?.getNoteViewType,
          ));
        }
      }

      // clear database
      if (event is ClearDatabaseEvent) {
        emit(DatabaseClearingState());
        await dataRepo.closeDatabase();

        emit(const DatabaseClearedState());

        // var view = pref.getBool(Strings.isNoteContentHiddenKey);
        // var val = pref.getString(Strings.noteViewTypeKey);
        // emit(AllSettingsFetchedState(
        //   isNoteContentHidden: view,
        //   selectedView: val?.getNoteViewType,
        // ));
      }
    });
  }
}
