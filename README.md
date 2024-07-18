Sure, here's a customized `README.md` for your package, based on your description:

---

# Fincra Payment Package

A Flutter package for integrating Fincra Payment checkout, enabling developers to facilitate payments using debit and credit cards, and providing hooks for custom network calls post-success.

## Features

- Easy integration with Fincra Payment API.
- Supports payments via debit and credit cards.
- Hooks for executing custom network calls upon successful payment.
- Customizable payment flow to suit various application needs.

## Getting started

### Prerequisites

Before using this package, ensure you have the following:

- A Flutter project set up. If you don't have one, create it by running:
  ```bash
  flutter create my_flutter_app
  cd my_flutter_app
  ```
- A Fincra account with the necessary API keys. You can sign up for an account [here](https://fincra.com).

### Installation

Add the following dependency to your `pubspec.yaml` file:
```yaml
dependencies:
  fincra_payment: ^1.0.0
```

Then, run `flutter pub get` to fetch the package.

## Usage

Here’s a short example demonstrating how to use the Fincra Payment package:

```dart
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
          FincraCheckout.launchFincra(
            context,
            publicKey:
                "******************************", // Use test key for test and live key for live
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
        child: const Text('Make Payment'),
      )),
    );
  }
}
```

For more detailed examples, refer to the `/example` folder in the package.

## Additional information

For more information about the package, documentation, and contribution guidelines, visit the [GitHub repository](https://github.com/ayanfesolution/fincra_payment).

### Contributing

Contributions are welcome! If you find any bugs or have feature requests, please [open an issue](https://github.com/ayanfesolution/fincra_payment/issues) or submit a pull request.

### Support

For any questions or support, feel free to contact the package authors through the GitHub repository or +2347031276982 or ayanfesolutions@gmail.com.

---
