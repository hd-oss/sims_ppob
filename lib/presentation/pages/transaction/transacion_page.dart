import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sims_ppob/presentation/controllers/transaction_controller.dart';

@RoutePage()
class TransactionPage extends ConsumerStatefulWidget {
  const TransactionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionPageState();
}

class _TransactionPageState extends ConsumerState<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(historyControllerProvider);
    final balanceState = ref.watch(transactionBalanceProvider);
    final paginationState = ref.watch(transactionPaginationProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildBalanceCard(balanceState),
          const SizedBox(height: 40),
          _buildTopupTitle(),
          const SizedBox(height: 24),
          historyState.when(
            data: (historyData) => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final data = historyData[index];
                  return Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    text: data.transactionType == 'PAYMENT'
                                        ? '- '
                                        : '+ ',
                                    style: TextStyle(
                                        fontSize: 34,
                                        color: data.transactionType == 'PAYMENT'
                                            ? Colors.red
                                            : Colors.green,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Rp.${formatNumber(data.totalAmount)}',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color:
                                                data.transactionType == 'PAYMENT'
                                                    ? Colors.red
                                                    : Colors.green,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                data.description ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Text(
                            data.createdOn ?? '',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ));
                },
                separatorBuilder: (_, __) => const SizedBox(
                      height: 12,
                    ),
                itemCount: historyData.length),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: 16),
          paginationState.isShowMore
              ? const Center(child: CircularProgressIndicator())
              : TextButton(
                  onPressed: () => ref
                      .read(transactionPaginationProvider.notifier)
                      .nextPage(),
                  child: const Text(
                    'Show More',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ))
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
            loading: () => const CircularProgressIndicator(color: Colors.white),
            error: (error, stack) => Text(
              'Error: $error',
              style: const TextStyle(color: Colors.white),
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
          text: 'Transaksi',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          children: [
            // TextSpan(
            //   text: 'Nominal Top Up',
            //   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
      ),
    );
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
