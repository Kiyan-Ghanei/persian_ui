import 'package:flutter/material.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  runApp(const PersianUIShowcaseApp());
}

class PersianUIShowcaseApp extends StatelessWidget {
  const PersianUIShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brandColor = Color(0xFF176B55);

    return MaterialApp(
      title: 'PersianUI Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandColor,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7F6),
        fontFamily: 'Arial',
      ),
      home: const PersianUIShowcasePage(),
    );
  }
}

class PersianUIShowcasePage extends StatefulWidget {
  const PersianUIShowcasePage({super.key});

  @override
  State<PersianUIShowcasePage> createState() =>
      _PersianUIShowcasePageState();
}

class _PersianUIShowcasePageState extends State<PersianUIShowcasePage> {
  bool _loading = false;
  bool _buttonEnabled = true;
  String _message = 'برای آزمایش کامپوننت‌ها روی دکمه‌ها کلیک کن.';

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _simulateLoading() async {
    setState(() {
      _loading = true;
      _message = 'در حال انجام عملیات...';
    });

    await Future<void>.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _loading = false;
      _message = 'عملیات با موفقیت انجام شد.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF176B55),
          foregroundColor: Colors.white,
          title: const Row(
            children: [
              Icon(Icons.widgets_outlined, size: 27),
              SizedBox(width: 12),
              Text(
                'PersianUI',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  'ویترین کامپوننت‌ها',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildHero(),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'انواع دکمه',
                  description:
                      'سه سبک اصلی برای عملیات مختلف در برنامه',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      PButton(
                        text: 'دکمه اصلی',
                        onPressed: () => _showMessage(
                          'دکمه اصلی انتخاب شد.',
                        ),
                      ),
                      PButton(
                        text: 'دکمه ثانویه',
                        variant: PButtonVariant.secondary,
                        onPressed: () => _showMessage(
                          'دکمه ثانویه انتخاب شد.',
                        ),
                      ),
                      PButton(
                        text: 'حذف اطلاعات',
                        variant: PButtonVariant.danger,
                        onPressed: () => _showMessage(
                          'دکمه خطر انتخاب شد.',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildSection(
                  title: 'اندازه‌های دکمه',
                  description: 'کوچک، متوسط و بزرگ',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      PButton(
                        text: 'کوچک',
                        size: PButtonSize.small,
                        onPressed: () => _showMessage(
                          'دکمه کوچک انتخاب شد.',
                        ),
                      ),
                      PButton(
                        text: 'متوسط',
                        size: PButtonSize.medium,
                        onPressed: () => _showMessage(
                          'دکمه متوسط انتخاب شد.',
                        ),
                      ),
                      PButton(
                        text: 'بزرگ',
                        size: PButtonSize.large,
                        onPressed: () => _showMessage(
                          'دکمه بزرگ انتخاب شد.',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildSection(
                  title: 'دکمه تمام‌عرض',
                  description:
                      'با fullWidth دکمه تمام فضای موجود را می‌گیرد.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PButton(
                        text: 'ادامه',
                        fullWidth: true,
                        onPressed: () => _showMessage(
                          'دکمه تمام‌عرض کار می‌کند.',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildSection(
                  title: 'دکمه آیکون‌دار',
                  description:
                      'دکمه‌ی آیکونی با راهنمای شناور (Tooltip)',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      PIconButton(
                        icon: Icons.favorite_outline,
                        tooltip: 'علاقه‌مندی‌ها',
                        onPressed: () => _showMessage(
                          'علاقه‌مندی‌ها انتخاب شد.',
                        ),
                      ),
                      PIconButton(
                        icon: Icons.edit_outlined,
                        variant: PButtonVariant.secondary,
                        tooltip: 'ویرایش',
                        onPressed: () => _showMessage(
                          'ویرایش انتخاب شد.',
                        ),
                      ),
                      PIconButton(
                        icon: Icons.delete_outline,
                        variant: PButtonVariant.danger,
                        tooltip: 'حذف',
                        onPressed: () => _showMessage(
                          'حذف انتخاب شد.',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildSection(
                  title: 'دکمه بارگذاری',
                  description:
                      'برای مشاهده‌ی حالت بارگذاری روی دکمه کلیک کن.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PLoadingButton(
                        text: 'اجرای عملیات',
                        loading: _loading,
                        fullWidth: true,
                        onPressed: _simulateLoading,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildSection(
                  title: 'حالت فعال و غیرفعال',
                  description:
                      'برای تغییر وضعیت دکمه از کلید زیر استفاده کن.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('دکمه فعال باشد'),
                        value: _buttonEnabled,
                        onChanged: (value) {
                          setState(() {
                            _buttonEnabled = value;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      PButton(
                        text: 'دکمه آزمایشی',
                        onPressed: _buttonEnabled
                            ? () => _showMessage(
                                  'دکمه آزمایشی فشرده شد.',
                                )
                            : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildMessageCard(),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'PersianUI • ساخته‌شده با Flutter',
                    style: TextStyle(
                      color: Color(0xFF68756F),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF176B55),
            Color(0xFF279879),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'طراحی رابط کاربری، ساده‌تر از همیشه',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'کامپوننت‌های قابل استفاده مجدد Flutter، '
            'با پشتیبانی از رابط فارسی و راست‌چین.',
            style: TextStyle(
              color: Color(0xFFE0F4EC),
              fontSize: 15,
              height: 1.8,
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _HeroTag(text: 'Reusable Components'),
              _HeroTag(text: 'RTL Ready'),
              _HeroTag(text: 'Material 3'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE5EBE7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF20352C),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF718078),
                height: 1.7,
              ),
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildMessageCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F3EC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC8E5D7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: Color(0xFF176B55),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'وضعیت تعامل',
                  style: TextStyle(
                    color: Color(0xFF176B55),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _message,
                  style: const TextStyle(
                    color: Color(0xFF355C4C),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroTag extends StatelessWidget {
  const _HeroTag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}