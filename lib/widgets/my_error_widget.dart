import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    super.key,
    required this.errorText,
    required this.retryFunction,
  });

  final String errorText;
  final Function retryFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Icon(MyAppIcons.error, size: 50, color: Theme.of(context).colorScheme.error,),
          const SizedBox(height: 20),
          Text(
            'Error: $errorText',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => retryFunction,
            child: Text(
              'Retry',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
