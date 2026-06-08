import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/dialog_helper.dart';
import '../../../data/models/service_model.dart';
import '../../controllers/purches_controller.dart';

@RoutePage()
class PurchesPage extends ConsumerStatefulWidget {
  final ServiceModel serviceModel;
  const PurchesPage(this.serviceModel, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PurchesPageState();
}

class _PurchesPageState extends ConsumerState<PurchesPage> {
  @override
  Widget build(BuildContext context) {
    final balanceState = ref.watch(purchesBalanceProvider);
    final purchesState = ref.watch(purchesActionProvider);

    ref.listen<AsyncValue<void>>(purchesActionProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          if (previous is AsyncLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              DialogHelper.showResulDialog(
                context: context,
                message: 'Permayaran ${widget.serviceModel.serviceName} sebesar',
                amount: formatNumber(widget.serviceModel.serviceTariff) ?? '0',
                isSuccess: true,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              );
            });
          }
        },
        error: (error, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            DialogHelper.showResulDialog(
              context: context,
              message: 'Permayaran ${widget.serviceModel.serviceName} sebesar',
              amount: formatNumber(widget.serviceModel.serviceTariff) ?? '0',
              isSuccess: false,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          });
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text('PemBayaran',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildBalanceCard(balanceState),
            const Spacer(flex: 1),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('PemBayaran \n', style: TextStyle(fontSize: 16)),
            ),
            Row(
              children: [
                Image.network(widget.serviceModel.serviceIcon ?? '', width: 40,
                    loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                }),
                const SizedBox(width: 12),
                Text(
                  widget.serviceModel.serviceName ?? '-',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 32),
            _buildPurchesInput(
                (widget.serviceModel.serviceTariff ?? 0).toString()),
            const Spacer(flex: 4),
            _buildPurchesButton(purchesState),
            const Spacer(flex: 2),
          ],
        ),
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

  Widget _buildPurchesInput(String initialValue) {
    return TextFormField(
        initialValue: formatNumber(initialValue),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.money_outlined, color: Colors.grey),
          hintText: 'Masukan nominal top up',
        ),
        keyboardType: TextInputType.number,
        readOnly: true,
        autovalidateMode: AutovalidateMode.onUserInteraction);
  }

  Widget _buildPurchesButton(AsyncValue<void> purchesState) {
    if (purchesState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ElevatedButton(
      onPressed: () => DialogHelper.showConfirmationDialog(
              context: context,
              message: 'Beli ${widget.serviceModel.serviceName} senilai',
              amount: formatNumber(widget.serviceModel.serviceTariff) ?? '0',
              confirmText: 'Ya, lanjutkan Bayar')
          .then((confirmed) {
        if (confirmed) {
          ref
              .read(purchesActionProvider.notifier)
              .purches(widget.serviceModel.serviceCode!);
        }
      }),
      child: const Text('Bayar'),
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
