import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/view/bloc/rental_rules/rentalrules_bloc.dart';
import 'package:godrive/view/bloc/rental_rules/rentalrules_event.dart';
import 'package:godrive/view/bloc/rental_rules/rentalrules_state.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/widgets/textformfields.dart';
import 'package:godrive/view/screens/universal_widgets/loading_button.dart';

class AddRentalRulesScreen extends StatefulWidget {
  const AddRentalRulesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddRentalRulesScreenState createState() => _AddRentalRulesScreenState();
}

class _AddRentalRulesScreenState extends State<AddRentalRulesScreen> {
  final TextEditingController _ruleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<RentalRulesBloc>().add(FetchRentalRulesEvent());
  }

  @override
  void dispose() {
    _ruleController.dispose();
    super.dispose();
  }

  void _addRule() {
    final rule = _ruleController.text;
    if (rule.isNotEmpty) {
      context.read<RentalRulesBloc>().add(AddRentalRuleEvent(rule: rule));
      _ruleController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a rule')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        backgroundColor: black,
        surfaceTintColor: black,
        centerTitle: true,
        title: const Text(
          'RENTAL RULES',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: white, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputfieldsMinLine2(
              modelnamecontroller: _ruleController,
              hint: 'Add a rental rule...',
            ),
            const SizedBox(height: 10),
            BlocBuilder<RentalRulesBloc, RentalRulesState>(
              builder: (context, state) {
                if (state is RentalRulesLoading) {
                  return SizedBox(
                    width: 130,
                    height: 50,
                    child: loadingButton(
                        media: size, onPressed: () {}, color: black),
                  );
                }
                return MaterialButton(
                  minWidth: 130,
                  height: 50,
                  color: black,
                  onPressed: _addRule,
                  child: const Text(
                    'ADD RULE',
                    style: TextStyle(fontWeight: FontWeight.w500, color: white),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<RentalRulesBloc, RentalRulesState>(
                builder: (context, state) {
                  if (state is RentalRulesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is RentalRulesLoaded) {
                    if (state.rules.isEmpty) {
                      return const Center(child: Text('No rules found.'));
                    }
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: state.rules.length,
                      itemBuilder: (context, index) {
                        final rule = state.rules[index];
                        return ListTile(
                          title: Text(
                            "${index + 1}   ${rule['rule']}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              context.read<RentalRulesBloc>().add(
                                  DeleteRentalRuleEvent(
                                      docId: rule['documentId']));
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is RentalRulesError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
