part of products;

class ProductListView extends StatefulWidget {
  //final heroTag;
  const ProductListView({
    required this.items, //this.heroTag,
    //required this.animationController,
    //required this.animation,
    required this.onShopClick,
    required this.onLikeClick,
    this.onHueClick,
    super.key,
  });

  final Function(int index) onShopClick;
  final Function(int index)? onHueClick;
  final Function(int index) onLikeClick;
  final List<ItemData> items;
  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  //final AnimationController animationController;


  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    double responsiveSize() {
      double screenWidth = MediaQuery.of(context).size.width;
      //if(screenWidth > 1280) return 500;
      if (screenWidth > 1280 && screenWidth < 1400) {
        return 500;
      } else if (screenWidth >= 1400 && screenWidth < 1650) {
        return 600;
      } else if (screenWidth >= 1650) {
        return 720;
      } else if (screenWidth < 1280 && screenWidth >= 1120) {
        return 460;
      } else if (screenWidth < 1120) {
        return 700;
      }

      return 700;
    }

    final textStyle = TextStyle(
        fontSize: 14,
        //color: Colors.grey,
    );

    return Container(
      color: Colors.transparent,
      child: Wrap(
          spacing: 8.0,
          alignment: WrapAlignment.center,
          children: List.generate(
            widget.items.length,
            (index) => Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 8,
                bottom: 16,
              ),
              child: GestureDetector(
                //splashColor: Colors.transparent,
                onTap: () => widget.onShopClick(index),
                onLongPress: () {},
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 330, //responsiveSize(),
                  ),
                  /*decoration: BoxDecoration(
                  //borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  //border: Border.all(color: Colors.black)
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      offset: const Offset(4, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),*/
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.asset(
                                widget.items[index].imagePath,
                                fit: BoxFit.cover,
                                gaplessPlayback: true,
                              ),
                            ),

                            /// Bottom bar of Card
                            Container(
                              color: Colors.grey[140], //FluentTheme.of(context).cardColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, top: 8, bottom: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            widget.items[index].name,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                widget.items[index].department,
                                                style: textStyle,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Icon(
                                                FontAwesomeIcons.locationDot,
                                                size: 12,
                                                color: FluentTheme.of(context).activeColor,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: textStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              StarRating(
                                                allowHalfRating: true,
                                                starCount: 5,
                                                rating: widget.items[index].ratings / widget.items[index].raters,
                                                size: 20,
                                              ),
                                              Text(
                                                ' ${widget.items[index].ratings} Reviews',
                                                style: textStyle,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 4),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () => widget.onHueClick!(index),
                                          icon: Icon(
                                            CupertinoIcons.arrow_2_circlepath,
                                            size: 32,
                                            color: FluentTheme.of(context).activeColor,
                                          ),
                                        ),
                                        Text(
                                          '',
                                          style: textStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        /// Like Position Clicker Widget
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            /*borderRadius: const BorderRadius.all(
                              Radius.circular(32.0),
                            ),*/
                            onTap: () {
                              widget.onLikeClick(index);
                              setState(() {
                                isLiked = !isLiked;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                (isLiked)? FluentIcons.heart_fill : FluentIcons.heart,
                                color: (isLiked)? Colors.orange.dark : null,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
