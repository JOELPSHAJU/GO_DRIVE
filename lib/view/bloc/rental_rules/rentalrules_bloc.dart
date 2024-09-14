import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:godrive/view/bloc/rental_rules/rentalrules_event.dart';
import 'package:godrive/view/bloc/rental_rules/rentalrules_state.dart';




class RentalRulesBloc extends Bloc<RentalRulesEvent, RentalRulesState> {
  RentalRulesBloc() : super(RentalRulesInitial()) {
    on<FetchRentalRulesEvent>(_fetchRentalRules);
    on<AddRentalRuleEvent>(_addRentalRule);
    on<DeleteRentalRuleEvent>(_deleteRentalRule);
  }

  Future<void> _fetchRentalRules(
      FetchRentalRulesEvent event, Emitter<RentalRulesState> emit) async {
    emit(RentalRulesLoading());
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('rentalRules').get();

      List<Map<String, dynamic>> rules = querySnapshot.docs
          .map((doc) => {
                'documentId': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();

      emit(RentalRulesLoaded(rules: rules));
    } catch (e) {
      emit(RentalRulesError(message: e.toString()));
    }
  }

  Future<void> _addRentalRule(
      AddRentalRuleEvent event, Emitter<RentalRulesState> emit) async {
    try {
      await FirebaseFirestore.instance
          .collection('rentalRules')
          .add({'rule': event.rule});
      add(FetchRentalRulesEvent()); 
    } catch (e) {
      emit(RentalRulesError(message: e.toString()));
    }
  }

  Future<void> _deleteRentalRule(
      DeleteRentalRuleEvent event, Emitter<RentalRulesState> emit) async {
    try {
      await FirebaseFirestore.instance
          .collection('rentalRules')
          .doc(event.docId)
          .delete();
      add(FetchRentalRulesEvent()); 
    } catch (e) {
      emit(RentalRulesError(message: e.toString()));
    }
  }
}
