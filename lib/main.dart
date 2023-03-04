import 'package:femease/app.dart';
import 'package:femease/authentication/repository/auth_repository.dart';
import 'package:femease/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () =>
                ref.watch(firebaseAuthRepositoryProvider).signOut(),
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(
        child: Text(
          ref.watch(firebaseAuthRepositoryProvider).currentUser?.email ?? "",
        ),
      ),
    );
  }
}
