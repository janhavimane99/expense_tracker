import 'dart:async';

import 'package:expense_tracker_flutter/services/global_service.dart';
import 'package:expense_tracker_flutter/widgets/button.dart';
import 'package:expense_tracker_flutter/widgets/screen_container.dart';
import 'package:expense_tracker_flutter/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class ListExpenses extends StatefulWidget {
  const ListExpenses({super.key});

  @override
  State<ListExpenses> createState() => _ListExpensesState();
}

class _ListExpensesState extends State<ListExpenses> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  Timer? debounce;

  // Pagination variables
  final int _rowsPerPage = 20;
  late int _currentPage = 0;

  List<Map<String, dynamic>> expensesList = List.generate(
    1000,
    (index) => {
      'date': '2024-10-${index + 1}',
      'description': 'Expense ${index + 1}',
      'amount': '\$${(index + 1) * 10}',
      'category': 'Category ${index + 1}',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenContainer(
        child: Column(
          children: [
            const CText(text: "Expenses List", fontSize: 24),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: TextField(
                    controller:
                        searchController, // Link the controller to the TextField
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                    ),
                    onChanged: (value) {
                      onInputChanged(value, timer: true);
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    controller: fromDateController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), // Calendar icon
                      labelText: "From Date",
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true, // Makes the field non-editable
                    onTap: () async {
                      // When the field is tapped, open the date picker
                      String date = await GlobalService.selectDate(context);
                      setState(() {
                        fromDateController.text = date;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    controller: toDateController,
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
                        toDateController.text = date;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 2,
                  child: CButton(
                      text: 'Search By Date',
                      width: 180,
                      onPressed: () {
                        searchController.clear();
                        fromDateController.clear();
                        toDateController.clear();
                      }),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 2,
                  child: CButton(
                    text: 'Clear',
                    color: Colors.grey,
                    width: 90,
                    onPressed: clear,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // DataTable2 widget after the search and date row
            Expanded(
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: const [
                  DataColumn2(
                    label: Text('Date'),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text('Description'),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text('Amount'),
                    size: ColumnSize.M,
                  ),
                  DataColumn2(
                    label: Text('DELETE'),
                    size: ColumnSize.S,
                  ),
                ],
                rows: _buildRows(),
              ),
            ),
            // Pagination Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: CText(
                    text: expensesList.length.toString(),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: 40,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: _currentPage > 0
                            ? () {
                                setState(() {
                                  _currentPage--;
                                });
                              }
                            : null, // Disable button when on first page
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 30),
                        child: Text(
                          'Page ${_currentPage + 1}'.trim(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF77A9F5),
                            decoration: TextDecoration.none,
                            fontFamily: 'Mulish',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        iconSize: 40,
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: (_currentPage + 1) * _rowsPerPage <
                                expensesList.length
                            ? () {
                                setState(() {
                                  _currentPage++;
                                });
                              }
                            : null, // Disable button when on the last page
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // return const CText(text: "Hello");
  }

// Build rows based on the current page
  List<DataRow> _buildRows() {
    // Calculate the starting and ending index for the current page
    int startIndex = _currentPage * _rowsPerPage;
    int endIndex = startIndex + _rowsPerPage;
    List<Map<String, dynamic>> currentPageItems = expensesList.sublist(
      startIndex,
      endIndex > expensesList.length ? expensesList.length : endIndex,
    );

    // Generate DataRows for the current page
    return currentPageItems
        .map(
          (item) => DataRow(
            cells: [
              DataCell(Text(item['date'])),
              DataCell(Text(item['description'])),
              DataCell(Text(item['amount'])),
              DataCell(CButton(
                text: 'Delete',
                color: Colors.red,
                width: 100,
                onPressed: () {},
              )),
            ],
          ),
        )
        .toList();
  }

  // Function to handle value change with optional debounce
  void onInputChanged(String value, {bool timer = false}) {
    if (timer) {
      // If timer is true, implement debounce logic
      // Cancel the previous timer if it exists
      if (debounce?.isActive ?? false) {
        debounce!.cancel();
      }
      // Start a new timer that will execute after 2 seconds
      debounce = Timer(const Duration(seconds: 2), () {
        // This block will be executed after the user stops typing for 2 seconds
        // print('Search By: $value');
      });
    } else {
      // If timer is false, execute immediately
      // print('Search By: $value');
    }
  }

  clear() {
    debounce?.cancel();
    searchController.clear();
    fromDateController.clear();
    toDateController.clear();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    debounce?.cancel();
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    fromDateController.dispose();
    toDateController.dispose();

    super.dispose();
  }
}
