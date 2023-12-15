part of 'ibloc_bloc.dart';

sealed class IblocState extends Equatable {
  const IblocState();
  
  @override
  List<Object> get props => [];
}

final class IblocInitial extends IblocState {}
