import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show DataTableSource, DataRow, DataCell, DataColumn, PaginatedDataTable;
import 'package:qmt_manager/logic/data_test.dart';
import 'package:qmt_manager/logic/model/data_model.dart';
import 'package:qmt_manager/logic/values.dart';
import 'package:qmt_manager/src/add_product/add_product_page.dart';


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
          Text("${product.name} "),
          onDoubleTap: () {},
          onLongPress: () {},
          //showEditIcon: true,

          //placeholder: true,
        ),
        DataCell(Text(product.model)),
        DataCell(Text("\$${product.price}")),
        DataCell(
          Text(product.productType.name),
          onDoubleTap: () {},
          onLongPress: () {},
        ),
        DataCell(Text(product.stockNumber.toString())),
        DataCell(Text(product.promotionPrice.toString())),
        DataCell(
          Text(product.description),
        ),
        DataCell(Text(product.isTendency ?? false ? "Oui" : "")),
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

class ProductTablePage extends StatefulWidget {
  const ProductTablePage({Key? key}) : super(key: key);

  static const String routeName = '/product-table';

  @override
  State<ProductTablePage> createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<ProductTablePage> {
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
    return ScaffoldPage(
      /*appBar: AppBar(
        leading:  Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset("assets/icon_app_red.png", height: 32 ,)
        ),

        title: const Text('Doctor data tables'),
      ),*/
      content: Scrollbar(
        controller: scrollController,
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[

            PaginatedDataTable(
              //
              header: const Text('Produits'),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(FluentIcons.delete)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FluentIcons.refresh,),
                ),
                IconButton(
                    icon: const Icon(FluentIcons.add),
                    onPressed: () {
                      Go.of(context).to(
                        routeName: AddProductPage.routeName,
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
              availableRowsPerPage:  <int>[10, ItemDataTest.products.length],

              columns: <DataColumn>[
                DataColumn(
                  label: const Text('Nom'),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.name, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Model'),
                  //numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product prod) => prod.model, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Prix'),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.price.toString(), columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Departement'),
                  //tooltip: 'Each hospital.',
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.productType.name, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Stock'),
                  tooltip: 'Hospital location.',
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.stockNumber.toString(), columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Prix Promotionnel'),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.promotionPrice.toString(),
                      columnIndex,
                      ascending),
                ),
                DataColumn(
                  label: const Text('Description'),
                  //tooltip: '',
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.description, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Tendance?'),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Product d) => d.isTendency.toString(),
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
