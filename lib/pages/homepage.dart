import 'package:auth_prime/services/auth_service.dart';
import 'package:auth_prime/services/local_db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authServiceProvider = ref.read(authenticationServiceProvider);
    final userName = useState("");
    final greetMessage = useState("Good Morning");

    getUserName() async {
      final data = await ref.read(localDBProvider).getUserName();
      userName.value = data;
    }

    greetMessageFunction() {
      final now = DateTime.now();
      if (now.hour <= 12) {
        greetMessage.value = "Good Morning";
      } else if (now.hour >= 12 && now.hour <= 16) {
        greetMessage.value = "Good Afternoon";
      } else {
        greetMessage.value = "Good Evening";
      }
    }

    useEffect(() {
      greetMessageFunction();
      getUserName();

      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () async {
              await authServiceProvider.signOut();
            },
            icon: Icon(Icons.logout_sharp),
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              greetMessage.value,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Text(
              userName.value,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              "${authServiceProvider.getCurrentUser().phoneNumber}",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
