import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sports/league/data_classes.dart';
import 'package:sports/utils/api.dart';

class LeagueBloc extends Bloc<LeagueScreenEvent, LeagueScreenState> {
  @override
  LeagueScreenState get initialState => InitialLeagueScreenState();

  @override
  Stream<LeagueScreenState> mapEventToState(LeagueScreenEvent event) async* {
    if (event is LoadLeagueEvent) {
      try {
        yield LeagueLoadingState();
        LeagueList leagueApiResponseList = await API().getLeagueListFromServer(country: event.country, searchKey: event.searchKey);
        if (leagueApiResponseList.leagueList != null) {
          yield LeagueLoadedState(leagueApiResponseList);
        }
      } catch (e) {
        yield LeagueLoadErrorState(errorMessage(e.toString()));
      }
    }
  }
}

@immutable
abstract class LeagueScreenEvent {}

class LoadLeagueEvent extends LeagueScreenEvent {
  final String country;
  final String searchKey;

  LoadLeagueEvent({this.country, this.searchKey});
}

@immutable
abstract class LeagueScreenState {}

class InitialLeagueScreenState extends LeagueScreenState {}

class LeagueLoadingState extends LeagueScreenState {}

class LeagueLoadedState extends LeagueScreenState {
  final LeagueList leagueApiResponseList;

  LeagueLoadedState(this.leagueApiResponseList);
}

class LeagueLoadErrorState extends LeagueScreenState {
  final String errorMessage;

  LeagueLoadErrorState(this.errorMessage);
}
