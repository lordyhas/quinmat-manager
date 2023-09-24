import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show DataTableSource, DataRow, DataCell, DataColumn, PaginatedDataTable;
import 'package:qmt_manager/logic/data_test.dart';
import 'package:qmt_manager/logic/model/data_model.dart';
import 'package:qmt_manager/logic/transfer_protocol/http_protocol.dart';
import 'package:qmt_manager/logic/values.dart';
import 'package:qmt_manager/src/add_product/add_product_page.dart';


extension ProductHelper on Product {
  bool get selected => false;
  set selected(bool value){

  }
}


class ProductDataSource extends DataTableSource {
  final List<Product> _products; //= ItemDataTest.products;
  ProductDataSource({required List<Product> products}) : _products = products;

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
          onTap: (){},
          //onDoubleTap: () {},
          onLongPress: () {},
          //showEditIcon: true,

          //placeholder: true,
        ),
        //DataCell(Text(product.model)),
        DataCell(Text("\$${product.price}")),
        DataCell(Text("\$${product.purchasePrice.toString()}")),

        /*DataCell(
          Text(product.productType.name),
          onDoubleTap: () {},
          onLongPress: () {},
        ),*/
        DataCell(Text(product.stockNumber.toString())),
        DataCell(Text(product.threshold.toString())),
        DataCell(Text(product.stockNumber < product.threshold ? "Seuil" : "Aucun")),
        DataCell(
          Text(product.description.isEmpty ? "Aucune" : product.description),
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

class ProductTablePage extends StatefulWidget {
  const ProductTablePage({Key? key}) : super(key: key);

  static const String routeName = '/product-table';

  @override
  State<ProductTablePage> createState() => _DataTableState();
}

class _DataTableState extends State<ProductTablePage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  final BackendServer _httpProduct = const BackendServer("api/products");


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return ScaffoldPage(
      header:  PageHeader(
        title: const Text('Product data tables'),
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
        future: _httpProduct.get(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return const Center(child:  ProgressRing());
          }
          List<Product> products = [];
          for(var json in  snapshot.data!){
            products.add(Product.fromPHPJson(json));
          }
          return ProductTable(products: products);
        }
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ProductTable({required List<Product> products}){

    ProductDataSource productDataSource = ProductDataSource(products: products);

    void sort<T>(Comparable<T> Function(Product d) getField, int columnIndex,
        bool ascending) {
      productDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: PaginatedDataTable(
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
        onSelectAll: productDataSource.selectAll,
        availableRowsPerPage:  <int>[10, 20, products.length],

        columns: <DataColumn>[
          DataColumn(
            label: const Text('Nom'),
            onSort: (int columnIndex, bool ascending) => sort<String>(
                    (Product d) => d.name, columnIndex, ascending),
          ),
          /*DataColumn(
                      label: const Text('Model'),
                      //numeric: true,
                      onSort: (int columnIndex, bool ascending) => _sort<String>(
                              (Product prod) => prod.model, columnIndex, ascending),
                    ),*/
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
    );
  }
}
