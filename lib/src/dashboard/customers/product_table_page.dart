import 'package:fluent_ui/fluent_ui.dart';
import 'package:qmt_manager/logic/model/data_model.dart';
import 'package:qmt_manager/logic/transfer_protocol/http_protocol.dart';
import 'package:qmt_manager/src/dashboard/customers/product_table_screen.dart';



class ProductTablePage extends StatefulWidget {
  const ProductTablePage({Key? key}) : super(key: key);

  static const String routeName = '/product-table';

  @override
  State<ProductTablePage> createState() => _DataTableState();
}

class _DataTableState extends State<ProductTablePage> {


  final BackendServer _httpProduct = const BackendServer("/products");


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return ScaffoldPage(
      header:  PageHeader(
        title: const Text('Product tables'),
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
          return ProductTableScreen(products: products);
        }
      ),
    );
  }

}
