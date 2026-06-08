import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sims_ppob/app_router.gr.dart';
import 'package:sims_ppob/data/models/banner_model.dart';
import 'package:sims_ppob/data/models/service_model.dart';
import 'package:sims_ppob/presentation/controllers/dashboard_controller.dart';

@RoutePage()
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider granular baru berbasis codegen
    final userAsync = ref.watch(userControllerProvider);
    final balanceAsync = ref.watch(balanceControllerProvider);
    final bannerAsync = ref.watch(bannerControllerProvider);
    final serviceAsync = ref.watch(serviceControllerProvider);
    final hideSaldo = ref.watch(dashboardUiProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Render logo dan welcome message berdasarkan userAsync
            userAsync.when(
              data: (user) => Column(
                children: [
                  _buildLogo(user.profileImage),
                  const SizedBox(height: 24),
                  _buildWelcomeMessage(user.firstName, user.lastName),
                ],
              ),
              loading: () => Column(
                children: [
                  _buildLogo(null),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(),
                ],
              ),
              error: (e, _) => Column(
                children: [
                  _buildLogo(null),
                  const SizedBox(height: 24),
                  Text('Error: ${e.toString()}',
                      style: const TextStyle(color: Colors.red)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Render balance card dengan balanceAsync
            _buildBalanceCard(context, ref, balanceAsync, hideSaldo),
            const SizedBox(height: 24),
            // Render service grid dengan serviceAsync
            _buildServiceGrid(ref, serviceAsync),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Temukan promo menarik',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            ),
            const SizedBox(height: 24),
            // Render banner list dengan bannerAsync
            _buildBannerList(bannerAsync),
          ],
        ),
      ),
    );
  }

  static Widget _buildLogo(String? imageUrl) {
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

  static Widget _buildWelcomeMessage(String? firstName, String? lastName) {
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

  static Widget _buildBalanceCard(
      BuildContext context, WidgetRef ref, AsyncValue<String> balanceAsync, bool hideSaldo) {
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
            child: balanceAsync.when(
              data: (balance) {
                final balanceText = hideSaldo
                    ? '••••••••'
                    : 'Rp ${formatNumber(balance) ?? '0'}';
                return Text(
                  balanceText,
                  style: const TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                );
              },
              loading: () => const SizedBox(
                height: 40,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
              error: (e, _) => Text(
                'Error: ${e.toString()}',
                style: const TextStyle(
                    fontSize: 16, color: Colors.white70),
              ),
            ),
          ),
          Row(children: [
            const Text('Lihat saldo',
                style: TextStyle(fontSize: 15, color: Colors.white)),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => ref.read(dashboardUiProvider.notifier).toggle(),
              icon: Icon(
                  hideSaldo
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.white),
            ),
          ]),
        ],
      ),
    );
  }

  static Widget _buildServiceGrid(WidgetRef ref, AsyncValue<List<ServiceModel>> serviceAsync) {
    return serviceAsync.when(
      data: (services) => GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            childAspectRatio: 1.0,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            mainAxisExtent: 90),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return _buildServiceItem(ref, service);
        },
      ),
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Error: ${e.toString()}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  static Widget _buildServiceItem(WidgetRef ref, ServiceModel service) {
    final label = cleanServiceName(service.serviceName);
    return Column(
      children: [
        Builder(
          builder: (context) => InkWell(
            onTap: () => context.router
                .push(PurchesRoute(serviceModel: service))
                .then((value) =>
                    ref.invalidate(balanceControllerProvider)), // Refresh saldo setelah transaksi
            child: Image.network(service.serviceIcon ?? '',
                errorBuilder: (_, __, ___) =>
                    Image.asset('assets/icons/$label.png'),
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
        ),
        Text(label,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis),
      ],
    );
  }

  static Widget _buildBannerList(AsyncValue<List<BannerModel>> bannerAsync) {
    return bannerAsync.when(
      data: (banners) => SizedBox(
        height: 130,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final banner = banners[index];
            return Image.network(banner.bannerImage ?? '',
                errorBuilder: (_, __, ___) =>
                    Image.asset('assets/icons/Banner-${index + 1}.png'),
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                });
          },
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemCount: banners.length,
        ),
      ),
      loading: () => const SizedBox(
        height: 130,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SizedBox(
        height: 130,
        child: Center(
          child: Text(
            'Error: ${e.toString()}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  static String cleanServiceName(String? name) {
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
