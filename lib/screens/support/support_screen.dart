import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Hỗ trợ khách hàng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section với icon và text chào mừng
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: Column(
                children: [
                  const Icon(
                    Icons.support_agent,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Chúng tôi luôn sẵn sàng hỗ trợ bạn!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tìm câu trả lời nhanh chóng hoặc liên hệ trực tiếp với chúng tôi',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Phần FAQ với card design
                  _buildSectionTitle('Câu hỏi thường gặp', Icons.help_outline),
                  const SizedBox(height: 16),
                  _buildFaqCard(),

                  const SizedBox(height: 32),

                  // Phần liên hệ trực tiếp
                  _buildSectionTitle('Liên hệ trực tiếp', Icons.contact_support),
                  const SizedBox(height: 16),
                  _buildContactGrid(),

                  const SizedBox(height: 32),

                  // Button gửi phản hồi
                  _buildFeedbackButton(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2E7D32),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
      ],
    );
  }

  Widget _buildFaqCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _FaqItem(
            question: 'Làm sao để đặt vé?',
            answer: 'Bạn chỉ cần nhập điểm đi, điểm đến và ngày đi ở trang chủ, sau đó chọn chuyến xe phù hợp và làm theo hướng dẫn.',
            icon: Icons.confirmation_number_outlined,
          ),
          const Divider(height: 1),
          _FaqItem(
            question: 'Thanh toán như thế nào?',
            answer: 'Bạn có thể thanh toán qua VNPay, MoMo hoặc chuyển khoản ngân hàng trực tiếp trên ứng dụng.',
            icon: Icons.payment,
          ),
          const Divider(height: 1),
          _FaqItem(
            question: 'Tôi muốn huỷ vé phải làm sao?',
            answer: 'Vào mục "Vé của tôi" chọn vé cần huỷ và làm theo hướng dẫn. Lưu ý điều kiện hoàn vé theo chính sách nhà xe.',
            icon: Icons.cancel_outlined,
          ),
          const Divider(height: 1),
          _FaqItem(
            question: 'Làm sao để gửi hàng hóa?',
            answer: 'Bạn có thể chọn tính năng "Gửi hàng" trên trang chủ hoặc liên hệ hotline để được hỗ trợ nhanh nhất.',
            icon: Icons.local_shipping_outlined,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildContactGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildContactCard(
                icon: Icons.phone,
                title: 'Hotline',
                subtitle: '1900 1234',
                color: const Color(0xFF4CAF50),
                onTap: () {
                  // TODO: Tích hợp gọi điện
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildContactCard(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'hotro@thanthienbus.vn',
                color: const Color(0xFFFF5722),
                onTap: () {
                  // TODO: Mở ứng dụng gửi mail
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildContactCard(
                icon: Icons.facebook,
                title: 'Facebook',
                subtitle: 'fb.com/thanthienbus',
                color: const Color(0xFF1976D2),
                onTap: () {
                  // TODO: Mở link Facebook
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildContactCard(
                icon: Icons.chat_bubble_outline,
                title: 'Zalo OA',
                subtitle: '0901122333',
                color: const Color(0xFF00ACC1),
                onTap: () {
                  // TODO: Mở link Zalo
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CAF50).withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: const Icon(
          Icons.feedback_outlined,
          color: Colors.white,
          size: 20,
        ),
        label: const Text(
          'Gửi phản hồi / yêu cầu hỗ trợ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          // TODO: Điều hướng tới form gửi phản hồi hoặc mở bottom sheet nhập ý kiến
        },
      ),
    );
  }
}

// Widget cho từng mục FAQ với thiết kế cải tiến
class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;
  final IconData icon;
  final bool isLast;

  const _FaqItem({
    Key? key,
    required this.question,
    required this.answer,
    required this.icon,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2E7D32),
            size: 20,
          ),
        ),
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Color(0xFF2E2E2E),
          ),
        ),
        iconColor: const Color(0xFF4CAF50),
        collapsedIconColor: Colors.grey[600],
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(56, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}