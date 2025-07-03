import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with TickerProviderStateMixin {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _currentLanguage = 'Tiếng Việt';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
      // TODO: Thêm logic đổi theme toàn app nếu cần (Provider/Bloc)
    });
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
  }

  void _selectLanguage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Chọn ngôn ngữ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            _buildLanguageOption(ctx, 'Tiếng Việt', '🇻🇳'),
            _buildLanguageOption(ctx, 'English', '🇺🇸'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext ctx, String language, String flag) {
    final isSelected = _currentLanguage == language;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(ctx).primaryColor.withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: Theme.of(ctx).primaryColor) : null,
      ),
      child: ListTile(
        leading: Text(flag, style: const TextStyle(fontSize: 24)),
        title: Text(language, style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? Theme.of(ctx).primaryColor : null,
        )),
        trailing: isSelected ? Icon(Icons.check, color: Theme.of(ctx).primaryColor) : null,
        onTap: () {
          setState(() => _currentLanguage = language);
          Navigator.pop(ctx);
        },
      ),
    );
  }

  void _openAboutPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AboutPage()),
    );
  }

  void _openTermsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TermsPage()),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required Widget child,
    double? marginBottom,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, marginBottom ?? 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? Theme.of(context).primaryColor).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: iconColor ?? Theme.of(context).primaryColor,
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
      )
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Cài đặt',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ListView(
          children: [
            // Appearance Section
            _buildSectionHeader('GIAO DIỆN'),
            _buildSettingCard(
              child: Column(
                children: [
                  _buildSettingTile(
                    icon: Icons.dark_mode,
                    title: 'Chế độ tối',
                    subtitle: 'Bật/tắt chế độ tối',
                    trailing: Switch(
                      value: _isDarkMode,
                      onChanged: _toggleTheme,
                      activeColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Divider(height: 1, indent: 68),
                  _buildSettingTile(
                    icon: Icons.language,
                    title: 'Ngôn ngữ',
                    subtitle: _currentLanguage,
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _selectLanguage(context),
                  ),
                ],
              ),
            ),

            // Notifications Section
            _buildSectionHeader('THÔNG BÁO'),
            _buildSettingCard(
              child: _buildSettingTile(
                icon: Icons.notifications,
                title: 'Thông báo',
                subtitle: _notificationsEnabled ? 'Đã bật' : 'Đã tắt',
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: _toggleNotifications,
                  activeColor: Theme.of(context).primaryColor,
                ),
                iconColor: Colors.orange,
              ),
            ),

            // Support Section
            _buildSectionHeader('HỖ TRỢ'),
            _buildSettingCard(
              child: Column(
                children: [
                  _buildSettingTile(
                    icon: Icons.info,
                    title: 'Giới thiệu ứng dụng',
                    subtitle: 'Thông tin về ứng dụng',
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _openAboutPage(context),
                    iconColor: Colors.blue,
                  ),
                  const Divider(height: 1, indent: 68),
                  _buildSettingTile(
                    icon: Icons.article,
                    title: 'Điều khoản sử dụng',
                    subtitle: 'Quy định và chính sách',
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _openTermsPage(context),
                    iconColor: Colors.green,
                  ),
                  const Divider(height: 1, indent: 68),
                  _buildSettingTile(
                    icon: Icons.help,
                    title: 'Trợ giúp',
                    subtitle: 'Câu hỏi thường gặp',
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Implement help page
                    },
                    iconColor: Colors.purple,
                  ),
                ],
              ),
            ),


            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ======================== Giới thiệu ứng dụng ========================

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Giới thiệu', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // App Icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.apps,
                size: 64,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 24),

            // App Name
            Text(
              'Ứng dụng Quản lý',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),

            // Version
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Phiên bản 1.0.0',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 32),


            const SizedBox(height: 16),

            // Developer Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================== Điều khoản sử dụng ========================

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Điều khoản sử dụng', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.shield,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Điều khoản sử dụng',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text(
                'Khi sử dụng ứng dụng này, bạn đồng ý với các điều khoản sau:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              _buildTermItem(
                context,
                '1. Sử dụng hợp pháp',
                'Không sử dụng ứng dụng cho mục đích bất hợp pháp, vi phạm pháp luật hoặc gây tổn hại đến người khác.',
              ),

              _buildTermItem(
                context,
                '2. Bảo vệ dữ liệu',
                'Dữ liệu người dùng được bảo vệ theo chính sách bảo mật của chúng tôi. Chúng tôi cam kết không chia sẻ thông tin cá nhân cho bên thứ ba.',
              ),

              _buildTermItem(
                context,
                '3. Thay đổi điều khoản',
                'Chúng tôi có quyền thay đổi các điều khoản này bất cứ lúc nào. Việc tiếp tục sử dụng ứng dụng sau khi thay đổi được coi là đồng ý với điều khoản mới.',
              ),

              _buildTermItem(
                context,
                '4. Trách nhiệm người dùng',
                'Người dùng có trách nhiệm bảo mật thông tin tài khoản và thông báo ngay cho chúng tôi khi phát hiện hoạt động bất thường.',
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.withOpacity(0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning, color: Colors.amber, size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Vui lòng đọc kỹ trước khi sử dụng ứng dụng.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Cập nhật lần cuối: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermItem(BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}