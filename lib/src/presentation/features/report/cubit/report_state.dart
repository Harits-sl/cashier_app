part of 'report_cubit.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportSuccess extends ReportState {
  const ReportSuccess(this.orders);

  final List<ReportOrder> orders;

  @override
  List<Object> get props => [orders];
}

class ReportFailed extends ReportState {
  const ReportFailed(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
