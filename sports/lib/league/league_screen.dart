import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sports/league/data_classes.dart';
import 'package:sports/league/league_bloc.dart';

class LeaguePage extends StatefulWidget {
  LeaguePage({Key key, this.country}) : super(key: key);
  final String country;

  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeaguePage> {
  LeagueBloc _bloc = LeagueBloc();
  ProgressDialog pr;
  LeagueList _leagueList = new LeagueList();
  final _searchController = TextEditingController();

  Widget circularProgress = new Center(
      child: Padding(
    padding: const EdgeInsets.all(32.0),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          SizedBox(height: 56.0),
//              Container(alignment: Alignment.center, height: 80, width: 100, child: FlareActor("assets/flares/loading.flr", alignment: Alignment.center, fit: BoxFit.contain, animation: "Alarm")),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              "Please Wait..",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    ),
  ));

  @override
  Widget build(BuildContext context) {
    return BlocListener<LeagueBloc, LeagueScreenState>(
      bloc: _bloc,
      listener: (context, state) {
        if (pr?.isShowing() ?? false) {
          pr.hide();
        }
        if (state is LeagueLoadingState) {
        } else if (state is LeagueLoadErrorState) {
        } else if (state is LeagueLoadedState) {
          if (state.leagueApiResponseList != null) {
            _leagueList = state.leagueApiResponseList;
          }
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, LeagueScreenState state) {
          return Scaffold(
            backgroundColor: Color(0xffF5F9FC),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(8),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: "search here",
                    ),
                    controller: _searchController,
                    onSubmitted: (value) {
                      doAPICall();
                    },
                  ),
                  (state is LeagueLoadingState)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            circularProgress,
                          ],
                        )
                      : Container(
                          height: 500,
                          child: ListView.builder(
                            itemCount: _leagueList.leagueList?.length ?? 0,
                            itemBuilder: (context, i) {
                              return new Padding(
                                  padding: EdgeInsets.zero,
                                  child: new Container(
                                    child: new Container(
                                        width: 200,
                                        child: new Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            new Text(
                                              "${_leagueList.leagueList[i].strLeague}--${_leagueList.leagueList[i].sports.strSport}",
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        )),
                                  ));
                            },
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    doAPICall();
  }

  void doAPICall() {
    if (null != _leagueList.leagueList) {
      _leagueList.leagueList.clear();
    }
    _bloc.add(LoadLeagueEvent(country: widget.country, searchKey: _searchController.text));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
