import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _paymentMethod = 'Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.light,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.padding(context, 16)),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  title: 'Contact Information',
                  child: _buildContactInfo(),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Payment Method',
                  child: _buildPaymentMethods(),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Order Summary',
                  child: _buildOrderSummary(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(Responsive.padding(context, 20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: Responsive.fontSize(context, 18), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone_outlined, color: AppColors.grey),
        hintText: 'Phone Number',
        filled: true,
        fillColor: AppColors.light,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      children: [
        _buildPaymentOption(
          icon: Icons.credit_card,
          label: 'Card',
        ),
        const SizedBox(height: 12),
        _buildPaymentOption(
          icon: Icons.money,
          label: 'Cash',
        ),
        const SizedBox(height: 12),
        _buildPaymentOption(
          icon: Icons.wallet_outlined,
          label: 'Digital Wallet',
        ),
      ],
    );
  }

  Widget _buildPaymentOption({required IconData icon, required String label}) {
    final bool isSelected = _paymentMethod == label;
    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withAlpha(26) : AppColors.light,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.lightGrey,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.primary : AppColors.dark,
                ),
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    // Mock data, in a real app you'd pass this from the cart
    const double subtotal = 35.97;
    const double tax = 3.60;
    const double deliveryFee = 2.99;
    const double total = 42.56;

    return Column(
      children: [
        _buildPriceRow('Subtotal', subtotal),
        const SizedBox(height: 8),
        _buildPriceRow('Tax', tax),
        const SizedBox(height: 8),
        _buildPriceRow('Delivery Fee', deliveryFee),
        const Divider(height: 32),
        _buildPriceRow('Total', total, isTotal: true),
      ],
    );
  }

  Widget _buildPriceRow(String label, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? Responsive.fontSize(context, 18) : Responsive.fontSize(context, 14),
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.dark : AppColors.grey,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? Responsive.fontSize(context, 20) : Responsive.fontSize(context, 16),
            fontWeight: FontWeight.bold,
            color: isTotal ? AppColors.primary : AppColors.dark,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Logic to place order
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Place Order',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}