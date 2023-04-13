import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sales_1/create_commodity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String? email = FirebaseAuth.instance.currentUser!.email;
    final Stream<QuerySnapshot> notesStream = FirebaseFirestore.instance
        .collection('sales')
        .doc(email)
        .collection('notes')
        .orderBy('time', descending: true)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              FirebaseAuth.instance.currentUser!.photoURL!,
              width: 40,
            ),
          ),
        ],
        title: const Text('البضاعه المباعة'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateCommodity(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.pink,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: notesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('خطأ في الاتصال');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('جاري التحميل');
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwipeActionCell(
                  key: ObjectKey(document),
                  trailingActions: <SwipeAction>[
                    SwipeAction(
                        performsFirstActionWithFullSwipe: true,
                        title: "مسح",
                        onTap: (CompletionHandler handler) async {
                          FirebaseFirestore.instance
                              .collection('sales')
                              .doc(email)
                              .collection('notes')
                              .doc(document.id);
                        },
                        color: Colors.red),
                  ],
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          data['noteText'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data['noteBody'],
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
