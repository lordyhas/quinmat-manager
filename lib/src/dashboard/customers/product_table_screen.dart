import 'package:flutter/material.dart';
import 'package:qmt_manager/logic/values.dart';
import '../../../logic/model/data_model.dart';
import '../../add_product/add_product_page.dart';


extension ProductHelper on Product {
  bool get selected => false;
  set selected(bool value){

  }
}


class ProductDataSource extends DataTableSource {
  List<Product> _products; //= ItemDataTest.products;
  ProductDataSource({required List<Product> products}) : _products = products;

  void sort<T>(Comparable<T> Function(Product d) getField, bool ascending) {
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
        DataCell(Text("${product.id} "),),
        DataCell(
          Text("${product.name} "),
          onTap: (){},
          //onDoubleTap: () {},
          onLongPress: () {},
          //showEditIcon: true,

          //placeholder: true,
        ),
        //DataCell(Text(product.model)),
        DataCell(Text("\$${product.price}")),
        DataCell(Text("\$${product.purchasePrice.toString()}")),
        DataCell(Text(product.stockNumber.toString())),
        DataCell(Text(product.threshold.toString())),
        DataCell(
          showEditIcon: product.stockNumber < product.threshold,
          Text(product.stockNumber < product.threshold ? "Seuil" : "Aucun"),
        ),
        DataCell(
          Text(product.description.length > 42
              ? "${product.description.substring(0,42)}..."
              : product.description,
          ),
        ),
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

class ProductTableScreen extends StatefulWidget {
  final List<Product> products;
  const ProductTableScreen({required this.products ,super.key});

  @override
  State<ProductTableScreen> createState() => _ProductTableScreenState();
}

class _ProductTableScreenState extends State<ProductTableScreen> {

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  bool _sortAscending = true;


  @override
  Widget build(BuildContext context) {
    ProductDataSource productDataSource = ProductDataSource(products: widget.products);

    void sort<T>(Comparable<T> Function(Product d) getField, int columnIndex,
        bool ascending) {
      productDataSource.sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child:PaginatedDataTable(
            header: const Text('Produits'),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.refresh,),
              ),
              IconButton(
                  icon: const Icon(Icons.add),
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
            onSelectAll: productDataSource.selectAll,
            availableRowsPerPage:  <int>[10, 20, widget.products.length],

            columns: <DataColumn>[
              DataColumn(
                label: const Text('ID'),
                onSort: (int columnIndex, bool ascending) => sort<String>(
                        (Product d) => d.id, columnIndex, ascending),
              ),
              DataColumn(
                label: const Text('Nom'),
                onSort: (int columnIndex, bool ascending) => sort<String>(
                        (Product d) => d.name, columnIndex, ascending),
              ),

              DataColumn(
                //numeric: true,
                label: const Text('Prix de ventes'),
                onSort: (int columnIndex, bool ascending) => sort<String>(
                        (Product d) => d.price.toString(), columnIndex, ascending),
              ),
              DataColumn(
                //numeric: true,
                label: const Text('Prix d\'achat'),
                onSort: (int columnIndex, bool ascending) => sort<String>(
                        (Product d) => d.purchasePrice.toString(),
                    columnIndex,
                    ascending),
              ),
              /*DataColumn(
                        label: const Text('Departement'),
                        //tooltip: 'Each hospital.',
                        onSort: (int columnIndex, bool ascending) => _sort<String>(
                                (Product d) => d.productType.name, columnIndex, ascending),
                      ),*/
              DataColumn(
                //numeric: true,
                label: const Text('Stock'),
                onSort: (int columnIndex, bool ascending) => sort<String>(
                        (Product d) => d.stockNumber.toString(), columnIndex, ascending),
              ),
              DataColumn(
                //numeric: true,
                label: const Text('Seuil'),
                tooltip: 'Seuil à ne pas depasser',
                onSort: (int columnIndex, bool ascending) => sort<String>(
                        (Product d) => d.threshold.toString(), columnIndex, ascending),
              ),
              DataColumn(
                label: const Text('Alert!'),
                onSort: (int columnIndex, bool ascending) => sort<String>(
                        (Product d) => d.isTendency.toString(),
                    columnIndex,
                    ascending),
              ),
              DataColumn(
                label: const Text('Description'),
                //tooltip: '',
                onSort: (int columnIndex, bool ascending) => sort<String>(
                        (Product d) => d.description, columnIndex, ascending),
              ),

            ],
            source: productDataSource,
          ),
      ),
    );
  }
}
