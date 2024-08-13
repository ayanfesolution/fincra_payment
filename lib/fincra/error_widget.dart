import 'package:flutter/material.dart';

class FincraErrorWidget extends StatelessWidget {
  final String title;
  final VoidCallback reload;

  const FincraErrorWidget({
    super.key,
    required this.title,
    required this.reload,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .8,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .03,
          ),
          TextButton(
            child: const Text(
              "Retry",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () => reload(),
          ),
        ],
      ),
    );
  }
}
