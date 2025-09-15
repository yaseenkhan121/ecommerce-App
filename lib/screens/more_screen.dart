import 'package:flutter/material.dart';
import 'package:ecom_app/constants/app_colors.dart';
import 'package:ecom_app/constants/app_typography.dart';
import 'package:ecom_app/screens/login_screen.dart';
import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/data/dummy_data.dart';
import 'package:url_launcher/url_launcher.dart';


class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  String _currentView = 'main';
  final TextEditingController _nameController = TextEditingController(text: 'John Doe');
  final TextEditingController _emailController = TextEditingController(text: 'john.doe@example.com');
  bool _isEditingProfile = false;

  final List<Product> _wishlistProducts = [
    dummyProducts[0],
    dummyProducts[3],
  ];

  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ORD12345',
      'date': 'Oct 26, 2023',
      'status': 'Delivered',
      'total': 155.00,
      'products': [
        {'product': dummyProducts[0], 'quantity': 1},
        {'product': dummyProducts[1], 'quantity': 1},
      ],
    },
    {
      'id': 'ORD12346',
      'date': 'Oct 28, 2023',
      'status': 'Processing',
      'total': 90.00,
      'products': [
        {'product': dummyProducts[2], 'quantity': 1},
      ],
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        foregroundColor: AppColors.darkGrey,
        leading: _currentView == 'main'
            ? null
            : IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _currentView = 'main';
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildBody(),
        ),
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_currentView) {
      case 'settings':
        return 'Settings';
      case 'myOrders':
        return 'My Orders';
      case 'wishlist':
        return 'Wishlist';
      case 'help':
        return 'Help & FAQ';
      case 'contact':
        return 'Contact Us';
      case 'privacyPolicy':
        return 'Privacy Policy';
      case 'termsOfService':
        return 'Terms of Service';
      default:
        return 'More';
    }
  }

  Widget _buildBody() {
    switch (_currentView) {
      case 'main':
        return _buildMainView();
      case 'settings':
        return _buildSettingsView();
      case 'myOrders':
        return _buildMyOrdersView();
      case 'wishlist':
        return _buildWishlistScreen();
      case 'help':
        return _buildHelpScreen();
      case 'contact':
        return _buildContactScreen();
      case 'privacyPolicy':
        return _buildLegalScreen('Privacy Policy');
      case 'termsOfService':
        return _buildLegalScreen('Terms of Service');
      default:
        return _buildMainView();
    }
  }

  Widget _buildMainView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileHeader(),
        const SizedBox(height: 24),
        const Text(
          'Account',
          style: AppTypography.headingStyle,
        ),
        const SizedBox(height: 10),
        _buildMoreOption(
          title: 'Settings',
          icon: Icons.settings,
          onTap: () {
            setState(() {
              _currentView = 'settings';
            });
          },
        ),
        _buildMoreOption(
          title: 'My Orders',
          icon: Icons.shopping_cart_outlined,
          onTap: () {
            setState(() {
              _currentView = 'myOrders';
            });
          },
        ),
        _buildMoreOption(
          title: 'Wishlist',
          icon: Icons.favorite_border,
          onTap: () {
            setState(() {
              _currentView = 'wishlist';
            });
          },
        ),
        const Divider(height: 32, thickness: 1, color: AppColors.lightGrey),
        const Text(
          'Support',
          style: AppTypography.headingStyle,
        ),
        const SizedBox(height: 10),
        _buildMoreOption(
          title: 'Help & FAQ',
          icon: Icons.help_outline,
          onTap: () {
            setState(() {
              _currentView = 'help';
            });
          },
        ),
        _buildMoreOption(
          title: 'Contact Us',
          icon: Icons.contact_mail_outlined,
          onTap: () {
            setState(() {
              _currentView = 'contact';
            });
          },
        ),
        const Divider(height: 32, thickness: 1, color: AppColors.lightGrey),
        const Text(
          'Legal',
          style: AppTypography.headingStyle,
        ),
        const SizedBox(height: 10),
        _buildMoreOption(
          title: 'Privacy Policy',
          icon: Icons.privacy_tip_outlined,
          onTap: () {
            setState(() {
              _currentView = 'privacyPolicy';
            });
          },
        ),
        _buildMoreOption(
          title: 'Terms of Service',
          icon: Icons.description_outlined,
          onTap: () {
            setState(() {
              _currentView = 'termsOfService';
            });
          },
        ),
        const Divider(height: 32, thickness: 1, color: AppColors.lightGrey),
        _buildMoreOption(
          title: 'Sign Out',
          icon: Icons.logout,
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
            );
          },
          isLogout: true,
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryOrange.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primaryOrange,
                child: Icon(Icons.person, color: AppColors.backgroundWhite, size: 40),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome,',
                      style: AppTypography.bodyText.copyWith(color: AppColors.darkGrey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _nameController.text.isEmpty ? 'User' : _nameController.text,
                      style: AppTypography.titleStyle,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(_isEditingProfile ? Icons.check : Icons.edit, color: AppColors.darkGrey),
                onPressed: () {
                  setState(() {
                    _isEditingProfile = !_isEditingProfile;
                  });
                },
              ),
            ],
          ),
          if (_isEditingProfile) ...[
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMoreOption({
    required String title,
    IconData? icon,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isLogout
                ? Colors.red.withAlpha(25)
                : AppColors.primaryOrange.withAlpha(25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: isLogout ? Colors.red : AppColors.primaryOrange),
        ),
        title: Text(
          title,
          style: AppTypography.bodyText.copyWith(
              fontWeight: FontWeight.w500,
              color: isLogout ? Colors.red : AppColors.darkGrey),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.darkGrey, size: 16),
        onTap: onTap,
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildSettingsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'General',
          style: AppTypography.headingStyle,
        ),
        const SizedBox(height: 10),
        _buildSettingOption(
          title: 'Notifications',
          icon: Icons.notifications_none,
          trailing: Switch(
            value: true,
            onChanged: (bool value) {},
          ),
        ),
        _buildSettingOption(
          title: 'Language',
          icon: Icons.language,
          trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.darkGrey, size: 16),
        ),
        const Divider(height: 32, thickness: 1, color: AppColors.lightGrey),
        const Text(
          'Privacy',
          style: AppTypography.headingStyle,
        ),
        const SizedBox(height: 10),
        _buildSettingOption(
          title: 'Change Password',
          icon: Icons.lock_outline,
          trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.darkGrey, size: 16),
        ),
        _buildSettingOption(
          title: 'Privacy Controls',
          icon: Icons.security,
          trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.darkGrey, size: 16),
        ),
      ],
    );
  }

  Widget _buildSettingOption({
    required String title,
    IconData? icon,
    required Widget trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryOrange.withAlpha(25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primaryOrange),
        ),
        title: Text(
          title,
          style: AppTypography.bodyText.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.darkGrey),
        ),
        trailing: trailing,
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildMyOrdersView() {
    return _orders.isEmpty
        ? const Center(
      child: Text(
        'You have no orders yet.',
        style: AppTypography.bodyText,
      ),
    )
        : Column(
      children: _orders.map<Widget>((order) => _buildOrderCard(order)).toList(),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order['id']}',
                  style: AppTypography.bodyText.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  order['status'],
                  style: AppTypography.bodyText.copyWith(
                      color: order['status'] == 'Delivered'
                          ? Colors.green
                          : AppColors.primaryOrange),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Date: ${order['date']}', style: AppTypography.bodyText),
            Text('Total: \$${order['total'].toStringAsFixed(2)}',
                style: AppTypography.bodyText),
            const Divider(height: 24, thickness: 1),
            ...order['products'].map<Widget>((item) {
              final product = item['product'] as Product;
              final quantity = item['quantity'] as int;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(product.imageUrls[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name,
                              style: AppTypography.bodyText.copyWith(fontWeight: FontWeight.w500)),
                          Text('Quantity: $quantity', style: AppTypography.bodyText),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistScreen() {
    return _wishlistProducts.isEmpty
        ? const Center(
      child: Text(
        'Your wishlist is empty.',
        style: AppTypography.bodyText,
      ),
    )
        : GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: _wishlistProducts.length,
      itemBuilder: (context, index) {
        final product = _wishlistProducts[index];
        return _buildWishlistItem(product);
      },
    );
  }

  Widget _buildWishlistItem(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              product.imageUrls[0],
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppTypography.bodyText.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: AppTypography.bodyText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFaqItem(
          question: 'How do I track my order?',
          answer: 'You can track your order by going to the "My Orders" section. Select the order you wish to track for real-time updates on its status and location.',
        ),
        _buildFaqItem(
          question: 'What is your return policy?',
          answer: 'We offer a 30-day return policy on all eligible items. Please ensure the item is in its original condition with all tags attached. Refunds will be processed within 5-7 business days.',
        ),
        _buildFaqItem(
          question: 'How can I reset my password?',
          answer: 'If you have forgotten your password, navigate to the login screen and tap "Forgot Password". A reset link will be sent to your registered email address.',
        ),
      ],
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(question, style: AppTypography.bodyText.copyWith(fontWeight: FontWeight.bold)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(answer, style: AppTypography.bodyText),
        ),
      ],
    );
  }

  Widget _buildContactScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Get in touch with us!',
          style: AppTypography.headingStyle,
        ),
        const SizedBox(height: 10),
        _buildContactOption(
          title: 'Email',
          subtitle: 'support@e-app.com',
          icon: Icons.email_outlined,
          onTap: () {
            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'support@e-app.com',
            );
            launchUrl(emailLaunchUri);
          },
        ),
        _buildContactOption(
          title: 'Call Us',
          subtitle: '+1-800-555-0199',
          icon: Icons.phone_outlined,
          onTap: () {
            final Uri phoneLaunchUri = Uri(
              scheme: 'tel',
              path: '+1-800-555-0199',
            );
            launchUrl(phoneLaunchUri);
          },
        ),
      ],
    );
  }

  Widget _buildContactOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryOrange.withAlpha(25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primaryOrange),
        ),
        title: Text(
          title,
          style: AppTypography.bodyText.copyWith(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(subtitle, style: AppTypography.bodyText),
        trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.darkGrey, size: 16),
        onTap: onTap,
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildLegalScreen(String title) {
    return Column(
      children: [
        Text(
          'This is a placeholder for the $title. It would contain detailed information about the terms of service or privacy policy. All data collected is used to enhance your shopping experience and will not be shared with third parties without your explicit consent. Your privacy is our top priority.',
          style: AppTypography.bodyText,
        ),
      ],
    );
  }
}
