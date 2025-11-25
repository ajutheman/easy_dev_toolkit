import 'package:flutter/material.dart';
import 'package:easy_dev_toolkit/easy_dev_toolkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConnectivityService.initialize();
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Easy Dev Toolkit",
      theme: EasyTheme.light(),
      darkTheme: EasyTheme.dark(),
      home: const ExampleHomeScreen(),
    );
  }
}

class ExampleHomeScreen extends StatefulWidget {
  const ExampleHomeScreen({super.key});

  @override
  State<ExampleHomeScreen> createState() => _ExampleHomeScreenState();
}

class _ExampleHomeScreenState extends State<ExampleHomeScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: EasyAppBar.simple(title: "Easy Dev Toolkit Demo"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            const OfflineBanner(),
            ProfileHeader(
              name: "Ajmal M",
              email: "example@mail.com",
              avatar: "https://i.pravatar.cc/150",
            ),
            SizedBox(height: 24.h),
            AdaptiveTextField(
              controller: nameController,
              label: "Your Name",
              prefixIcon: const Icon(Icons.person),
              validator: Validator.required,
            ),
            SizedBox(height: 16.h),
            AdaptiveButton(
              text: "Say Hello",
              onPressed: () {
                EasyToast.show("Hi ${nameController.text}");
              },
            ),
            SizedBox(height: 24.h),
            Text("Layout Grid Example", style: TextStyle(fontSize: 16.sp)),
            AdaptiveGrid(
              children: List.generate(
                6,
                (i) => ReusableCard(
                  title: "Card ${i + 1}",
                  subtitle: "Tap",
                  icon: Icons.apps,
                  onTap: () {},
                ),
              ),
            ),
            AdaptiveListTile(
              title: "Settings",
              leading: Icons.settings,
              onTap: () {},
            ),
            SizedBox(height: 24.h),
            const EmptyState(title: "No Data", message: "Try adding something"),
            OfflineScreen(onRetry: () => EasyToast.show("Retry pressed")),
          ],
        ),
      ),
    );
  }
}
