import 'package:fincra_payment/fincra_payment.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fincra Payment'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          FincraFlutter.launchFincra(
            context,
            publicKey: "******************************",
            amount: '100',
            name: "Ayanfe Afolabi",
            phoneNumber: '+2347031276982',
            currency: "NGN",
            email: 'ayanfesolutions@gmail.com',
            feeBearer: "customer", // either "customer" or "buyer"
            onSuccess: (data) async {
              print('Payment Successful on test mode');
              // All actions to be performed after the successful payment
            },
            onError: (data) {
              print('Payment Failed');
            },
            onClose: () {
              Navigator.of(context).pop();
              print('Payment Close');
            },
          );
        },
        child: Text('Make Payment'),
      )),
    );
  }
}
