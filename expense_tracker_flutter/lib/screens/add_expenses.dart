import 'package:expense_tracker_flutter/services/global_service.dart';
import 'package:expense_tracker_flutter/widgets/button.dart';
import 'package:expense_tracker_flutter/widgets/screen_container.dart';
import 'package:flutter/material.dart';

import '../widgets/text.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => AddExpensesStats();
}

class AddExpensesStats extends State<AddExpenses> {
  TextEditingController addBudgetController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int budget = 0;
    int remainingBudget = 0;

    return Scaffold(
      body: ScreenContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CText(text: "Add Expenses", fontSize: 24),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller:
                    addBudgetController, // Link the controller to the TextField
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Budget(₹)',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CButton(
                text: 'Add Budget',
                width: 180,
                onPressed: () {
                  budget = int.parse(addBudgetController.text);
                  remainingBudget = int.parse(addBudgetController.text);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CText(
                text: 'Budget: ₹${GlobalService.numFormatter(budget)}',
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Flexible(
                    flex: 1,
                    child: CText(
                      text: 'ADD EXPENSES',
                      fontSize: 20,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: CText(
                      text:
                          'Remaining Budget: ₹${GlobalService.numFormatter(remainingBudget)}',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller:
                    titleController, // Link the controller to the TextField
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller:
                    amountController, // Link the controller to the TextField
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount(₹)',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), // Calendar icon
                  labelText: "To Date",
                  border: OutlineInputBorder(),
                ),
                readOnly: true, // Makes the field non-editable
                onTap: () async {
                  // When the field is tapped, open the date picker
                  String date = await GlobalService.selectDate(context);
                  setState(() {
                    dateController.text = date;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CButton(
                text: 'Add Expense',
                width: 180,
                onPressed: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              Table(
                border: const TableBorder(
                  horizontalInside: BorderSide(
                      color: Color.fromRGBO(218, 165, 32, 1),
                      width: 2), // Horizontal inner borders
                  verticalInside: BorderSide(
                      color: Color.fromRGBO(218, 165, 32, 1),
                      width: 2), // Vertical inner borders
                  top: BorderSide(
                      color: Color.fromRGBO(218, 165, 32, 1),
                      width: 2), // Top border
                  bottom: BorderSide(
                      color: Color.fromRGBO(218, 165, 32, 1),
                      width: 2), // Bottom border
                  left: BorderSide(
                      color: Color.fromRGBO(218, 165, 32, 1),
                      width: 2), // Left border
                  right: BorderSide(
                      color: Color.fromRGBO(218, 165, 32, 1), width: 2),
                ),
                columnWidths: const {
                  // Use FractionColumnWidth to make all columns equal width
                  0: FractionColumnWidth(0.25),
                  1: FractionColumnWidth(0.25),
                  2: FractionColumnWidth(0.25),
                  3: FractionColumnWidth(0.25),
                },
                children: [
                  const TableRow(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          5, 248, 56, 56), // Header background color #f8f8f838
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CText(
                          text: 'Title',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CText(
                          text: 'Amount (₹)',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CText(
                          text: 'Date',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CText(
                          textAlign: TextAlign.center,
                          text: 'Action',
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(
                          248, 244, 244, 229), // Row background color #f8f8f8de
                    ),
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CText(
                            text: 'Alice',
                            textAlign: TextAlign.center,
                            color: Colors.blue),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CText(
                            text: '30',
                            textAlign: TextAlign.center,
                            color: Colors.blue),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CText(
                            text: 'New York',
                            textAlign: TextAlign.center,
                            color: Colors.blue),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 2,
                              child: IconButton(
                                autofocus: true,
                                iconSize: 30,
                                color: Colors.blueAccent,
                                icon: const Icon(Icons.edit_note),
                                onPressed:
                                    () {}, // Disable button when on first page
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 2,
                              child: IconButton(
                                iconSize: 30,
                                color: Colors.red,
                                icon: const Icon(Icons.delete),
                                onPressed:
                                    () {}, // Disable button when on first page
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CText(
                text:
                    'Total Expenses: ₹${GlobalService.numFormatter(remainingBudget)}',
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CButton(text: 'Submit Expenses', onPressed: () {}),
                  const SizedBox(
                    width: 20,
                  ),
                  CButton(text: 'Reset', color: Colors.red, onPressed: () {})
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
