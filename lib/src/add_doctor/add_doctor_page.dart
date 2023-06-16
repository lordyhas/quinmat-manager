import 'package:flutter/material.dart';
import 'package:qmt_manager/logic/values.dart';

import '../dashboard/doctors/doctor_data_tab.dart';

class AddDoctorPage extends StatefulWidget {
  static const routeName = "add-doctor";
  final Doctor? doctor;

  const AddDoctorPage({this.doctor, Key? key}) : super(key: key);

  @override
  State<AddDoctorPage> createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<ContactLabel> contacts = [
    ContactLabel.mobile,
    ContactLabel.work
  ];

  late final Doctor doctor;

  @override
  void initState() {
    doctor = widget.doctor ?? Doctor.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titles = <String>[
      "Monsieur",
      "Docteur",
      "Reverend",
    ];

    String? initialValue(String value) {
      return (doctor.isNotEmpty) ? value : null;
    }

    bool isWrapped = MediaQuery.of(context).size.width < 718;

    return Scaffold(
      /*
      header: PageHeader(
        leading: const ImageIcon(
          AssetImage("'assets/icon_app.png'"),
          size: 32,
        ),
        title: const Text('Add Doctor'),
      ),
      */
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        leading: const ImageIcon(
          AssetImage("'assets/icon_app.png'"),
          size: 32,
        ),
        title: const Text('Add Doctor'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        constraints: const BoxConstraints(maxWidth: kTabDimens),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                spacing: 8.0,
                children: [
                  Container(
                    constraints:
                    isWrapped
                        ? null
                        : const BoxConstraints(maxWidth: kTabDimens*.2),
                    //width: 100,
                    child: DropdownButtonFormField<String>(
                      items: titles
                          .map((String v) => DropdownMenuItem<String>(
                              value: v,
                              child: Text(v),
                            )).toList(),
                      onChanged: (v) {},
                      //onSaved: (value) {},
                      decoration: const InputDecoration(
                        hintText: 'Titre',
                      ),
                      validator: (v) {
                        if (v == null) return "Titre obligatoire*";
                        return null;
                      },
                    ),
                  ),

                  Container(
                    constraints: isWrapped
                        ? null
                        : const BoxConstraints(maxWidth: kTabDimens*.7),
                    //width:  100,
                    child: TextFormField(
                      initialValue: (doctor.isNotEmpty)
                          ? doctor.firstName
                          : null,
                      decoration: const InputDecoration(
                        hintText: 'Entrer le Prenom *',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Post Nom obligatoire';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              Wrap(
                spacing: 8.0,
                children: [
                  Container(
                    constraints: isWrapped ? null : const BoxConstraints(maxWidth: kTabDimens*.45),
                    child: TextFormField(
                      key: const Key("Nom"),
                      initialValue: initialValue(doctor.name),
                      decoration: const InputDecoration(
                        hintText: 'Entrer le nom *',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Nom obligatoire';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        doctor.copyWith(name: value);
                      },
                    ),
                  ),
                  Container(
                    constraints: isWrapped ? null : const BoxConstraints(maxWidth: kTabDimens*.45),
                    child: TextFormField(
                      initialValue: initialValue(doctor.lastName),
                      decoration: const InputDecoration(
                        hintText: 'Entrer le Post Nom *',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Post Nom obligatoire';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              Container(
                child: TextFormField(
                  initialValue: initialValue(doctor.hospital),
                  decoration: const InputDecoration(
                    hintText: 'Hopital *',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Hopital obligatoire';
                    }
                    return null;
                  },
                ),
              ),
              Wrap(
                spacing: 8.0,
                children: [
                  Container(
                    constraints: isWrapped ? null : const BoxConstraints(maxWidth: kTabDimens*.45),
                    child: TextFormField(
                      //initialValue: initialValue(doctor.emails.first),
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    constraints: isWrapped ? null : const BoxConstraints(maxWidth: kTabDimens*.45),
                    child: DropdownButtonFormField<ContactLabel>(
                      key: const Key("LabelEmail"),
                      items: contacts.map((v) {
                        return DropdownMenuItem(
                          value: v,
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.co_present_outlined, size: 20),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(v.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {},
                      //onSaved: (value) {},
                      decoration: const InputDecoration(
                        hintText: 'Label',
                      ),
                      validator: (v) {
                        if (v == null) return "Label obligatoire*";
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Wrap(
                children: [
                  Container(
                    constraints: isWrapped ? null : const BoxConstraints(maxWidth: kTabDimens*.45),
                    child: TextFormField(
                      //key: const Key(""),
                      //initialValue: initialValue(doctor.phoneNumbers.first),
                      decoration: const InputDecoration(
                        hintText: 'Numéro de Téléphone *',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Numéro de Téléphone obligatoire';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    constraints: isWrapped ? null : const BoxConstraints(maxWidth: kTabDimens*.45),
                    child: DropdownButtonFormField(
                      key: const Key("LabelNumero"),
                      items: contacts.map((v) {
                        return DropdownMenuItem(
                          value: v,
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.co_present_outlined, size: 20),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(v.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {},
                      //onSaved: (value) {},
                      decoration: const InputDecoration(
                        hintText: 'Label',
                      ),
                      validator: (v) {
                        if (v == null) return "Label obligatoire*";
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          //_formKey.currentState?.save();
                          // Process data.
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Text('Enregistrer'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
