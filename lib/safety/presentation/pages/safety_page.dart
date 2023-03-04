import 'package:blur/blur.dart';
import 'package:femease/safety/presentation/pages/emergency_contacts_page.dart';
import 'package:flutter/material.dart';

class SafetyPage extends StatelessWidget {
  const SafetyPage({
    super.key,
    required this.imageUrl,
    required this.tag,
  });

  final String imageUrl;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.secondary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        actionsIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: const Text("Safety"),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EmergencyContactsPage(),
          ),
        ),
        label: const Text(
          "Add Emergency Contacts",
        ),
        icon: const Icon(
          Icons.add,
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: 10,
            right: -110,
            child: Hero(
              tag: tag,
              child: Image.asset(
                imageUrl,
                height: 500,
                width: 500,
              ).blurred(blur: 10),
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Safety Emergency",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        trailing: FilledButton.icon(
                          onPressed: () async {
                            // await FlutterPhoneDirectCaller.callNumber();
                          },
                          label: const Text("Contact"),
                          icon: const Icon(
                            Icons.call_outlined,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Medical Emergency",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        trailing: FilledButton.icon(
                          onPressed: () {},
                          label: const Text("Contact"),
                          icon: const Icon(
                            Icons.call_outlined,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Family Emergency",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        trailing: FilledButton.icon(
                          onPressed: () {},
                          label: const Text("Contact"),
                          icon: const Icon(
                            Icons.call_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
