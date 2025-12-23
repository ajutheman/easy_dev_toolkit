import 'package:flutter/material.dart';
import 'package:easy_dev_toolkit/easy_dev_toolkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize connectivity monitoring
  await ConnectivityService.initialize();
  // Initialize storage
  await AppStorage.init();
  
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Easy Dev Toolkit Showcase",
      debugShowCheckedModeBanner: false,
      theme: EasyTheme.light(),
      darkTheme: EasyTheme.dark(),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Initialize responsive sizing
    SizeConfig.init(context);

    return Scaffold(
      appBar: EasyAppBar.simple(
        title: "Toolkit Showcase",
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () => context.push(const FullCalendarScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OfflineBanner(),
            
            // 1. Profile Header Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ProfileHeader(
                name: "John Developer",
                email: "john.dev@toolkit.com",
                avatar: "https://i.pravatar.cc/150?u=a042581f4e29026704d",
              ),
            ),
            
            SizedBox(height: 24.h),

            // 2. Horizontal Date Selector Section
            Padding(
              padding: EdgeInsets.only(left: 16.w, bottom: 8.h),
              child: Text(
                "Select Schedule",
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            HorizontalDateSelector(
              days: List.generate(14, (i) => DateSelectorDay.fromDateTime(
                DateTime.now().add(Duration(days: i)),
              )),
              initialSelectedIndex: _selectedDateIndex,
              onDateSelected: (index) {
                setState(() => _selectedDateIndex = index);
                EasyToast.show("Selected day: $index");
              },
            ),

            SizedBox(height: 24.h),

            // 3. Glassmorphism & Stats Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: GlassCard(
                      height: 120.h,
                      color: Colors.blue,
                      opacity: 0.15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.auto_graph, color: Colors.blue),
                          SizedBox(height: 8.h),
                          Text("Efficiency", style: context.textTheme.bodySmall),
                          Text("92%", style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GlassCard(
                      height: 120.h,
                      color: Colors.purple,
                      opacity: 0.15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.timer, color: Colors.purple),
                          SizedBox(height: 8.h),
                          Text("Time Logged", style: context.textTheme.bodySmall),
                          Text("38.5h", style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // 4. Adaptive Widgets Showcase
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: context.theme.dividerColor.withValues(alpha: 0.1)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Adaptive Badge", style: context.textTheme.bodyMedium),
                        const AdaptiveBadge(label: "New Feature", backgroundColor: Colors.green),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    AdaptiveTextField(
                      controller: _searchController,
                      label: "Search Projects",
                      prefixIcon: const Icon(Icons.search),
                    ),
                    SizedBox(height: 16.h),
                    AdaptiveButton.filled(
                      text: "Submit Draft",
                      onPressed: () => EasyToast.show("Draft Submitted"),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // 5. Grid View Showcase
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
              child: Text(
                "Quick Actions",
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AdaptiveGrid(
                children: [
                  ReusableCard(title: "Security", subtitle: "Key management", icon: Icons.security, onTap: () {}),
                  ReusableCard(title: "Network", subtitle: "Check status", icon: Icons.wifi, onTap: () {}),
                  ReusableCard(title: "Storage", subtitle: "Cache settings", icon: Icons.storage, onTap: () {}),
                  ReusableCard(title: "History", subtitle: "Recent logs", icon: Icons.history, onTap: () {}),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),

            // 6. Networking & Utilities
            AdaptiveListTile(
              title: "Networking Demo (EasyApi)",
              subtitle: "Fetching from JSONPlaceholder",
              leading: Icons.cloud_download_outlined,
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => context.push(const NetworkDemoScreen()),
            ),
            AdaptiveListTile(
              title: "Utilities & Security",
              subtitle: "Encryption, Storage, & Validators",
              leading: Icons.settings_suggest_outlined,
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => context.push(const UtilitiesDemoScreen()),
            ),
            AdaptiveListTile(
              title: "UI & Feedback",
              subtitle: "Dialogs, Loaders, & Skeletons",
              leading: Icons.brush_outlined,
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => context.push(const UIDemoScreen()),
            ),
          ],
        ),
      ),
    );
  }
}

class UtilitiesDemoScreen extends StatefulWidget {
  const UtilitiesDemoScreen({super.key});

  @override
  State<UtilitiesDemoScreen> createState() => _UtilitiesDemoScreenState();
}

class _UtilitiesDemoScreenState extends State<UtilitiesDemoScreen> {
  final TextEditingController _encryptController = TextEditingController();
  final TextEditingController _storageKeyController = TextEditingController();
  final TextEditingController _storageValueController = TextEditingController();
  
  String _encryptedText = "";
  String _decryptedText = "";
  String _storedValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasyAppBar.simple(title: "Utilities & Security"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Encryption (AES-256)"),
            AdaptiveTextField(
              controller: _encryptController,
              label: "Text to Encrypt",
              hint: "Enter sensitive data",
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: AdaptiveButton(
                    text: "Encrypt",
                    onPressed: () {
                      if (_encryptController.text.isEmpty) return;
                      setState(() {
                        _encryptedText = EncryptionUtil.encrypt(_encryptController.text);
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: AdaptiveButton.filled(
                    text: "Decrypt",
                    onPressed: () {
                      if (_encryptedText.isEmpty) return;
                      setState(() {
                        _decryptedText = EncryptionUtil.decrypt(_encryptedText);
                      });
                    },
                  ),
                ),
              ],
            ),
            if (_encryptedText.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text("Encrypted: $_encryptedText", style: context.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic)),
            ],
            if (_decryptedText.isNotEmpty) ...[
              SizedBox(height: 4.h),
              Text("Decrypted: $_decryptedText", style: context.textTheme.bodyMedium?.copyWith(color: Colors.green, fontWeight: FontWeight.bold)),
            ],

            SizedBox(height: 32.h),
            _sectionTitle("Local Storage (AppStorage)"),
            AdaptiveTextField(
              controller: _storageKeyController,
              label: "Key",
            ),
            SizedBox(height: 8.h),
            AdaptiveTextField(
              controller: _storageValueController,
              label: "Value",
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: AdaptiveButton(
                    text: "Save",
                    onPressed: () async {
                      await AppStorage.write(_storageKeyController.text, _storageValueController.text);
                      EasyToast.show("Saved successfully");
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: AdaptiveButton.filled(
                    text: "Read",
                    onPressed: () async {
                      final val = AppStorage.read<String>(_storageKeyController.text);
                      setState(() => _storedValue = val ?? "Not found");
                    },
                  ),
                ),
              ],
            ),
            if (_storedValue.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Text("Result: $_storedValue", style: context.textTheme.titleMedium),
            ],

            SizedBox(height: 32.h),
            _sectionTitle("Extensions Showcase"),
            _extensionItem("String.capitalize()", "hello world".capitalize()),
            _extensionItem("String.isValidEmail", "test@mail".isValidEmail.toString()),
            _extensionItem("DateTime.timeAgo", DateTime.now().subtract(const Duration(hours: 5)).timeAgo()),
            _extensionItem("Responsive Sizing", "Width: ${100.w.toStringAsFixed(1)}, Height: ${100.h.toStringAsFixed(1)}"),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: EdgeInsets.only(bottom: 12.h),
    child: Text(title, style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
  );

  Widget _extensionItem(String title, String result) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.textTheme.bodyMedium),
        Text(result, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue)),
      ],
    ),
  );
}

class UIDemoScreen extends StatelessWidget {
  const UIDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasyAppBar.simple(title: "UI & Feedback"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Skeleton Loader Demo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 12.h),
            const SkeletonLoader(height: 100, borderRadius: 12),
            SizedBox(height: 12.h),
            Row(
              children: [
                const SkeletonLoader(width: 60, height: 60, shape: BoxShape.circle),
                SizedBox(width: 12.w),
                const Expanded(
                  child: Column(
                    children: [
                      SkeletonLoader(height: 14),
                      SizedBox(height: 8),
                      SkeletonLoader(height: 14, width: 150),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 32.h),
            const Text("Feedback Components", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 12.h),
            AdaptiveButton(
              text: "Show Adaptive Dialog",
              onPressed: () => EasyDialog.show(
                context,
                title: "Confirm Action",
                message: "This will demonstrate the adaptive nature of our toolkit.",
                onConfirm: () => EasyToast.show("Confirmed!"),
              ),
            ),
            SizedBox(height: 12.h),
            AdaptiveButton.filled(
              text: "Show Loading Overlay",
              onPressed: () {
                EasyLoader.show(context);
                Future.delayed(const Duration(seconds: 2), () => EasyLoader.hide(context));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NetworkDemoScreen extends StatefulWidget {
  const NetworkDemoScreen({super.key});

  @override
  State<NetworkDemoScreen> createState() => _NetworkDemoScreenState();
}

class _NetworkDemoScreenState extends State<NetworkDemoScreen> {
  List<dynamic> _posts = [];
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final response = await EasyApi.get(
      'https://jsonplaceholder.typicode.com/posts',
      useCache: true,
      ttl: const Duration(minutes: 5),
    );

    if (response.isSuccess) {
      setState(() {
        _posts = (response.data as List).take(10).toList();
        _loading = false;
      });
    } else {
      setState(() {
        _error = response.error;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasyAppBar.simple(title: "EasyApi Demo"),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 60, color: Colors.red),
                      SizedBox(height: 16.h),
                      Text("Error: $_error"),
                      const SizedBox(height: 16),
                      AdaptiveButton(text: "Retry", onPressed: _fetchData),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchData,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _posts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final post = _posts[i];
                      return ReusableCard(
                        title: post['title'],
                        subtitle: post['body'],
                        icon: Icons.article_outlined,
                        onTap: () {},
                      );
                    },
                  ),
                ),
    );
  }
}

class FullCalendarScreen extends StatelessWidget {
  const FullCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasyAppBar.simple(title: "Calendar View"),
      body: Column(
        children: [
          TimeLogCalendar(
            initialDate: DateTime.now(),
            onDateSelected: (date) {
              EasyToast.show("Date set to: ${date.day}/${date.month}");
            },
          ),
          const Expanded(
            child: Center(
              child: EmptyState(
                title: "No appointments",
                message: "Select a date to view your logs.",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
