import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ttld/core/enums/region.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:ttld/core/utils/launch_utils.dart'; // Import the new utility function

class LienHePage extends StatelessWidget {
  const LienHePage({super.key, this.region = Region.binhDinh});

  final Region region;

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  Future<void> _openZalo(String zaloId) async {
    final Uri zaloUri = Uri.parse('zalo://zalo.me/$zaloId');
    final Uri webUri = Uri.parse('https://zalo.me/$zaloId');

    try {
      final bool launched = await launchUrl(
        zaloUri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        // If zalo:// scheme failed, try the web URL
        await launchUrl(
          webUri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // If zalo:// scheme throws error, fall back to web URL
      await launchUrl(
        webUri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> _openWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Widget _buildContactCard(BuildContext context) {
    switch (region) {
      case Region.lamDong:
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('TRUNG TÂM DỊCH VỤ VIỆC LÀM LÂM ĐỒNG',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined),
                    SizedBox(width: 8),
                    Expanded(
                        child: Text(
                            'Số 172 Nguyễn Văn Trỗi, phường 2, thành phố Đà Lạt, tỉnh Lâm Đồng')),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.email_outlined),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () =>
                          _copyToClipboard(context, 'vieclamlamdong@gmail.com'),
                      child: const Text(
                        'vieclamlamdong@gmail.com',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => launchPhoneCall(
                          context, '02633822360'), // Use the shared function
                      child: const Text(
                        '(0263).3822360',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset('assets/zalo_icon/zalo-icon-svg.svg',
                        width: 20, height: 20),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _openZalo('0918007245'),
                      child: const Text(
                        'TRUNG TÂM DVVL LÂM ĐỒNG',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.language),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _openWebsite('http://vieclamlamdong.vn'),
                      child: const Text(
                        'http://vieclamlamdong.vn',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Chi nhánh',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined),
                    SizedBox(width: 8),
                    Expanded(
                        child: Text(
                            'Văn phòng Bảo Lộc\nSố 147 Phan Bội Châu, phường 1, Tp. Bảo Lộc, tỉnh Lâm Đồng')),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => launchPhoneCall(
                          context, '02633822360'), // Use the shared function
                      child: const Text(
                        '(0263).3822360',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.email_outlined),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () =>
                          _copyToClipboard(context, 'vieclamlamdong@gmail.com'),
                      child: const Text(
                        'vieclamlamdong@gmail.com',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      case Region.binhThuan:
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Trung tâm dịch vụ việc làm tỉnh Bình Thuận',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined),
                    SizedBox(width: 8),
                    Expanded(
                        child: Text(
                            'Văn phòng Phan Thiết\nSố 2 Phạm Tuấn Tài, Phường Phú Thủy, TP. Phan Thiết, Bình Thuận')),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.email_outlined),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _copyToClipboard(
                          context, 'ttdvvl@vieclambinhthuan.com.vn'),
                      child: const Text(
                        'ttdvvl@vieclambinhthuan.com.vn',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => launchPhoneCall(
                          context, '02523820145'), // Use the shared function
                      child: const Text(
                        '(0252) 3820145',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.language),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () =>
                          _openWebsite('http://vieclambinhthuan.com.vn/'),
                      child: const Text(
                        'http://vieclambinhthuan.com.vn/',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset('assets/zalo_icon/zalo-icon-svg.svg',
                        width: 20, height: 20),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _openZalo('0911186448'),
                      child: const Text(
                        'TRUNG TÂM DVVL BÌNH THUẬN',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Chi nhánh',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined),
                    SizedBox(width: 8),
                    Expanded(
                        child: Text(
                            'Văn phòng Tuy Phong\nSố 100 Đường 3/2, Phường Tuy Phong, TP. Tuy Phong, Bình Thuận')),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => launchPhoneCall(
                          context, '02523820145'), // Use the shared function
                      child: const Text(
                        '(0252) 3820145',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      case Region.binhDinh:
      default:
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Trung tâm dịch vụ việc làm tỉnh Bình Định',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined),
                    SizedBox(width: 8),
                    Expanded(
                        child: Text(
                            'Số 215 Trần Hưng Đạo, TP.Quy Nhơn, Bình Định')),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.email_outlined),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _copyToClipboard(
                          context, 'pvl@vieclambinhdinh.gov.vn'),
                      child: const Text(
                        'pvl@vieclambinhdinh.gov.vn',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => launchPhoneCall(
                          context, '0256364509'), // Use the shared function
                      child: const Text(
                        '(0256) 3646.509',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.language),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () =>
                          _openWebsite('http://vieclambinhdinh.gov.vn/'),
                      child: const Text(
                        'http://vieclambinhdinh.gov.vn/',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset('assets/zalo_icon/zalo-icon-svg.svg',
                        width: 20, height: 20),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _openZalo('2659249034461702353'),
                      child: const Text(
                        'Trung tâm DVVL tỉnh Bình Định', // Display text for Zalo link
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary.withAlpha(25),
                  theme.colorScheme.surface,
                ],
              ),
            ),
            child: SafeArea(
                child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .shadow
                              .withAlpha(26),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Liên hệ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildContactCard(context),
                ],
              ),
            ))));
  }
}
