import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumpikometr/tmp_repo/chore_repository.dart';
import 'package:lumpikometr/tmp_repo/lumpik_repository.dart';
import 'package:lumpikometr/today_points/bloc/today_points_bloc.dart';

class TodayPointsPage extends StatelessWidget {
  const TodayPointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodayPointsBloc(
        lumpikRepository: LumpikRepository(),
        choreRepository: ChoreRepository(),
      )..add(TodayPointsEnteredEvent()),
      child: const _TodayPointsView(),
    );
  }
}

class _TodayPointsView extends StatelessWidget {
  const _TodayPointsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayPointsBloc, TodayPointsState>(
      builder: (context, state) => switch (state) {
        TodayPointsLoadingState() => const Center(
            child: CircularProgressIndicator(),
          ),
        TodayPointsLoadedState() => DefaultTabController(
            length: state.lumpiks.length,
            child: Column(
              children: [
                TabBar(
                  tabs: state.lumpiks
                      .map(
                        (lumpik) => Tab(
                          icon: CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: lumpik.iconUrl,
                            ),
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
                Expanded(
                  child: TabBarView(
                    children:
                        state.lumpiks.map((e) => const _CardsColumn()).toList(),
                  ),
                ),
              ],
            ),
          ),
        TodayPointsError() => throw UnimplementedError(),
      },
    );
  }
}

class _CardsColumn extends StatelessWidget {
  const _CardsColumn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _items
          .map(
            (s) => Card.outlined(
              child: _Card(
                title: s,
              ),
            ),
          )
          .toList()
        ..shuffle(),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
            ),
          ),
          Row(
            children: [
              IconButton.filledTonal(
                onPressed: () {},
                icon: const Icon(Icons.add),
                tooltip: 'Increase points',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '12',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              IconButton.filledTonal(
                onPressed: () {},
                icon: const Icon(Icons.remove),
                tooltip: 'Decrease points',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const _items = [
  'Trim houseplants',
  'Sort recycling',
  'Wash bath mats',
  'Backup computer data',
  'Pack lunches',
  'Inspect and repair driveway or walkway cracks',
  'Sanitize computer keyboard',
  'Polish wooden furniture',
  'Shovel snow from the driveway',
  'Sanitize children\'s play toys',
  'Clean out gutters',
  'Update emergency contacts',
  'Sort recycling',
  'Dust lampshades',
  'Disinfect kids\' toys',
  'Organize spices',
  'Set mouse traps',
  'Clean the grill',
  'Donate unused items',
  'Wipe down walls',
  'Remove stains from upholstery',
  'Dust lampshades',
  'Update emergency contacts',
  'Iron clothes',
  'Clean out under sinks',
  'Dust blinds',
  'Check outdoor lights',
  'Scrub the toilet',
  'Plan upcoming birthdays',
];
