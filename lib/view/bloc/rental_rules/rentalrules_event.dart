// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

@immutable
abstract class RentalRulesEvent {}

class FetchRentalRulesEvent extends RentalRulesEvent {}

class AddRentalRuleEvent extends RentalRulesEvent {
  final String rule;
  AddRentalRuleEvent({required this.rule});
}

class DeleteRentalRuleEvent extends RentalRulesEvent {
  final String docId;
  DeleteRentalRuleEvent({required this.docId});
}
