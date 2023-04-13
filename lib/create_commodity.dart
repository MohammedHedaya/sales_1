import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateCommodity extends StatefulWidget {
  const CreateCommodity({Key? key}) : super(key: key);

  @override
  State<CreateCommodity> createState() => _CreateCommodityState();
}

class _CreateCommodityState extends State<CreateCommodity> {
  TextEditingController noteName = TextEditingController();
  TextEditingController bodyText = TextEditingController();
  TextEditingController dataTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        title: const Text('اضافه تاجر جديد'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: noteName,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                hintText: 'اسم التاجر',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: bodyText,
              maxLines: 10,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                hintText: 'اضــف معلومات التاجر',
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 380,
              height: 45,
              color: Colors.pink,
              child: MaterialButton(
                onPressed: () {
                  String? email = FirebaseAuth.instance.currentUser!.email;
                  users.doc(email).collection('sales').add({
                    'noteText': noteName.text,
                    'noteBody': bodyText.text,
                  }).then((value) => {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('تم اضافه المعلومات'),
                          duration: Duration(seconds: 2),
                        )),
                      });
                },
                child: const Center(
                  child: Text(
                    'حفظ المعلومات',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
