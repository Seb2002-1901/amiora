import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';
import '../../../data/local/database.dart';
import '../../common/presence_ui.dart';

/// Calendrier : agrège les vraies données — anniversaires (récurrents),
/// promesses à échéance. Vue mois + liste des prochains repères.
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month);
  }

  @override
  Widget build(BuildContext context) {
    final rels = ref.watch(relationshipsProvider);
    final promises = ref.watch(promisesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Calendrier')),
      // Une erreur de la base ne doit jamais passer pour « rien de prévu » :
      // chargement et erreur ont leurs propres états, comme ailleurs.
      body: switch ((rels, promises)) {
        (AsyncError(), _) || (_, AsyncError()) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Quelque chose n'a pas fonctionné",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AmioraSpacing.x4),
                OutlinedButton(
                  onPressed: () => ref
                    ..invalidate(relationshipsProvider)
                    ..invalidate(promisesProvider),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        (
          AsyncData(value: final relList),
          AsyncData(value: final promiseList)
        ) =>
          _body(context, relList, promiseList),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  Widget _body(
    BuildContext context,
    List<Relationship> rels,
    List<Promise> promises,
  ) {
    // Repères du mois affiché : anniversaires + promesses datées.
    final markers = <DateTime, List<(IconData, String)>>{};
    void mark(DateTime day, IconData icon, String label) {
      final key = DateTime(day.year, day.month, day.day);
      markers.putIfAbsent(key, () => []).add((icon, label));
    }

    for (final rel in rels) {
      final birthday = rel.birthday;
      if (birthday != null) {
        final occ = DateTime(_month.year, birthday.month, birthday.day);
        if (occ.month == _month.month) {
          mark(occ, Icons.cake_outlined, 'Anniversaire de ${rel.firstName}');
        }
      }
    }
    for (final p in promises) {
      final due = p.dueDate;
      if (due != null &&
          due.year == _month.year &&
          due.month == _month.month &&
          p.status != 'done') {
        mark(due, Icons.volunteer_activism_outlined, p.title);
      }
    }

    final today = DateTime.now();
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;
    final firstWeekday = DateTime(_month.year, _month.month, 1).weekday;

    final upcoming = markers.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: context.gutter,
        vertical: AmioraSpacing.x2,
      ),
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => setState(
                () => _month = DateTime(_month.year, _month.month - 1),
              ),
            ),
            Expanded(
              child: Text(
                _monthTitle(_month),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => setState(
                () => _month = DateTime(_month.year, _month.month + 1),
              ),
            ),
          ],
        ),
        const SizedBox(height: AmioraSpacing.x2),
        // Grille du mois — fluide, jamais de largeur codée en dur.
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (final d in const ['L', 'M', 'M', 'J', 'V', 'S', 'D'])
              Center(
                child: Text(
                  d,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AmioraColors.text3),
                ),
              ),
            for (var i = 1; i < firstWeekday; i++) const SizedBox.shrink(),
            for (var day = 1; day <= daysInMonth; day++)
              _DayCell(
                day: day,
                isToday: today.year == _month.year &&
                    today.month == _month.month &&
                    today.day == day,
                hasMarker: markers
                    .containsKey(DateTime(_month.year, _month.month, day)),
              ),
          ],
        ),
        const SizedBox(height: AmioraSpacing.x4),
        if (upcoming.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AmioraSpacing.x6),
            child: Center(
              child: Text(
                'Rien de prévu ce mois-ci.\nLes anniversaires et promesses apparaîtront ici.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AmioraColors.text2),
              ),
            ),
          ),
        for (final entry in upcoming) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AmioraSpacing.x2),
            child: Text(
              frenchDate(entry.key).toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AmioraColors.text3,
                    letterSpacing: 1,
                  ),
            ),
          ),
          for (final (icon, label) in entry.value) ...[
            Card(
              child: ListTile(
                leading: Icon(icon, color: AmioraColors.gold),
                title: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ),
            const SizedBox(height: AmioraSpacing.x2),
          ],
        ],
      ],
    );
  }

  String _monthTitle(DateTime m) {
    const months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre',
    ];
    return '${months[m.month - 1]} ${m.year}';
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.isToday,
    required this.hasMarker,
  });

  final int day;
  final bool isToday;
  final bool hasMarker;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: isToday
            ? const BoxDecoration(
                color: AmioraColors.gold,
                shape: BoxShape.circle,
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: TextStyle(
                fontSize: 14,
                fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                color: isToday ? AmioraColors.onGold : AmioraColors.text,
              ),
            ),
            if (hasMarker && !isToday)
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AmioraColors.gold,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
