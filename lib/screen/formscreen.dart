import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:polio/model/profile.dart';
import 'package:polio/screen/display.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  Profile myStudent = Profile(email: '', fname: '', lname: '', tle: '');
  // firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _studentCollection =
      FirebaseFirestore.instance.collection("students");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Prot Polio"),
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Container(
                            margin: EdgeInsets.only(top: 48),
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 12.0,
                                        child: FloatingActionButton(
                                          backgroundColor: Colors.white,
                                          onPressed: () {},
                                          child: const Icon(
                                            Icons.camera_alt,
                                            size: 35,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    radius: 58.0,
                                    // backgroundImage: NetworkImage()
                                  ),
                                ),
                              )),
                        ]),
                        Text(
                          "ຊື່",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator:
                              RequiredValidator(errorText: "ກະລູນາປ້ອນຊື່ ^^"),
                          onSaved: (String? fname) {
                            myStudent.fname = fname!;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "ນາມສະກຸນ",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "ກະລຸນາປ້ອນນາມສະກຸນ ^^"),
                          onSaved: (String? lname) {
                            myStudent.lname = lname!;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "ອີເມລ",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: MultiValidator([
                            EmailValidator(errorText: "ຮູບແບບອີເມລບໍຖືກ"),
                            RequiredValidator(errorText: "ກະລຸນາປ້ອນອີເມລ^^")
                          ]),
                          onSaved: (String? email) {
                            myStudent.email = email!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "ເບີໂທ",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "ກະລູນາປ້ອນເບີໂທ ^^"),
                          onSaved: (String? score) {
                            myStudent.tle = score!;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              child: Text(
                                "ບັນທຶກ",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await _studentCollection.add({
                                    "fname": myStudent.fname,
                                    "lname": myStudent.lname,
                                    "email": myStudent.email,
                                    "tle": myStudent.tle
                                  });
                                  formKey.currentState!.reset();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DisplayScreen()));
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
