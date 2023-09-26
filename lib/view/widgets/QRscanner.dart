import 'package:flutter/material.dart';
import 'package:hive_app/view/pages/Home.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/view/widgets/EventDetail.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:provider/provider.dart';

class QRscanner extends StatefulWidget {
  @override
  _QrCodeScannerWidgetState createState() => _QrCodeScannerWidgetState();
}

class _QrCodeScannerWidgetState extends State<QRscanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? _controller;
  var qrSeen = false;

  final EventVM eventVM = EventVM();

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: (QRViewController controller) {
        setState(() {
          _controller = controller;
        });
        controller.scannedDataStream.listen((scanData) {
          setState(() {
            result = scanData;
          });

          // Verifica si se ha escaneado un código QR válido y si no se ha visto antes
          if (result != null && result!.code!.isNotEmpty && !qrSeen) {
            eventVM.fetchEventById(result!.code!);
            qrSeen = true;
            controller.stopCamera();
            _showDetailEvent(context);
            Navigator.pop(context);
          }
        });
      },
    );
  }

  Future<void> _showDetailEvent(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        // Muestra el detalle del evento y permite que el usuario vuelva a la vista Home
        return ChangeNotifierProvider<EventVM>(
            create: (BuildContext context) => eventVM,
            child: Consumer<EventVM>(
              builder: (context, viewModel, _) {
                switch (viewModel.event.status) {
                  case Status.LOADING:
                    print("Log :: LOADING");
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                        ),
                      ),
                      height: MediaQuery.of(context).size.height*0.7,
                    );
                  case Status.ERROR:
                    print("Log :: ERROR");
                    return Container(
                      child: Center(
                        child: Text("Error"),
                      ),
                    );
                  case Status.COMPLETED:
                    print("Log :: COMPLETED");
                    return
                    Expanded(child: EventDetail(event: viewModel.event.data!)
                    );
                  default:
                    return Container();
                }
              },
            ),
          );
      },
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
