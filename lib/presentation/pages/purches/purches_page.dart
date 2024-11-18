import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/dialog_helper.dart';
import '../../../common/result_state.dart';
import '../../../data/models/service_model.dart';
import '../../controllers/purches_controller.dart';
import '../../providers/purches_provider.dart';

@RoutePage()
class PurchesPage extends ConsumerStatefulWidget {
  final ServiceModel serviceModel;
  const PurchesPage(this.serviceModel, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PurchesPageState();
}

class _PurchesPageState extends ConsumerState<PurchesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(purchesProvider.notifier).initState());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(purchesProvider);

    ref.listen(purchesProvider, (previous, next) {
      if (previous?.purchesResult != next.purchesResult &&
          next.purchesResult?.status != Status.LOADING) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DialogHelper.showResulDialog(
            context: context,
            message: 'Permayaran ${widget.serviceModel.serviceName} sebesar',
            amount: formatNumber(widget.serviceModel.serviceTariff) ?? '0',
            status: next.purchesResult!.status,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        });
      }
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
            _buildBalanceCard(state),
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
            _buildPurchesButton(ref),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(PurchesState state) {
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

  Widget _buildPurchesButton(WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => DialogHelper.showConfirmationDialog(
              context: context,
              message: 'Beli ${widget.serviceModel.serviceName} senilai',
              amount: formatNumber(widget.serviceModel.serviceTariff) ?? '0',
              confirmText: 'Ya, lanjutkan Bayar')
          .then((next) => next
              ? ref
                  .read(purchesProvider.notifier)
                  .purchesEvent(widget.serviceModel.serviceCode!)
              : null),
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
