import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumpikometr/home/cubit/home_cubit.dart';
import 'package:lumpikometr/home/models/homepage_item.dart';
import 'package:lumpikometr/login/bloc/login_bloc.dart';
import 'package:lumpikometr/news/news.dart';
import 'package:lumpikometr/settings/settings.dart';
import 'package:lumpikometr/stats/stats.dart';
import 'package:lumpikometr/today_points/today_points.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() => MaterialPageRoute(builder: (_) => const HomePage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final List<HomepageItem> items = [
    HomepageItem(
        index: 0,
        widgetBuilder: () => const TodayPointsPage(),
        icon: Icons.list_outlined,
        activeIcon: Icons.list,
        label: 'Todos'),
    HomepageItem(
        index: 1,
        widgetBuilder: () => const StatsPage(),
        icon: Icons.bar_chart_outlined,
        activeIcon: Icons.bar_chart,
        label: 'Stats'),
    HomepageItem(
        index: 2,
        widgetBuilder: () => const NewsPage(),
        icon: Icons.article_outlined,
        activeIcon: Icons.article,
        label: 'News'),
    HomepageItem(
        index: 3,
        widgetBuilder: () => const SettingsPage(),
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings,
        label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final int index = context.select((HomeCubit c) => c.state.index);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lumpíkometr'),
        actions: [
          IconButton(
            onPressed: () => context.read<LoginBloc>().add(LogoutEvent()),
            icon: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (_, c) => c is LoggedInState,
              builder: (context, state) => CircleAvatar(
                child: CachedNetworkImage(
                  imageUrl: (state as LoggedInState).icon,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primary, secondary) => FadeThroughTransition(
          animation: primary,
          secondaryAnimation: secondary,
          child: child,
        ),
        child: items[index].page,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => context.read<HomeCubit>().setIndex(i),
        destinations: items
            .map(
              (e) => NavigationDestination(
                icon: e.icon,
                label: e.label,
                selectedIcon: e.activeIcon,
              ),
            )
            .toList(),
      ),
    );
  }
}
