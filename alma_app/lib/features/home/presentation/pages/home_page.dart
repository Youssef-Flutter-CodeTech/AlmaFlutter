import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../widgets/home_header.dart';
import '../widgets/user_type_selection.dart';
import '../widgets/service_grid.dart';
import '../widgets/best_deals_section.dart';
import '../widgets/flight_deals.dart';
import '../widgets/home_drawer.dart';
import '../../../trips/presentation/pages/trips_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedUserType = 'Business';
  String selectedTab = 'International';
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: checkColor(
        context: context,
        lightColor: AppColor.whiteInputBg,
        darkColor: AppColor.veryDark,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: AppColor.red,
        unselectedItemColor: checkColor(
          context: context,
          lightColor: AppColor.bodyText,
          darkColor: AppColor.whiteInputBg,
        ),
        backgroundColor: checkColor(
          context: context,
          lightColor: AppColor.bgWhite,
          darkColor: AppColor.veryDark,
        ),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'home.nav_home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.camera_alt),
            label: 'home.nav_trips'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.description),
            label: 'home.nav_approval'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat_bubble),
            label: 'home.nav_concierge'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'home.nav_profile'.tr(),
          ),
        ],
      ),
      drawer: const HomeDrawer(),
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: [
            // Home Tab
            CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: HomeHeader(),
                ),
                SliverToBoxAdapter(
                  child: UserTypeSelection(
                    selectedUserType: selectedUserType,
                    onUserTypeChanged: (type) =>
                        setState(() => selectedUserType = type),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: ServiceGrid(),
                ),
                SliverToBoxAdapter(
                  child: BestDealsSection(
                    selectedTab: selectedTab,
                    onTabChanged: (tab) => setState(() => selectedTab = tab),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: FlightDeals(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: rSpacing(100)), // Bottom padding
                ),
              ],
            ),
            // Trips Tab
            const TripsPage(),
            // Approval Tab
            Center(
              child: Text(
                'home.coming_soon'.tr(),
                style: TextStyle(
                  color: checkColor(
                    context: context,
                    lightColor: AppColor.primaryText,
                    darkColor: AppColor.whiteInputBg,
                  ),
                ),
              ),
            ),
            // Concierge Tab
            Center(
              child: Text(
                'home.coming_soon'.tr(),
                style: TextStyle(
                  color: checkColor(
                    context: context,
                    lightColor: AppColor.primaryText,
                    darkColor: AppColor.whiteInputBg,
                  ),
                ),
              ),
            ),
            // Profile Tab
            Center(
              child: Text(
                'home.coming_soon'.tr(),
                style: TextStyle(
                  color: checkColor(
                    context: context,
                    lightColor: AppColor.primaryText,
                    darkColor: AppColor.whiteInputBg,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
