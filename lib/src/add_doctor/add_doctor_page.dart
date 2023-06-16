
import 'package:fluent_ui/fluent_ui.dart';
import 'package:qmt_manager/logic/values.dart';

import '../dashboard/doctors/doctor_data_tab.dart';

class AddDoctorDialog extends StatefulWidget {
  //static const routeName = "add-doctor";
  final Doctor? doctor;



  const AddDoctorDialog({this.doctor, Key? key}) : super(key: key);

  @override
  State<AddDoctorDialog> createState() => _AddDoctorDialogState();
}

class _AddDoctorDialogState extends State<AddDoctorDialog> {
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

    return ContentDialog(
      /*
      header: PageHeader(
        leading: const ImageIcon(
          AssetImage("'assets/icon_app.png'"),
          size: 32,
        ),
        title: const Text('Add Doctor'),
      ),
      */
      //backgroundColor: Colors.grey.shade800,
      /*appBar: AppBar(
        leading: const ImageIcon(
          AssetImage("'assets/icon_app.png'"),
          size: 32,
        ),
        title: const Text('Add Doctor'),
      ),*/

      title: const Text('Add Doctor'),
      actions: [
        Button(
          child: const Text('Enregistrer'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState?.save();
              // Process data.
            }
            Navigator.pop(context, 'User saved file');
            // Delete file here
          },
        ),
        FilledButton(
          child: const Text('Annuler'),
          onPressed: () => Navigator.pop(context, 'User canceled dialog'),
        ),
      ],
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        constraints: const BoxConstraints(maxWidth: kTabDimens),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  Container(
                    constraints:
                    isWrapped
                        ? null
                        : const BoxConstraints(maxWidth: kTabDimens*.2),
                    //width: 100,
                    child: ComboboxFormField<String>(
                      items: titles
                          .map((String v) => ComboBoxItem<String>(
                              value: v,
                              child: Text(v),
                            )).toList(),
                      onChanged: (v) {},
                      //onSaved: (value) {},
                      placeholder: const Text("Titre"),

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
                    child: TextFormBox(
                      initialValue: (doctor.isNotEmpty)
                          ? doctor.firstName
                          : null,
                      placeholder: 'Entrer le Prenom *',
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
              const SizedBox(height: 8.0,),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  Container(
                    constraints: isWrapped ? null : const BoxConstraints(maxWidth: kTabDimens*.45),
                    child: TextFormBox(
                      key: const Key("Nom"),
                      initialValue: initialValue(doctor.name),
                      placeholder: 'Entrer le nom *',
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
                    constraints: isWrapped
                        ? null
                        : const BoxConstraints(maxWidth: kTabDimens*.45),
                    child: TextFormBox(
                      initialValue: initialValue(doctor.lastName),
                      placeholder: 'Entrer le Post Nom *',
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
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormBox(
                  initialValue: initialValue(doctor.hospital),
                  placeholder: 'Hopital *',
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
                runSpacing: 8.0,
                children: [
                  Container(
                    constraints: isWrapped ? null : const BoxConstraints(maxWidth: kTabDimens*.45),
                    child: TextFormBox(
                      //initialValue: initialValue(doctor.emails.first),
                      placeholder: 'Enter your email',
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
                    child: ComboboxFormField<ContactLabel>(
                      key: const Key("LabelEmail"),
                      items: contacts.map((v) {
                        return ComboBoxItem(
                          value: v,
                          child: Row(
                            children: <Widget>[
                              const Icon(FluentIcons.edit_contact, size: 20),
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
                      placeholder: const Text('Label'),
                      validator: (v) {
                        if (v == null) return "Label obligatoire*";
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0,),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  Container(
                    constraints: isWrapped ? null : const BoxConstraints(maxWidth: kTabDimens*.45),
                    child: TextFormBox(
                      //key: const Key(""),
                      //initialValue: initialValue(doctor.phoneNumbers.first),
                      placeholder: 'Numéro de Téléphone *',
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
                    child: ComboboxFormField(
                      key: const Key("LabelNumero"),
                      items: contacts.map((v) {
                        return ComboBoxItem(
                          value: v,
                          child: Row(
                            children: <Widget>[
                              const Icon(FluentIcons.edit_contact, size: 20),
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
                      placeholder: const Text('Label'),
                      validator: (v) {
                        if (v == null) return "Label obligatoire*";
                        return null;
                      },
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
