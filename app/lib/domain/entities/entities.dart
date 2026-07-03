/// Entités du domaine AMIORA — Dart pur, aucune dépendance Flutter.
/// Miroir métier du schéma serveur (docs/sprint-0/04-schema.sql).
library;

enum RelationshipCategory { partner, family, friend, child, mentor, professional, other }

enum RelationshipStatus { active, archived, inMemoriam }

enum InteractionType { call, message, meal, outing, trip, visit, gift, moment, photo, event }

enum InteractionQuality { difficult, okay, good, excellent }

enum MemoryType { photo, note, album }

enum PromiseStatus { todo, inProgress, done }

enum ImportantDateType { birthday, firstMeeting, firstDate, wedding, engagement, birth, graduation, custom }

class Relationship {
  const Relationship({
    required this.id,
    required this.firstName,
    required this.category,
    required this.status,
    required this.cadenceDays,
    required this.createdAt,
    this.lastName,
    this.archivedAt,
    this.birthday,
    this.phone,
    this.email,
    this.address,
    this.job,
    this.notes,
  });

  final String id;
  final String firstName;
  final String? lastName;
  final RelationshipCategory category;
  final RelationshipStatus status;

  /// Cadence d'attention attendue en jours (P) — modifiable par relation,
  /// défaut selon la catégorie (livrable 01 § 2.1).
  final int cadenceDays;
  final DateTime createdAt;
  final DateTime? archivedAt;
  final DateTime? birthday;
  final String? phone;
  final String? email;
  final String? address;
  final String? job;
  final String? notes;
}

class Interaction {
  const Interaction({
    required this.id,
    required this.type,
    required this.occurredAt,
    required this.participantIds,
    this.durationMinutes,
    this.quality,
    this.location,
    this.note,
  });

  final String id;
  final InteractionType type;
  final DateTime occurredAt;

  /// Une interaction multi-personnes compte à part entière pour chaque
  /// participant (livrable 01 § 2.4).
  final List<String> participantIds;
  final int? durationMinutes;
  final InteractionQuality? quality;
  final String? location;
  final String? note;
}

class Memory {
  const Memory({
    required this.id,
    required this.type,
    required this.relationshipIds,
    required this.createdAt,
    this.title,
    this.body,
  });

  final String id;
  final MemoryType type;
  final List<String> relationshipIds;
  final DateTime createdAt;
  final String? title;
  final String? body;
}

class Promise {
  const Promise({
    required this.id,
    required this.relationshipId,
    required this.title,
    required this.status,
    this.dueDate,
    this.priority,
  });

  final String id;
  final String relationshipId;
  final String title;
  final PromiseStatus status;
  final DateTime? dueDate;
  final int? priority;
}

class ImportantDate {
  const ImportantDate({
    required this.id,
    required this.relationshipId,
    required this.type,
    required this.date,
    required this.recursAnnually,
    this.label,
  });

  final String id;
  final String relationshipId;
  final ImportantDateType type;
  final DateTime date;
  final bool recursAnnually;
  final String? label;
}

class PresenceSnapshot {
  const PresenceSnapshot({
    required this.relationshipId,
    required this.date,
    required this.scoreCalc,
    required this.scoreDisplay,
  });

  final String relationshipId;
  final DateTime date;
  final int scoreCalc;
  final int scoreDisplay;
}
