import 'package:earthquake_app/cubit/app_cutibt_state.dart';
import 'package:earthquake_app/ui/quake_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_cubit.dart';
class AppCubitLogic extends StatefulWidget {
  const AppCubitLogic({Key? key}) : super(key: key);

  @override
  _AppCubitLogicState createState() => _AppCubitLogicState();
}

class _AppCubitLogicState extends State<AppCubitLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit,CubitState>(
        builder: (context,state){
          if(state is LoadingState){
            return Center(child: CircularProgressIndicator());
          }
          if(state is LoadedState){
            return QuakesApp();
          }
          else{
            return Container();
          }
        },
      ),
    );
  }
}
