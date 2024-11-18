import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/dialog_helper.dart';
import '../../../common/result_state.dart';
import '../../controllers/topup_controller.dart';
import '../../providers/topup_provider.dart';

@RoutePage()
class TopupPage extends ConsumerWidget {
  const TopupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    final amountTopup = ValueNotifier<String>('');
    final state = ref.watch(topupProvider);
    final amountOptions = [10000, 20000, 50000, 100000, 250000, 500000];

    ref.listen(topupProvider, (previous, next) {
      if (previous?.topupResult != next.topupResult &&
          next.topupResult?.status != Status.LOADING) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DialogHelper.showResulDialog(
              context: context,
              message: 'Top Up sebesar',
              amount: next.topupResult?.data ?? '0',
              status: next.topupResult!.status);
        });
      }
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildBalanceCard(state),
          const Spacer(),
          _buildTopupTitle(),
          const Spacer(),
          _buildTopupInput(controller, amountTopup),
          const Spacer(),
          _buildAmountOptionsGrid(amountOptions, controller, amountTopup),
          const Spacer(),
          _buildTopupButton(amountTopup, ref),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(TopupState state) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xffec392e), Color(0xffd13026)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saldo anda',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              text: 'Rp ',
              style: const TextStyle(fontSize: 32, color: Colors.white),
              children: [
                TextSpan(
                  text: formatNumber(state.balanceData?.data),
                  style: const TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopupTitle() {
    return const Align(
      alignment: Alignment.bottomLeft,
      child: Text.rich(
        TextSpan(
          text: 'Silahkan masukan \n',
          style: TextStyle(fontSize: 24),
          children: [
            TextSpan(
              text: 'Nominal Top Up',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopupInput(
    TextEditingController controller,
    ValueNotifier<String> amountTopup,
  ) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.money_outlined, color: Colors.grey),
        hintText: 'Masukan nominal top up',
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) => amountTopup.value = value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [_amountInputFormatter()],
      validator: _validateAmount,
    );
  }

  TextInputFormatter _amountInputFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
      if (newValue.text.isEmpty) return newValue;
      return TextEditingValue(
        text: formatNumber(newText) ?? '',
        selection: TextSelection.collapsed(offset: newText.length),
      );
    });
  }

  Widget _buildAmountOptionsGrid(
    List<int> amounts,
    TextEditingController controller,
    ValueNotifier<String> amountTopup,
  ) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        mainAxisExtent: 50,
      ),
      itemCount: amounts.length,
      itemBuilder: (context, index) {
        final amount = amounts[index];
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey,
            side: const BorderSide(color: Colors.grey, width: 2),
          ),
          onPressed: () {
            amountTopup.value = amount.toString();
            controller.text = formatNumber(amount) ?? '';
          },
          child: Text(formatNumber(amount) ?? ''),
        );
      },
    );
  }

  Widget _buildTopupButton(ValueNotifier<String> amountTopup, WidgetRef ref) {
    return ValueListenableBuilder<String>(
      valueListenable: amountTopup,
      builder: (context, amount, child) {
        final value = amount.replaceAll('.','');
        return ElevatedButton(
          onPressed: value.isNotEmpty &&
                  int.parse(value) >= 10000 &&
                  int.parse(value) <= 1000000
              ? () => DialogHelper.showConfirmationDialog(
                      context: context,
                      message: 'Anda yakin untuk Top Up sebesar',
                      amount: formatNumber(value) ?? '0',
                      confirmText: 'Ya, lanjutkan Top Up')
                  .then((next) => next
                      ? ref.read(topupProvider.notifier).topupEvent(value)
                      : null)
              : null,
          child: const Text('Top Up'),
        );
      },
    );
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) return null;
    final cleanValue = value.replaceAll(RegExp(r'[^\d]'), '');
    final number = int.tryParse(cleanValue) ?? 0;
    if (number < 10000) return 'Minimal nominal Rp 10.000';
    if (number > 1000000) return 'Maksimal nominal Rp 1.000.000';
    return null;
  }

  static String? formatNumber(dynamic number) {
    if (number != null) {
      final value = (number is String)
          ? double.tryParse(number.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0
          : (number as num).toDouble();
      return NumberFormat('#,##0', 'id').format(value);
    }
    return null;
  }
}
