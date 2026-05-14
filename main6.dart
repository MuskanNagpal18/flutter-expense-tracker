import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ExpenseTracker(),
    );
  }
}

class ExpenseTracker
    extends StatefulWidget {
  const ExpenseTracker(
      {super.key});

  @override
  State<ExpenseTracker>
      createState() =>
          _ExpenseTrackerState();
}

class _ExpenseTrackerState
    extends State<
        ExpenseTracker> {

  final TextEditingController
      amountController =
      TextEditingController();

  final TextEditingController
      categoryController =
      TextEditingController();

  List<Map<String, dynamic>>
      expenses = [];

  double totalExpense = 0;

  void addExpense() {
    String category =
        categoryController.text;

    double amount =
        double.tryParse(
                amountController
                    .text) ??
            0;

    if (category.isNotEmpty &&
        amount > 0) {

      setState(() {
        expenses.add({
          "category":
              category,
          "amount":
              amount,
        });

        totalExpense +=
            amount;
      });

      amountController.clear();
      categoryController.clear();
    }
  }

  void deleteExpense(
      int index) {

    setState(() {
      totalExpense -=
          expenses[index]
              ["amount"];

      expenses.removeAt(
          index);
    });
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Expense Tracker"),
        centerTitle: true,
        backgroundColor:
            Colors.green,
      ),

      body: Padding(
        padding:
            const EdgeInsets
                .all(16),

        child: Column(
          children: [

            TextField(
              controller:
                  categoryController,

              decoration:
                  const InputDecoration(
                labelText:
                    "Expense Category",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
                height: 10),

            TextField(
              controller:
                  amountController,

              keyboardType:
                  TextInputType
                      .number,

              decoration:
                  const InputDecoration(
                labelText:
                    "Amount",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
                height: 10),

            ElevatedButton(
              onPressed:
                  addExpense,

              child: const Text(
                  "Add Expense"),
            ),

            const SizedBox(
                height: 20),

            Text(
              "Total Expense: ₹${totalExpense.toStringAsFixed(2)}",

              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 20),

            Expanded(
              child:
                  ListView.builder(
                itemCount:
                    expenses.length,

                itemBuilder:
                    (context,
                        index) {

                  return Card(
                    child:
                        ListTile(
                      title:
                          Text(
                        expenses[index]
                            [
                            "category"],
                      ),

                      subtitle:
                          Text(
                        "₹${expenses[index]["amount"]}",
                      ),

                      trailing:
                          IconButton(
                        icon:
                            const Icon(
                          Icons
                              .delete,
                          color:
                              Colors.red,
                        ),

                        onPressed:
                            () =>
                                deleteExpense(
                                    index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}