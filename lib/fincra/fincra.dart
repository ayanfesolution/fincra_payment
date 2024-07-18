import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'error_widget.dart';
import 'fincra_html.dart';
import 'loading.dart';

class FincraPayment extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String amount;
  final String email;
  final String publicKey;
  final String currency;
  final String feeBearer;
  final Function onClose;
  final Function(dynamic payload) onSuccess;
  final Function(dynamic payload) onError;

  const FincraPayment({
    super.key,
    required this.publicKey,
    required this.amount,
    required this.email,
    required this.currency,
    required this.onClose,
    required this.onSuccess,
    required this.onError,
    required this.name,
    required this.phoneNumber,
    required this.feeBearer,
  });

  @override
  FincraPaymentState createState() => FincraPaymentState();
}

class FincraPaymentState extends State<FincraPayment> {
  final WebViewController _controller = WebViewController();

  bool _isLoading = true;
  bool _isError = false;
  @override
  void initState() {
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _isLoading = false;
            setState(() {});
          },
          onWebResourceError: (onWebResourceError) {
            _isLoading = false;
            _isError = true;
            setState(() {});
          },
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onNavigationRequest: _handleNavigationInterceptor,
        ),
      )
      ..addJavaScriptChannel(
        'FincraClientInterface',
        onMessageReceived: (data) {
          debugPrint('JavaScript message received: ${data.message}');
          handleResponse(data.message);
        },
      )
      ..loadRequest(
        Uri.dataFromString(
          buildFincraHtml(
            widget.name,
            widget.amount,
            widget.email,
            widget.publicKey,
            widget.feeBearer,
            widget.phoneNumber,
            widget.currency,
          ),
          mimeType: "text/html",
        ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: WebViewWidget(
            controller: _controller,
          ),
        ),
        Visibility(
          visible: _isLoading,
          child: const Positioned(
            child: FincraLoader(),
          ),
        ),
        Visibility(
          visible: _isError,
          child: Positioned(
            child: FincraErrorWidget(
              title: "Couldn't load up checkout.",
              reload: () async {
                _isLoading = true;
                _isError = false;
                setState(() {});
                await _controller.reload();
              },
            ),
          ),
        ),
      ],
    );
  }

  void handleResponse(String body) async {
    debugPrint('Handling response: $body');
    try {
      final Map<String, dynamic> bodyMap = json.decode(body);
      final String event = bodyMap['event'];
      switch (event) {
        case "checkout.closed":
          widget.onClose();
          break;
        case "checkout.success":
          widget.onSuccess(bodyMap['data']);
          break;
        default:
          widget.onError({"data": "Unhandled event type: $event"});
      }
    } catch (e) {
      debugPrint('Error in handleResponse: $e');
      widget.onError({"data": "something really bad happened."});
    }
  }

  NavigationDecision _handleNavigationInterceptor(NavigationRequest request) {
    if (request.url.toLowerCase().contains('fincra')) {
      // Navigate to all urls contianing fincra
      return NavigationDecision.navigate;
    } else {
      // Block all navigations outside fincra
      return NavigationDecision.prevent;
    }
  }
}
