import 'package:flutter/material.dart';

class UiHelper {
  static BuildContext? dialogContext;

  static buildDialog(BuildContext context) async {
    dialogContext = context;
    await showDialog(
      context: context,
      builder: (BuildContext contextOfDialog) {
        return Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 16,
                    width: double.infinity,
                  ),
                  Text(
                    'Please Wait',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static buildBottomSheet(BuildContext context) async {
    dialogContext = context;
   await showModalBottomSheet(
      context: context,
      builder: (BuildContext contextOfDialog) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('please select your preferred payment method'),
              const SizedBox(
                height: 16,
                width: double.infinity,
              ),
              ListTile(
                trailing: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.monetization_on_outlined,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                title: const Text('Test Payment'),
                onTap: closeDialog,
              ),
            ],
          ),
        );
      },
    );
  }

  static closeDialog() {
    if (dialogContext != null) {
      Navigator.pop(dialogContext!);
    }
  }
}
