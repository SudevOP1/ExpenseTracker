import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List expenses = [];

  final String baseUrl = "http://127.0.0.1:8000/appname";

  @override
  void initState() {
    super.initState();
    fetchExpenses();
  }


  Future<void> fetchExpenses() async {
    try {
      final res = await http.get(Uri.parse("$baseUrl/get-expenses/"));
      final data = jsonDecode(res.body);

      setState(() {
        expenses = data["expenses"] ?? [];
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addExpense(String name, String cost, String desc) async {
    await http.post(
      Uri.parse("$baseUrl/create-expense/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "cost": double.parse(cost),
        "desc": desc,
      }),
    );

    fetchExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await http.delete(
      Uri.parse("$baseUrl/delete-expense/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": id}),
    );

    fetchExpenses();
  }

  Future<void> editExpense(
    int id,
    String name,
    String cost,
    String desc,
  ) async {
    await http.put(
      Uri.parse("$baseUrl/update-expense/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": id,
        "name": name,
        "cost": double.parse(cost),
        "desc": desc,
      }),
    );

    fetchExpenses();
  }

  void openAddSheet() {
    final name = TextEditingController();
    final cost = TextEditingController();
    final desc = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Add Expense",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                TextField(
                  controller: name,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                TextField(
                  controller: cost,
                  decoration: const InputDecoration(hintText: "Cost"),
                ),
                TextField(
                  controller: desc,
                  decoration: const InputDecoration(hintText: "Description"),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    addExpense(name.text, cost.text, desc.text);
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void openEditSheet(dynamic e) {
    final name = TextEditingController(text: e["name"]);
    final cost = TextEditingController(text: e["cost"].toString());
    final desc = TextEditingController(text: e["desc"]);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Edit Expense",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                TextField(controller: name),
                TextField(controller: cost),
                TextField(controller: desc),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    editExpense(e["id"], name.text, cost.text, desc.text);
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF4F6FA),
        title: const Text(
          "Xpense",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          InkWell(
            onTap: openAddSheet,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    "Add Expense",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (_, i) {
                final e = expenses[i];

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              e["desc"] ?? "",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      Text("₹${e["cost"]}"),

                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => openEditSheet(e),
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteExpense(e["id"]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
