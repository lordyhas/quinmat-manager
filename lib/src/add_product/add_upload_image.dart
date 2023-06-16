part of products.adder;

class UploadImage extends StatefulWidget {
  final void Function(CroppedFile? file) onUploaded;
  const UploadImage({required this.onUploaded, super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  CroppedFile? _croppedFile;

  WebUiSettings get _webUISet => WebUiSettings(
    context: context,
    presentStyle: CropperPresentStyle.dialog,
    boundary: const CroppieBoundary(width: 520, height: 520,),
    viewPort: const CroppieViewPort(width: 480, height: 480,),
    enableExif: true,
    enableZoom: true,
    showZoomer: true,
  );

  Future<void> _uploadImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery
    );

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        maxHeight: 800,
        maxWidth: 800,
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 80,
        aspectRatio: const CropAspectRatio(ratioX: 100, ratioY: 100),
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Recadrage Image',
              toolbarColor: Colors.purple,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Recadrage Image',
          ),
          _webUISet,

        ],
      );

      setState(() {
        _croppedFile = croppedFile;
        widget.onUploaded(_croppedFile);
      });
      /*Future.delayed(
          const Duration(seconds: 1), () => widget.onUploaded(_croppedFile),
      );*/

    }
  }

  void clear() {
    setState(() {
      _croppedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      child: Card(
        borderRadius: BorderRadius.circular(16.0),
        child: SizedBox(
          width: !Responsive.of(context).isPhone ? 380.0 : 320.0,
          height: !Responsive.of(context).isPhone ? 420.0 : 380.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 320,
                width: 320,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BooleanBuilder(
                    condition: () => _croppedFile != null,
                    ifTrue: Container(
                      constraints: BoxConstraints(
                        maxWidth: 0.8 * screenWidth,
                        maxHeight: 0.7 * screenHeight,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Responsive.of(context).isOnlyWeb
                            ? (_croppedFile.isNull)? null : Image.network(_croppedFile!.path)
                            : (_croppedFile.isNull)? null : Image.file(File(_croppedFile!.path)),
                      ),
                    ),
                    ifFalse: DottedBorder(
                      radius: const Radius.circular(4.0),
                      borderType: BorderType.RRect,
                      dashPattern: const [8, 4],
                      color: Colors.white, //FluentTheme.of(context).highlightColor.withOpacity(0.4),
                      child: const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FluentIcons.photo2_add,
                              //color: Theme.of(context).highlightColor,
                              size: 80.0,
                            ),
                            SizedBox(height: 24.0),
                            Text(
                              'Upload an image to start',
                              //style: Responsive.of(context).isOnlyWeb,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ButtonBar(
                    children: [
                      Button(
                        style: ButtonStyle(
                          backgroundColor: ButtonState.all(Colors.green),
                        ),
                        onPressed: () => _uploadImage(),
                        child: const Text('Télécharger'),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on CroppedFile?{
  bool get isNull => this == null;
  bool get isNotNull => this != null;

}
