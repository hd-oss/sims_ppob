import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sims_ppob/app_router.gr.dart';
import 'package:sims_ppob/data/models/service_model.dart';
import 'package:sims_ppob/presentation/controllers/dashboard_controller.dart';
import 'package:sims_ppob/presentation/providers/dashboard_provider.dart';

@RoutePage()
class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);

    final userData = state.userData?.data;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildLogo(userData?.profileImage),
            const SizedBox(height: 24),
            _buildWelcomeMessage(userData?.firstName, userData?.lastName),
            const SizedBox(height: 24),
            _buildBalanceCard(context, state),
            const SizedBox(height: 24),
            _buildServiceGrid(state),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Temukan promo menarik',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            ),
            const SizedBox(height: 24),
            _buildBannerList(state),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(String? imageUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/icons/Logo.png', width: 25),
        const SizedBox(width: 8),
        const Expanded(
          child: Text(
            'SIMS PPOB',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        CircleAvatar(
          radius: 17.5,
          backgroundImage: imageUrl?.isEmpty ?? true
              ? const AssetImage('assets/icons/Profile Photo-1.png')
              : NetworkImage(imageUrl!) as ImageProvider,
        ),
      ],
    );
  }

  Widget _buildWelcomeMessage(String? firstName, String? lastName) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: 'Selamat datang,\n',
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
          children: [
            TextSpan(
              text: '$firstName $lastName',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, DashboardState state) {
    final balanceText = state.hideSaldo
        ? '••••••••'
        : 'Rp ${formatNumber(state.balanceData?.data) ?? '0'}';
    return Container(
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              balanceText,
              style: const TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(children: [
            const Text('Lihat saldo',
                style: TextStyle(fontSize: 15, color: Colors.white)),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => ref.read(dashboardProvider.notifier).hideSaldo(),
              icon: Icon(
                  state.hideSaldo
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.white),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildServiceGrid(DashboardState state) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          childAspectRatio: 1.0,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          mainAxisExtent: 90),
      itemCount: state.serviceData?.data?.length ?? 0,
      itemBuilder: (context, index) {
        final service = state.serviceData?.data?[index];
        return _buildServiceItem(service!);
      },
    );
  }

  Widget _buildServiceItem(ServiceModel service) {
    final label = cleanServiceName(service.serviceName);
    return Column(
      children: [
        InkWell(
          onTap: () => context.router
              .push(PurchesRoute(serviceModel: service))
              .then(
                  (value) => ref.read(dashboardProvider.notifier).getBalance()),
          child: Image.network(service.serviceIcon ?? '',
              errorBuilder: (_, __, ___) =>
                  Image.asset('assets/icons/$label.png'),
              loadingBuilder: (_, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              }),
        ),
        Text(label,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis),
      ],
    );
  }

  Widget _buildBannerList(DashboardState state) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final banner = state.bannerData?.data?[index];
          return Image.network(banner?.bannerImage ?? '',
              errorBuilder: (_, __, ___) =>
                  Image.asset('assets/icons/Banner-${index + 1}.png'),
              loadingBuilder: (_, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              });
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: state.bannerData?.data?.length ?? 0,
      ),
    );
  }

  String cleanServiceName(String? name) {
    return name
            ?.replaceAll(RegExp(r'Berlangganan|Voucher |Paket|Pajak'), '')
            .trim() ??
        '-';
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
