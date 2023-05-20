import 'package:flutter/material.dart';
import 'package:qmt_manager/src/add_doctor/data.csv.dart';

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
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
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
}

class DoctorDataSource extends DataTableSource {
  final List<Doctor> _doctors = doctorData
      .map((final Map<String, String> data) => Doctor(
            title: data["TITLE"],
            name: data["NAME"] as String,
            firstName: data["FIRST_NAME"] as String,
            lastName: data["LAST_NAME"] as String,
            sex: data["SEXE"] as String,
            hospital: data["HOSPITAL"] as String,
            speciality: data["SPECIALITY"] as String,
            location: data["LOCATION"] as String,
            isDoctor: data["SPECIALITY"].toString().toLowerCase() == 'yes',
            lastUpdate: DateTime.now(),
            phoneNumbers: [
              data["MOB_NUMBER1"] as String,
              data["MOB_NUMBER2"] as String,
            ],
            emails: [
              data["EMAIL1"] as String,
              data["EMAIL2"] as String,
            ],
          ))
      .toList();

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
          Text("${doctor.title} ${doctor.firstName} "
              "${doctor.name} ${doctor.lastName}"),
          onDoubleTap: () {},
          onLongPress: () {},
          showEditIcon: true,

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
        DataCell(Text(doctor.emails.first),),
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

class DataTableDemo extends StatefulWidget {
  const DataTableDemo({Key? key}) : super(key: key);

  static const String routeName = '/data-table';

  @override
  State<DataTableDemo> createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  int? _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  final DoctorDataSource _doctorsDataSource = DoctorDataSource();

  void _sort<T>(Comparable<T> Function(Doctor d) getField, int columnIndex,
      bool ascending) {
    _doctorsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController(debugLabel: 'scrollDoctors');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data tables'),
        actions: const <Widget>[
          //MaterialDemoDocumentationButton(DataTableDemo.routeName),
        ],
      ),
      body: Scrollbar(
        controller: scrollController,
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            PaginatedDataTable(
              //controller: scrollController,
              actions: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.wifi_protected_setup)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.send)),

              ],
              header: const Text('Doctors'),
              rowsPerPage: _rowsPerPage!,
              onRowsPerPageChanged: (int? value) {
                setState(() {
                  _rowsPerPage = value;
                });
              },
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              onSelectAll: _doctorsDataSource.selectAll,
              columns: <DataColumn>[
                DataColumn(
                  label: const Text('Name'),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                      (Doctor d) => d.name, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Sex'),

                  numeric: true,
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
          ],
        ),
      ),
    );
  }
}
