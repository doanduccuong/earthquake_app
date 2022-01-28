import 'package:earthquake_app/model/quake_model.dart';
import 'package:equatable/equatable.dart';

abstract class CubitState extends Equatable{}
class InitialState extends CubitState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class LoadingState extends CubitState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class LoadedState extends CubitState{
  final QuakeModel httpData;
  LoadedState({required this.httpData});
  @override
  // TODO: implement props
  List<Object?> get props => [httpData];

}
