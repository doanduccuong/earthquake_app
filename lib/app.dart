import 'package:earthquake_app/cubit/app_cubit.dart';
import 'package:earthquake_app/cubit/app_cubit_logic.dart';
import 'package:earthquake_app/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class EarthquakeApp extends StatelessWidget {
  const EarthquakeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<AppCubit>(
        create: (context)=>AppCubit(data: DataService()),
        child: const AppCubitLogic(),
      ),
    );
  }
}
