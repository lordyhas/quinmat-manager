import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show DataTableSource, DataRow, DataCell, DataColumn, PaginatedDataTable;
import 'package:qmt_manager/src/add_doctor/add_doctor_page.dart';
import 'package:qmt_manager/logic/data.csv.dart';

import '../../../logic/transfer_protocol/http_protocol.dart';
import '../../../logic/values.dart';

/*
class _Dessert {
  _Dessert(this.name, this.calories, this.fat, this.carbs, this.protein,
      this.sodium, this.calcium, this.iron);

  final String name;
  final int calories;
  final double fat;
  final int carbs;
  final double protein;
  final int sodium;
  final int calcium;
  final int iron;

  bool? selected = false;
}
*/

enum ContactLabel { mobile, work }

extension ContactLabelHelper on ContactLabel {
  String get name {
    switch (this) {
      case ContactLabel.mobile:
        return "Mobile";
      case ContactLabel.work:
        return "Travail";
    }
  }
}

class Doctor {
  final String? title;
  final String name;
  final String firstName;
  final String lastName;
  final String sex;
  final String hospital;
  final String speciality;
  final String location;
  final bool isDoctor;
  final DateTime lastUpdate;
  final List<String> phoneNumbers;
  final List<String> emails;

  Doctor({
    this.title,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.sex,
    required this.hospital,
    required this.speciality,
    required this.location,
    required this.isDoctor,
    required this.lastUpdate,
    this.phoneNumbers = const <String>[],
    this.emails = const <String>[],
  });

  bool selected = false;

  static Doctor empty = Doctor(
    name: "",
    firstName: "",
    lastName: "",
    sex: "",
    hospital: "",
    speciality: "",
    location: "",
    isDoctor: false,
    lastUpdate: DateTime.now(),
    phoneNumbers : const <String>[],
    emails : const <String>[],
  );


  /// Convenience getter to determine whether the
  /// current [Doctor] is empty.

  bool get isEmpty => this == Doctor.empty;

  /// Convenience getter to determine whether the
  /// current [Doctor] is not empty.
  bool get isNotEmpty => this != Doctor.empty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Doctor &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          sex == other.sex &&
          hospital == other.hospital &&
          location == other.location &&
          isDoctor == other.isDoctor &&
          lastUpdate == other.lastUpdate &&
          phoneNumbers == other.phoneNumbers &&
          emails == other.emails);

  @override
  int get hashCode =>
      name.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      sex.hashCode ^
      hospital.hashCode ^
      location.hashCode ^
      isDoctor.hashCode ^
      lastUpdate.hashCode ^
      phoneNumbers.hashCode ^
      emails.hashCode;

  @override
  String toString() {
    return 'Doctor{'
        ' name: $name,'
        ' firstName: $firstName,'
        ' lastName: $lastName,'
        ' sex: $sex,'
        ' hospital: $hospital,'
        ' location: $location,'
        ' isDoctor: $isDoctor,'
        ' lastUpdate: $lastUpdate,'
        ' phoneNumbers: $phoneNumbers,'
        ' emails: $emails,'
        '}';
  }

  Doctor copyWith({
    String? name,
    String? firstName,
    String? lastName,
    String? sex,
    String? hospital,
    String? speciality,
    String? location,
    bool? isDoctor,
    DateTime? lastUpdate,
    List<String>? phoneNumbers,
    List<String>? emails,
  }) {
    return Doctor(
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      sex: sex ?? this.sex,
      hospital: hospital ?? this.hospital,
      speciality: speciality ?? this.speciality,
      location: location ?? this.location,
      isDoctor: isDoctor ?? this.isDoctor,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      emails: emails ?? this.emails,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'sex': sex,
      'hospital': hospital,
      'location': location,
      'isDoctor': isDoctor,
      'lastUpdate': lastUpdate,
      'phoneNumbers': phoneNumbers,
      'emails': emails,
      'speciality': speciality,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      title: map['title'] as String,
      name: map['name'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      sex: map['sex'] as String,
      hospital: map['hospital'] as String,
      speciality: map['speciality'] as String,
      location: map['location'] as String,
      isDoctor: map['isDoctor'] as bool,
      lastUpdate: map['lastUpdate'] as DateTime,
      phoneNumbers: map['phoneNumbers'] as List<String>,
      emails: map['emails'] as List<String>,
    );
  }

  factory Doctor.fromJsonApi(Map<String, dynamic> data) {
    return Doctor(
      title: (data['title'] ?? "Unknown") as String,
      name: (data['name'] ?? "") as String,
      firstName: (data['firstName'] ?? "") as String,
      lastName: (data['lastName'] ?? "") as String,
      sex: (data['sex'] ?? "S.O") as String,
      hospital: (data['hospital'] ?? "S.O") as String,
      speciality: (data['speciality'] ?? "S.O") as String,
      location: (data['location'] ?? "") as String,
      lastUpdate: DateTime.now(),
      isDoctor : (data["is_doctor"] ?? "no").toString().toLowerCase() == 'yes',
      phoneNumbers: [
        (data['mob_number1'] ?? "") as String,
        (data['mob_number2'] ?? "") as String,
      ],
      emails : [
        (data['email1'] ?? "") as String,
        (data['email2'] ?? "") as String,
      ],
    );
  }
}

class DoctorDataSource extends DataTableSource {

  final List<Map<String, dynamic>> data;


  DoctorDataSource({required this.data});

  List<Doctor> get _doctors => data.map((final Map<String, dynamic> data) =>  Doctor.fromJsonApi(data)).toList();

  void _sort<T>(Comparable<T> Function(Doctor d) getField, bool ascending) {
    _doctors.sort((Doctor a, Doctor b) {
      if (!ascending) {
        final Doctor c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _doctors.length) return null;
    final Doctor doctor = _doctors[index];
    return DataRow.byIndex(
      index: index,
      selected: doctor.selected,
      onSelectChanged: (bool? value) {
        if (doctor.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          doctor.selected = value;
          notifyListeners();
        }
      },
      cells: <DataCell>[
        DataCell(
          Text("${doctor.firstName} "
              "${doctor.name} ${doctor.lastName}"),
          onDoubleTap: () {},
          onLongPress: () {},
          //showEditIcon: true,

          //placeholder: true,
        ),
        DataCell(Text(doctor.sex)),
        DataCell(Text(doctor.speciality.toString())),
        DataCell(
          Text(doctor.hospital),
          onDoubleTap: () {},
          onLongPress: () {},
        ),
        DataCell(Text(doctor.location)),
        DataCell(Text(doctor.phoneNumbers.first)),
        DataCell(
          Text(doctor.emails.first),
        ),
        DataCell(Text(doctor.isDoctor ? "Yes" : "")),
      ],
    );
  }

  @override
  int get rowCount => _doctors.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool? checked) {
    for (final Doctor doctor in _doctors) {
      doctor.selected = checked!;
    }
    _selectedCount = checked! ? _doctors.length : 0;
    notifyListeners();
  }
}

class DoctorDataTableScreen extends StatefulWidget {
  const DoctorDataTableScreen({Key? key}) : super(key: key);

  static const String routeName = '/data-table';

  @override
  State<DoctorDataTableScreen> createState() => _DoctorDataTableScreenState();
}

class _DoctorDataTableScreenState extends State<DoctorDataTableScreen> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  late final DoctorDataSource _doctorsDataSource;// = DoctorDataSource();

  TransferProtocol http = const TransferProtocol("https://exploress.space/api/doctor-sample/csv");


  void loadData() async {
    _doctorsDataSource = DoctorDataSource(
      data: doctorData,
      //data: await http.get(),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void _sort<T>(Comparable<T> Function(Doctor d) getField, int columnIndex,
      bool ascending) {
    _doctorsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  void showContentDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Delete file permanently?'),
        //content: const AddDoctorPage(),
        actions: [
          Button(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.pop(context, 'User deleted file');
              // Delete file here
            },
          ),
          FilledButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    /*final ScrollController scrollController = ScrollController(
      debugLabel: 'scrollDoctors',
    );*/

    return ScaffoldPage(
      header:  PageHeader(
        title: const Text('Doctor data tables'),
        commandBar: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          child: CommandBarCard(
            child: CommandBar(
              //overflowBehavior: CommandBarOverflowBehavior.,
              isCompact: true,
              primaryItems: [
                CommandBarBuilderItem(
                  builder: (context, mode, child) => Tooltip(
                    message: "Refresh data, to get last update",
                    child: child,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.refresh),
                    label: const Text('Refresh'),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),

                CommandBarButton(
                  icon: const Icon(FluentIcons.archive),
                  label: const Text('Archive'),
                  onPressed: () {},
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.move),
                  label: const Text('Move'),
                  onPressed: () {},
                ),
                const CommandBarSeparator(),
                CommandBarButton(
                  icon: const Icon(FluentIcons.search),
                  label: const Text('Search'),
                  onPressed: () {},
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.reply),
                  label: const Text('Go back'),
                  onPressed: () {},
                ),
                CommandBarBuilderItem(
                  builder: (context, mode, child) => Tooltip(
                    message: "Bloqué tous modif sur cette instance",
                    child: child,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.blocked12),
                    label: const Text('Blocked'),
                    onPressed: () {},
                  ),
                ),
                CommandBarBuilderItem(
                  builder: (context, mode, child) => Tooltip(
                    message: "Signaler un problème dans les données",
                    child: child,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.report_warning),
                    label: const Text('Signaler'),
                    onPressed: () {},
                  ),
                ),
                CommandBarBuilderItem(
                  builder: (context, mode, child) => Tooltip(
                    message: "Ajouter à la liste signet",
                    child: child,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.single_bookmark),
                    label: const Text('Bookmark'),
                    onPressed: () {},
                  ),
                ),
                CommandBarBuilderItem(
                  builder: (context, mode, child) => Tooltip(
                    message: "Marker à faire plus tart",
                    child: child,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.add_event),
                    label: const Text('À faire'),
                    onPressed: () {},
                  ),
                ),

                const CommandBarSeparator(),

                CommandBarBuilderItem(
                  builder: (context, mode, child) => Tooltip(
                    message: "Assigner une tache a un collègue",
                    child: child,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.add_event),
                    label: const Text('Assignee'),
                    onPressed: () {},
                  ),
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.hide3),
                  label: const Text('Cacher'),
                  onPressed: (){

                  },
                ),
                const CommandBarButton(
                  icon: Icon(FluentIcons.cancel),
                  label: Text('Disabled'),
                  onPressed: null,
                ),



              ],
              secondaryItems: const [],
            ),
          ),
        ),
      ),

      content: FutureBuilder<List<Map<String, dynamic>>>(
        future: http.get(), //as List<Map<String, String>>,
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return const Center(child:  ProgressRing());
          }



          return SingleChildScrollView(

            //controller: scrollController,
            padding: const EdgeInsets.all(20.0),
            child:  PaginatedDataTable(
              header: const Text('Doctors'),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(FluentIcons.delete)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FluentIcons.o_d_link,),
                ),
                IconButton(
                    icon: const Icon(FluentIcons.add),
                    onPressed: () async {
                      //showContentDialog(context);
                      final result = await showDialog<String>(
                        context: context,
                        builder: (context) => const AddDoctorDialog(),
                      );
                      /*Go.of(context).to(
                        routeName: AddDoctorPage.routeName,
                      );*/
                    }
                ),
              ],
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (int? value) {
                setState(() {
                  _rowsPerPage = value!;
                });
              },
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              onSelectAll: _doctorsDataSource.selectAll,
              availableRowsPerPage: const <int>[10,20,40,60],

              columns: <DataColumn>[
                DataColumn(
                  label: const Text('Nom Complet'),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Doctor d) => d.name, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Sex'),
                  //numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Doctor d) => d.sex, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Speciality'),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Doctor d) => d.speciality, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Hospital'),
                  //tooltip: 'Each hospital.',
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Doctor d) => d.hospital, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Location'),
                  tooltip: 'Hospital location.',
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Doctor d) => d.location, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Phone'),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Doctor d) => d.phoneNumbers.first,
                      columnIndex,
                      ascending),
                ),
                DataColumn(
                  label: const Text('Email'),
                  //tooltip: '',
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Doctor d) => d.emails.first, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Doctor'),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Doctor d) => d.isDoctor.toString(),
                      columnIndex,
                      ascending),
                ),
              ],
              source: _doctorsDataSource,
            ),
          );
        }
      ),
    );
  }
}
