part of products.adder;

class RentForm extends StatelessWidget {

  final void Function(bool)? onValidForm;
  final void Function(Product)? onComplete;
  final GlobalKey<FormState> validator;
  final List<TextEditingController> controllers;

  //final Map<String,TextEditingController> spaceController;
  final Map<String,TextEditingController> productController;

  const RentForm({
    required this.validator,
    required this.controllers,
    //required this.spaceController,
    required this.productController,
    this.onValidForm,
    this.onComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //RentalSpace space = context.read<RentalControllerBloc>().state.space;
    var bloc = BlocProvider.of<ProductControllerBloc>(context);
    Product product = bloc.state.product;

    //context.read<RentalControllerBloc>().

    product.copyWith(productType: ProductType.QCL);


    return Container(
      constraints: const BoxConstraints(maxWidth: 520),
      child: Column(
        children: [
          //const SizedBox(height: 72.0,),
          //const SizedBox(height: 16.0,),
          const SizedBox(
            height: 8.0,
          ),

          BlocBuilder<ProductControllerBloc, ProductControllerState>(
            builder: (_, state) {
              return Form(
                key: validator,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Text("Enregistrer un produit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: InfoLabel(
                        label: 'Nom *',
                        child: TextFormBox(
                          cursorColor: FluentTheme.of(context).accentColor,
                          controller: productController['name'],
                          textCapitalization: TextCapitalization.words,
                          //textCapitalization: TextCapitalization.words,
                          placeholder:"Entrez le nom du produit",
                          decoration: BoxDecoration(
                            //focusColor: Theme.of(context).primaryColor,
                            //border: const UnderlineInputBorder(),
                            //filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            //hintText: 'Entrez le nom du produit',
                            //labelText: 'Nom *',
                          ),
                          onEditingComplete: (){
                            //print("onEditingComplete: Mark[${controllers[0].text}]");
                          },
                          onChanged: (str) {},
                          onSaved: (String? value) {
                            product = product.copyWith(model: value);
                          },
                          validator: (v) {
                            if (v!.length < 3) return 'Modèle est requis.';
                            return null;
                          },
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: InfoLabel(
                        label:"Modèle *",
                        child: TextFormBox(
                          //cursorColor: Theme.of(context).primaryColor,
                          controller: productController['mark'],
                          textCapitalization: TextCapitalization.words,
                          placeholder:"Entrez le modèle",
                          /*decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: '',
                            labelText: '',
                          ),*/
                          onEditingComplete: (){
                            //print("onEditingComplete: Mark[${controllers[0].text}]");
                          },
                          onChanged: (str) {},
                          onSaved: (String? value) {
                            product = product.copyWith(model: value);
                          },
                          validator: (v) {
                            if (v!.length < 3) return 'Modèle est requis.';
                            return null;
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: InfoLabel(
                        label: "Description *",
                        child: TextFormBox(
                          controller: productController['description'],
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 4,
                          placeholder:"Décriver le produit?",
                          /*decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: '',
                            labelText: '',
                          ),*/
                          onEditingComplete: (){
                            //print("onEditingComplete: Description[${controllers[1].text}}]");
                          },
                          onSaved: (String? value) {
                            product = product.copyWith(description: value);
                          },
                          validator: (v) {
                            if (v!.isEmpty) return 'Détails est requis.';
                            return null;
                          },
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: InfoLabel(
                        label: "Prix (en ${state.product.pricePer.name}) *",
                        child: TextFormBox(
                          controller: productController['price'],
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.number,
                          placeholder:"prix en dollar américain ?",
                          /*decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: '',
                            labelText: 'Prix (en ${state..product.pricePer.name}) *',
                          ),*/
                          onEditingComplete: (){},
                          onSaved: (value) {
                            int v = value!.toInt().abs();
                            if(v == 0) v = 1;
                            product = product.copyWith(price: v);
                          },
                          validator: (v) {
                            if (v!.isEmpty) return 'Prix est requis.';
                            if(v.isNumeric) return 'Prix doit être un nombre.';
                            return null;
                          },
                        ),
                      ),
                    ),
                    _RadioButtonGroup(
                      onSelected: (PriceCurrency value) {
                        product = product.copyWith(pricePer: value);
                        context.read<ProductControllerBloc>().addProductPassed(product);
                      },
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: InfoLabel(
                        label:"Stock",
                        child: TextFormBox(
                          controller: productController['seat'],
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.number,
                          placeholder:"Combien des produits en stock ?",
                          /*decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: '',
                            labelText: '',
                          ),*/
                          onSaved: (String? value) {
                            int v = value!.toInt().abs();
                            if(v == 0) v = 1;
                            product = product.copyWith(stockNumber: v);
                          },
                          validator: (v) {
                            if (v!.isEmpty) return 'Nombre des produits en stock est requis.';
                            return null;
                          },
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: InfoLabel(
                        label : "Catégorie",
                        child: TextFormBox(
                          controller: productController['cat'],
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.text,
                          placeholder: "Catégorie du produit ?",
                          /*decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: 'Catégorie du produit ?',
                            labelText: '',
                          ),*/
                          onSaved: (String? value) {},
                          validator: (v) {
                            // if (v!.isEmpty) return
                            // 'Nombre de siege est requis.';
                            if (v!.isEmpty) return 'Catégorie est requis.';
                            return null;
                          },
                        ),
                      ),
                    ),

                    //BlocBuilder<RentalControllerBloc, RentalControllerState>(
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        children: [
                          InfoLabel(
                            label: "Departement *",
                            child: ComboBox<ProductType>(
                              placeholder: Text("Spécifier le departement"),
                              value: context.read<ProductControllerBloc>().state.product.productType,
                              //controller: controllers[5],
                              items: Product.departments.map((v) {
                                return ComboBoxItem(
                                    value: v,
                                    child: Row(
                                      children: <Widget>[
                                        const Icon(FluentIcons.tag, size: 20),
                                        const SizedBox(width: 8.0,),
                                        Text("DEP ${v.name}"),
                                      ],
                                    ));
                              }).toList(),
                              onChanged: (v){
                                context.read<ProductControllerBloc>().refreshProduct(
                                    product.copyWith(productType: v)
                                );
                              },
                              /*onSaved: (value) {
                                vehicle = vehicle.copyWith(productType: value);
                                context.read<RentalControllerBloc>().addVehicleRentalPassed(vehicle);
                              },
                              decoration: InputDecoration(
                                focusColor: Theme.of(context).primaryColor,
                                border: const UnderlineInputBorder(),
                                filled: true,
                                //icon: const Icon(Icons.bookmark_border),
                                hintText: 'Spécifier le departement?',
                                labelText: '',
                              ),
                              validator: (v) {
                                if(v == null) return "Chosir un departement (obligatoire)";
                                return null;
                              },*/
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          ),

          /// Entry's information product

          const Column(
            children: [],
          ),
        ],
      ),
    );
  }
}



class _RadioButtonGroup extends StatefulWidget {
  final Function(PriceCurrency value) onSelected;
  const _RadioButtonGroup({required this.onSelected,});

  static const List<PriceCurrency> labels = [PriceCurrency.USD, PriceCurrency.CDF];

  @override
  State<_RadioButtonGroup> createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<_RadioButtonGroup> {
  PriceCurrency? _character = PriceCurrency.CDF;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 42.0),
      child: Wrap(
        children: <Widget>[

          for (PriceCurrency currency in _RadioButtonGroup.labels)
          _RadioItem(
            title: Text(currency.name),
            leading: Radio<PriceCurrency>(
              value: currency,
              groupValue: _character,
              onChanged: (PriceCurrency? value) {
                setState(() {_character = value;});
                widget.onSelected(value ??  PriceCurrency.CDF);
              },
            ),
          ),

        ],
      ),
    );
  }
}


class _RadioItem extends StatelessWidget {
  final Widget leading;
  final Widget title;
  const _RadioItem({required this.leading, required this.title, Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        children: [
          leading,
          title,
        ],
      ),
    );
  }
}



