import 'package:authentication/src/bloc/base_page_state.dart';
import 'package:authentication/src/bloc/home_bloc.dart';
import 'package:authentication/src/services/dependency_service.dart';
import 'package:authentication/src/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final String text;

  const HomePage({this.text});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomeBloc, HomePage> {
  void initState() {
    super.initState();
    bloc.add(InitializeEvent(text: widget.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeBlocState>(
      cubit: bloc,
      builder: (context, state) {
        return Stack(
          children: [
            if (state is InititializeState)
              HomeWidget(
                logOutOnTapFunction: () => bloc.add(LogOutOnTapEvent()),
                uuid: widget.text,
              ),
          ],
        );
      },
    );
  }
}

class HomeWidget extends StatelessWidget {
  final String uuid;
  final Function logOutOnTapFunction;

  const HomeWidget({this.uuid, this.logOutOnTapFunction});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(uuid),
              RaisedButton(
                onPressed: () => logOutOnTapFunction(),
                child: Text('logOut'),
              )
            ],
          ),
        )),
      ),
    );
  }
}
