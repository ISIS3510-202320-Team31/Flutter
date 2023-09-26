import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRscanner extends StatefulWidget {
  @override
  _QrCodeScannerWidgetState createState() => _QrCodeScannerWidgetState();
}

class _QrCodeScannerWidgetState extends State<QRscanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escáner QR'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (QRViewController controller) {
                setState(() {
                  _controller = controller;
                });
                controller.scannedDataStream.listen((scanData) {
                  setState(() {
                    result = scanData;
                  });

                  // Verifica si se ha escaneado un código QR válido
                  if (result != null && result!.code!.isNotEmpty) {
                    // Navega a la pantalla ResultadoScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultadoScreen(qrCodeData: result!.code!),
                      ),
                    );
                  }
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Resultado: ${result?.code ?? "No hay datos"}'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class ResultadoScreen extends StatelessWidget {
  final String qrCodeData;

  ResultadoScreen({required this.qrCodeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado del escaneo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Código QR Escaneado:'),
            Text(qrCodeData),
            // Agrega más widgets o contenido según sea necesario
          ],
        ),
      ),
    );
  }
}
