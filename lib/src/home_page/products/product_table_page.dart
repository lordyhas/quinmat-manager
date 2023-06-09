import 'package:flutter/material.dart';
import 'package:qmt_manager/logic/data_test.dart';
import 'package:qmt_manager/logic/model/data_model.dart';
import 'package:qmt_manager/logic/values.dart';
import 'package:qmt_manager/src/add_doctor/add_doctor_page.dart';

// todo ; finish the product table

/*

extension ProductHelper on Product {
  bool get selected => false;
  set selected(bool value){}
}

class ProductDataSource extends DataTableSource {
  final List<Product> _products = ItemDataTest.products;

  void _sort<T>(Comparable<T> Function(Product d) getField, bool ascending) {
    _products.sort((Product a, Product b) {
      if (!ascending) {
        final Product c = a;
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
    if (index >= _products.length) return null;
    final Product product = _products[index];
    return DataRow.byIndex(
      index: index,
      selected: product.selected,
      onSelectChanged: (bool? value) {
        if (product.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          product.selected = value;
          notifyListeners();
        }
      },
      cells: <DataCell>[
        DataCell(
          Text("${product.firstName} "
              "${product.name} ${product.lastName}"),
          onDoubleTap: () {},
          onLongPress: () {},
          //showEditIcon: true,

          //placeholder: true,
        ),
        DataCell(Text(product.sex)),
        DataCell(Text(product.speciality.toString())),
        DataCell(
          Text(product.hospital),
          onDoubleTap: () {},
          onLongPress: () {},
        ),
        DataCell(Text(product.location)),
        DataCell(Text(product.phoneNumbers.first)),
        DataCell(
          Text(product.emails.first),
        ),
        DataCell(Text(product.isDoctor ? "Yes" : "")),
      ],
    );
  }

  @override
  int get rowCount => _products.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool? checked) {
    for (final Product doctor in _products) {
      doctor.selected = checked!;
    }
    _selectedCount = checked! ? _products.length : 0;
    notifyListeners();
  }
}

class ProDataTableDemo extends StatefulWidget {
  const ProDataTableDemo({Key? key}) : super(key: key);

  static const String routeName = '/data-table';

  @override
  State<ProDataTableDemo> createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<ProDataTableDemo> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  final ProductDataSource _doctorsDataSource = ProductDataSource();

  void _sort<T>(Comparable<T> Function(Product d) getField, int columnIndex,
      bool ascending) {
    _doctorsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController =
    ScrollController(debugLabel: 'scrollDoctors');
    return Scaffold(
      appBar: AppBar(
        leading:  Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset("assets/icon_app_red.png", height: 32 ,)
        ), */
/*IconButton(
          icon: const Icon(Icons.close),
          onPressed: Go.of(context).pop,
        ),*//*

        title: const Text('Doctor data tables'),
      ),
      body: Scrollbar(
        controller: scrollController,
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[

            PaginatedDataTable(
              //
              header: const Text('Doctors'),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.wifi_protected_setup,),
                ),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Go.of(context).to(
                        routeName: AddDoctorPage.routeName,
                      );
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
                          (Product d) => d.name, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Sex'),
                  //numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.sex, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Speciality'),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.speciality, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Hospital'),
                  //tooltip: 'Each hospital.',
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.hospital, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Location'),
                  tooltip: 'Hospital location.',
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.location, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Phone'),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.phoneNumbers.first,
                      columnIndex,
                      ascending),
                ),
                DataColumn(
                  label: const Text('Email'),
                  //tooltip: '',
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.emails.first, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Doctor'),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.isDoctor.toString(),
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
}*/
