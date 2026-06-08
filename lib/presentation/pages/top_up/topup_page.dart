import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/dialog_helper.dart';
import '../../../common/snackbar_helper.dart';
import '../../controllers/topup_controller.dart';

@RoutePage()
class TopupPage extends ConsumerStatefulWidget {
  const TopupPage({super.key});

  @override
  ConsumerState<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends ConsumerState<TopupPage> {
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<String> amountTopup = ValueNotifier<String>('');
  final List<int> amountOptions = const [
    10000,
    20000,
    50000,
    100000,
    250000,
    500000
  ];

  // Menyimpan nominal top up terakhir agar dapat ditampilkan pada
  // notifikasi keberhasilan (aksi top up bertipe `AsyncValue<void>`).
  String _lastAmount = '0';

  @override
  void dispose() {
    controller.dispose();
    amountTopup.dispose();
    super.dispose();
  }

  void _onTopup(String value) {
    DialogHelper.showConfirmationDialog(
      context: context,
      message: 'Anda yakin untuk Top Up sebesar',
      amount: formatNumber(value) ?? '0',
      confirmText: 'Ya, lanjutkan Top Up',
    ).then((confirmed) {
      if (confirmed) {
        _lastAmount = value;
        ref.read(topupActionProvider.notifier).topup(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final balanceState = ref.watch(topupBalanceProvider);
    final topupState = ref.watch(topupActionProvider);

    ref.listen<AsyncValue<void>>(topupActionProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          if (previous is AsyncLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SnackbarHelper.showSnackBar(
                context,
                'Top Up sebesar Rp ${formatNumber(_lastAmount) ?? '0'} berhasil',
                Colors.green,
              );
              controller.clear();
              amountTopup.value = '';
            });
          }
        },
        error: (error, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            SnackbarHelper.showSnackBar(context, error.toString(), Colors.red);
          });
        },
      );
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildBalanceCard(balanceState),
          const Spacer(),
          _buildTopupTitle(),
          const Spacer(),
          _buildTopupInput(controller, amountTopup),
          const Spacer(),
          _buildAmountOptionsGrid(amountOptions, controller, amountTopup),
          const Spacer(),
          _buildTopupButton(topupState),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(AsyncValue<String> balanceState) {
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
          balanceState.when(
            data: (balance) => Text.rich(
              TextSpan(
                text: 'Rp ',
                style: const TextStyle(fontSize: 32, color: Colors.white),
                children: [
                  TextSpan(
                    text: formatNumber(balance),
                    style: const TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 3),
              ),
            ),
            error: (error, _) => const Text(
              'Gagal memuat saldo',
              style: TextStyle(fontSize: 20, color: Colors.white),
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

  Widget _buildTopupButton(AsyncValue<void> topupState) {
    return ValueListenableBuilder<String>(
      valueListenable: amountTopup,
      builder: (context, amount, child) {
        if (topupState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final value = amount.replaceAll('.', '');
        final number = int.tryParse(value) ?? 0;
        final isValid = value.isNotEmpty && number >= 10000 && number <= 1000000;
        return ElevatedButton(
          onPressed: isValid ? () => _onTopup(value) : null,
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
