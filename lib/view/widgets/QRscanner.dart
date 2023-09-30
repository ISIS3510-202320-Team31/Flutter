import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
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
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderColor: Colors.white,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
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
            Navigator.pop(context);
            _showDetailEvent(context);
          }
        });
      },
    );
  }

  Future<void> _showDetailEvent(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
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
                      height: MediaQuery.of(context).size.height,
                    );
                  case Status.ERROR:
                    print("Log :: ERROR");
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: appTheme.cardColor,
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            SizedBox(height: 30.0), // Espaciado opcional
                            Text("Evento no encontrado"),
                            SizedBox(height: 20.0), // Espaciado opcional
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                backgroundColor: appTheme.hintColor,
                              ),
                              onPressed: () {
                                Navigator.pop(context); // Cierra el diálogo y vuelve a la vista anterior
                              },
                              child: Text('Regresar', style: TextStyle(color: appTheme.cardColor),),
                            ),
                            SizedBox(height: 30.0),
                          ],
                        ),
                      ),
                    );

                  case Status.COMPLETED:
                    print("Log :: COMPLETED");
                    return
                    EventDetail(eventId: viewModel.event.data!.id
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
