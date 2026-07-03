// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RelationshipsTable extends Relationships
    with TableInfo<$RelationshipsTable, Relationship> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationshipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _cadenceDaysMeta =
      const VerificationMeta('cadenceDays');
  @override
  late final GeneratedColumn<int> cadenceDays = GeneratedColumn<int>(
      'cadence_days', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _archivedAtMeta =
      const VerificationMeta('archivedAt');
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
      'archived_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
      'birthday', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _jobMeta = const VerificationMeta('job');
  @override
  late final GeneratedColumn<String> job = GeneratedColumn<String>(
      'job', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoLocalPathMeta =
      const VerificationMeta('photoLocalPath');
  @override
  late final GeneratedColumn<String> photoLocalPath = GeneratedColumn<String>(
      'photo_local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        updatedAt,
        deletedAt,
        firstName,
        lastName,
        category,
        status,
        cadenceDays,
        createdAt,
        archivedAt,
        birthday,
        phone,
        email,
        address,
        job,
        notes,
        photoLocalPath
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relationships';
  @override
  VerificationContext validateIntegrity(Insertable<Relationship> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('cadence_days')) {
      context.handle(
          _cadenceDaysMeta,
          cadenceDays.isAcceptableOrUnknown(
              data['cadence_days']!, _cadenceDaysMeta));
    } else if (isInserting) {
      context.missing(_cadenceDaysMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
          _archivedAtMeta,
          archivedAt.isAcceptableOrUnknown(
              data['archived_at']!, _archivedAtMeta));
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('job')) {
      context.handle(
          _jobMeta, job.isAcceptableOrUnknown(data['job']!, _jobMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('photo_local_path')) {
      context.handle(
          _photoLocalPathMeta,
          photoLocalPath.isAcceptableOrUnknown(
              data['photo_local_path']!, _photoLocalPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Relationship map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Relationship(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      cadenceDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cadence_days'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      archivedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}archived_at']),
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birthday']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      job: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}job']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      photoLocalPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}photo_local_path']),
    );
  }

  @override
  $RelationshipsTable createAlias(String alias) {
    return $RelationshipsTable(attachedDatabase, alias);
  }
}

class Relationship extends DataClass implements Insertable<Relationship> {
  final String id;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String firstName;
  final String? lastName;
  final String category;
  final String status;
  final int cadenceDays;
  final DateTime createdAt;
  final DateTime? archivedAt;
  final DateTime? birthday;
  final String? phone;
  final String? email;
  final String? address;
  final String? job;
  final String? notes;
  final String? photoLocalPath;
  const Relationship(
      {required this.id,
      this.updatedAt,
      this.deletedAt,
      required this.firstName,
      this.lastName,
      required this.category,
      required this.status,
      required this.cadenceDays,
      required this.createdAt,
      this.archivedAt,
      this.birthday,
      this.phone,
      this.email,
      this.address,
      this.job,
      this.notes,
      this.photoLocalPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['first_name'] = Variable<String>(firstName);
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    map['category'] = Variable<String>(category);
    map['status'] = Variable<String>(status);
    map['cadence_days'] = Variable<int>(cadenceDays);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<DateTime>(birthday);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || job != null) {
      map['job'] = Variable<String>(job);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoLocalPath != null) {
      map['photo_local_path'] = Variable<String>(photoLocalPath);
    }
    return map;
  }

  RelationshipsCompanion toCompanion(bool nullToAbsent) {
    return RelationshipsCompanion(
      id: Value(id),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      firstName: Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      category: Value(category),
      status: Value(status),
      cadenceDays: Value(cadenceDays),
      createdAt: Value(createdAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      job: job == null && nullToAbsent ? const Value.absent() : Value(job),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      photoLocalPath: photoLocalPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoLocalPath),
    );
  }

  factory Relationship.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Relationship(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      category: serializer.fromJson<String>(json['category']),
      status: serializer.fromJson<String>(json['status']),
      cadenceDays: serializer.fromJson<int>(json['cadenceDays']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      birthday: serializer.fromJson<DateTime?>(json['birthday']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      job: serializer.fromJson<String?>(json['job']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoLocalPath: serializer.fromJson<String?>(json['photoLocalPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'category': serializer.toJson<String>(category),
      'status': serializer.toJson<String>(status),
      'cadenceDays': serializer.toJson<int>(cadenceDays),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'birthday': serializer.toJson<DateTime?>(birthday),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'job': serializer.toJson<String?>(job),
      'notes': serializer.toJson<String?>(notes),
      'photoLocalPath': serializer.toJson<String?>(photoLocalPath),
    };
  }

  Relationship copyWith(
          {String? id,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent(),
          String? firstName,
          Value<String?> lastName = const Value.absent(),
          String? category,
          String? status,
          int? cadenceDays,
          DateTime? createdAt,
          Value<DateTime?> archivedAt = const Value.absent(),
          Value<DateTime?> birthday = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> job = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<String?> photoLocalPath = const Value.absent()}) =>
      Relationship(
        id: id ?? this.id,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        firstName: firstName ?? this.firstName,
        lastName: lastName.present ? lastName.value : this.lastName,
        category: category ?? this.category,
        status: status ?? this.status,
        cadenceDays: cadenceDays ?? this.cadenceDays,
        createdAt: createdAt ?? this.createdAt,
        archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
        birthday: birthday.present ? birthday.value : this.birthday,
        phone: phone.present ? phone.value : this.phone,
        email: email.present ? email.value : this.email,
        address: address.present ? address.value : this.address,
        job: job.present ? job.value : this.job,
        notes: notes.present ? notes.value : this.notes,
        photoLocalPath:
            photoLocalPath.present ? photoLocalPath.value : this.photoLocalPath,
      );
  Relationship copyWithCompanion(RelationshipsCompanion data) {
    return Relationship(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      category: data.category.present ? data.category.value : this.category,
      status: data.status.present ? data.status.value : this.status,
      cadenceDays:
          data.cadenceDays.present ? data.cadenceDays.value : this.cadenceDays,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      archivedAt:
          data.archivedAt.present ? data.archivedAt.value : this.archivedAt,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      job: data.job.present ? data.job.value : this.job,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoLocalPath: data.photoLocalPath.present
          ? data.photoLocalPath.value
          : this.photoLocalPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Relationship(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('category: $category, ')
          ..write('status: $status, ')
          ..write('cadenceDays: $cadenceDays, ')
          ..write('createdAt: $createdAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('birthday: $birthday, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('job: $job, ')
          ..write('notes: $notes, ')
          ..write('photoLocalPath: $photoLocalPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      updatedAt,
      deletedAt,
      firstName,
      lastName,
      category,
      status,
      cadenceDays,
      createdAt,
      archivedAt,
      birthday,
      phone,
      email,
      address,
      job,
      notes,
      photoLocalPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Relationship &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.category == this.category &&
          other.status == this.status &&
          other.cadenceDays == this.cadenceDays &&
          other.createdAt == this.createdAt &&
          other.archivedAt == this.archivedAt &&
          other.birthday == this.birthday &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.job == this.job &&
          other.notes == this.notes &&
          other.photoLocalPath == this.photoLocalPath);
}

class RelationshipsCompanion extends UpdateCompanion<Relationship> {
  final Value<String> id;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> firstName;
  final Value<String?> lastName;
  final Value<String> category;
  final Value<String> status;
  final Value<int> cadenceDays;
  final Value<DateTime> createdAt;
  final Value<DateTime?> archivedAt;
  final Value<DateTime?> birthday;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> job;
  final Value<String?> notes;
  final Value<String?> photoLocalPath;
  final Value<int> rowid;
  const RelationshipsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.category = const Value.absent(),
    this.status = const Value.absent(),
    this.cadenceDays = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.birthday = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.job = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoLocalPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelationshipsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String firstName,
    this.lastName = const Value.absent(),
    required String category,
    this.status = const Value.absent(),
    required int cadenceDays,
    required DateTime createdAt,
    this.archivedAt = const Value.absent(),
    this.birthday = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.job = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoLocalPath = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        firstName = Value(firstName),
        category = Value(category),
        cadenceDays = Value(cadenceDays),
        createdAt = Value(createdAt);
  static Insertable<Relationship> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? category,
    Expression<String>? status,
    Expression<int>? cadenceDays,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? archivedAt,
    Expression<DateTime>? birthday,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? job,
    Expression<String>? notes,
    Expression<String>? photoLocalPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (category != null) 'category': category,
      if (status != null) 'status': status,
      if (cadenceDays != null) 'cadence_days': cadenceDays,
      if (createdAt != null) 'created_at': createdAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (birthday != null) 'birthday': birthday,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (job != null) 'job': job,
      if (notes != null) 'notes': notes,
      if (photoLocalPath != null) 'photo_local_path': photoLocalPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelationshipsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? firstName,
      Value<String?>? lastName,
      Value<String>? category,
      Value<String>? status,
      Value<int>? cadenceDays,
      Value<DateTime>? createdAt,
      Value<DateTime?>? archivedAt,
      Value<DateTime?>? birthday,
      Value<String?>? phone,
      Value<String?>? email,
      Value<String?>? address,
      Value<String?>? job,
      Value<String?>? notes,
      Value<String?>? photoLocalPath,
      Value<int>? rowid}) {
    return RelationshipsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      category: category ?? this.category,
      status: status ?? this.status,
      cadenceDays: cadenceDays ?? this.cadenceDays,
      createdAt: createdAt ?? this.createdAt,
      archivedAt: archivedAt ?? this.archivedAt,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      job: job ?? this.job,
      notes: notes ?? this.notes,
      photoLocalPath: photoLocalPath ?? this.photoLocalPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (cadenceDays.present) {
      map['cadence_days'] = Variable<int>(cadenceDays.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (job.present) {
      map['job'] = Variable<String>(job.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoLocalPath.present) {
      map['photo_local_path'] = Variable<String>(photoLocalPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationshipsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('category: $category, ')
          ..write('status: $status, ')
          ..write('cadenceDays: $cadenceDays, ')
          ..write('createdAt: $createdAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('birthday: $birthday, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('job: $job, ')
          ..write('notes: $notes, ')
          ..write('photoLocalPath: $photoLocalPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InteractionsTable extends Interactions
    with TableInfo<$InteractionsTable, Interaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InteractionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _occurredAtMeta =
      const VerificationMeta('occurredAt');
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
      'occurred_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _qualityMeta =
      const VerificationMeta('quality');
  @override
  late final GeneratedColumn<String> quality = GeneratedColumn<String>(
      'quality', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        updatedAt,
        deletedAt,
        type,
        occurredAt,
        durationMinutes,
        quality,
        location,
        note
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'interactions';
  @override
  VerificationContext validateIntegrity(Insertable<Interaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
          _occurredAtMeta,
          occurredAt.isAcceptableOrUnknown(
              data['occurred_at']!, _occurredAtMeta));
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    }
    if (data.containsKey('quality')) {
      context.handle(_qualityMeta,
          quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Interaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Interaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      occurredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}occurred_at'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes']),
      quality: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}quality']),
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $InteractionsTable createAlias(String alias) {
    return $InteractionsTable(attachedDatabase, alias);
  }
}

class Interaction extends DataClass implements Insertable<Interaction> {
  final String id;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String type;
  final DateTime occurredAt;
  final int? durationMinutes;
  final String? quality;
  final String? location;
  final String? note;
  const Interaction(
      {required this.id,
      this.updatedAt,
      this.deletedAt,
      required this.type,
      required this.occurredAt,
      this.durationMinutes,
      this.quality,
      this.location,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['type'] = Variable<String>(type);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || quality != null) {
      map['quality'] = Variable<String>(quality);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  InteractionsCompanion toCompanion(bool nullToAbsent) {
    return InteractionsCompanion(
      id: Value(id),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      type: Value(type),
      occurredAt: Value(occurredAt),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      quality: quality == null && nullToAbsent
          ? const Value.absent()
          : Value(quality),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Interaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Interaction(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      type: serializer.fromJson<String>(json['type']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      quality: serializer.fromJson<String?>(json['quality']),
      location: serializer.fromJson<String?>(json['location']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'type': serializer.toJson<String>(type),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'quality': serializer.toJson<String?>(quality),
      'location': serializer.toJson<String?>(location),
      'note': serializer.toJson<String?>(note),
    };
  }

  Interaction copyWith(
          {String? id,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent(),
          String? type,
          DateTime? occurredAt,
          Value<int?> durationMinutes = const Value.absent(),
          Value<String?> quality = const Value.absent(),
          Value<String?> location = const Value.absent(),
          Value<String?> note = const Value.absent()}) =>
      Interaction(
        id: id ?? this.id,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        type: type ?? this.type,
        occurredAt: occurredAt ?? this.occurredAt,
        durationMinutes: durationMinutes.present
            ? durationMinutes.value
            : this.durationMinutes,
        quality: quality.present ? quality.value : this.quality,
        location: location.present ? location.value : this.location,
        note: note.present ? note.value : this.note,
      );
  Interaction copyWithCompanion(InteractionsCompanion data) {
    return Interaction(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      type: data.type.present ? data.type.value : this.type,
      occurredAt:
          data.occurredAt.present ? data.occurredAt.value : this.occurredAt,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      quality: data.quality.present ? data.quality.value : this.quality,
      location: data.location.present ? data.location.value : this.location,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Interaction(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('type: $type, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('quality: $quality, ')
          ..write('location: $location, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, updatedAt, deletedAt, type, occurredAt,
      durationMinutes, quality, location, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Interaction &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.type == this.type &&
          other.occurredAt == this.occurredAt &&
          other.durationMinutes == this.durationMinutes &&
          other.quality == this.quality &&
          other.location == this.location &&
          other.note == this.note);
}

class InteractionsCompanion extends UpdateCompanion<Interaction> {
  final Value<String> id;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> type;
  final Value<DateTime> occurredAt;
  final Value<int?> durationMinutes;
  final Value<String?> quality;
  final Value<String?> location;
  final Value<String?> note;
  final Value<int> rowid;
  const InteractionsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.type = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.quality = const Value.absent(),
    this.location = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InteractionsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String type,
    required DateTime occurredAt,
    this.durationMinutes = const Value.absent(),
    this.quality = const Value.absent(),
    this.location = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        occurredAt = Value(occurredAt);
  static Insertable<Interaction> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? type,
    Expression<DateTime>? occurredAt,
    Expression<int>? durationMinutes,
    Expression<String>? quality,
    Expression<String>? location,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (type != null) 'type': type,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (quality != null) 'quality': quality,
      if (location != null) 'location': location,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InteractionsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? type,
      Value<DateTime>? occurredAt,
      Value<int?>? durationMinutes,
      Value<String?>? quality,
      Value<String?>? location,
      Value<String?>? note,
      Value<int>? rowid}) {
    return InteractionsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      type: type ?? this.type,
      occurredAt: occurredAt ?? this.occurredAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      quality: quality ?? this.quality,
      location: location ?? this.location,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (quality.present) {
      map['quality'] = Variable<String>(quality.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InteractionsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('type: $type, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('quality: $quality, ')
          ..write('location: $location, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InteractionParticipantsTable extends InteractionParticipants
    with TableInfo<$InteractionParticipantsTable, InteractionParticipant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InteractionParticipantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _interactionIdMeta =
      const VerificationMeta('interactionId');
  @override
  late final GeneratedColumn<String> interactionId = GeneratedColumn<String>(
      'interaction_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES interactions (id)'));
  static const VerificationMeta _relationshipIdMeta =
      const VerificationMeta('relationshipId');
  @override
  late final GeneratedColumn<String> relationshipId = GeneratedColumn<String>(
      'relationship_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES relationships (id)'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [interactionId, relationshipId, deletedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'interaction_participants';
  @override
  VerificationContext validateIntegrity(
      Insertable<InteractionParticipant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('interaction_id')) {
      context.handle(
          _interactionIdMeta,
          interactionId.isAcceptableOrUnknown(
              data['interaction_id']!, _interactionIdMeta));
    } else if (isInserting) {
      context.missing(_interactionIdMeta);
    }
    if (data.containsKey('relationship_id')) {
      context.handle(
          _relationshipIdMeta,
          relationshipId.isAcceptableOrUnknown(
              data['relationship_id']!, _relationshipIdMeta));
    } else if (isInserting) {
      context.missing(_relationshipIdMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {interactionId, relationshipId};
  @override
  InteractionParticipant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InteractionParticipant(
      interactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}interaction_id'])!,
      relationshipId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}relationship_id'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $InteractionParticipantsTable createAlias(String alias) {
    return $InteractionParticipantsTable(attachedDatabase, alias);
  }
}

class InteractionParticipant extends DataClass
    implements Insertable<InteractionParticipant> {
  final String interactionId;
  final String relationshipId;
  final DateTime? deletedAt;
  const InteractionParticipant(
      {required this.interactionId,
      required this.relationshipId,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['interaction_id'] = Variable<String>(interactionId);
    map['relationship_id'] = Variable<String>(relationshipId);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  InteractionParticipantsCompanion toCompanion(bool nullToAbsent) {
    return InteractionParticipantsCompanion(
      interactionId: Value(interactionId),
      relationshipId: Value(relationshipId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory InteractionParticipant.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InteractionParticipant(
      interactionId: serializer.fromJson<String>(json['interactionId']),
      relationshipId: serializer.fromJson<String>(json['relationshipId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'interactionId': serializer.toJson<String>(interactionId),
      'relationshipId': serializer.toJson<String>(relationshipId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  InteractionParticipant copyWith(
          {String? interactionId,
          String? relationshipId,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      InteractionParticipant(
        interactionId: interactionId ?? this.interactionId,
        relationshipId: relationshipId ?? this.relationshipId,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  InteractionParticipant copyWithCompanion(
      InteractionParticipantsCompanion data) {
    return InteractionParticipant(
      interactionId: data.interactionId.present
          ? data.interactionId.value
          : this.interactionId,
      relationshipId: data.relationshipId.present
          ? data.relationshipId.value
          : this.relationshipId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InteractionParticipant(')
          ..write('interactionId: $interactionId, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(interactionId, relationshipId, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InteractionParticipant &&
          other.interactionId == this.interactionId &&
          other.relationshipId == this.relationshipId &&
          other.deletedAt == this.deletedAt);
}

class InteractionParticipantsCompanion
    extends UpdateCompanion<InteractionParticipant> {
  final Value<String> interactionId;
  final Value<String> relationshipId;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const InteractionParticipantsCompanion({
    this.interactionId = const Value.absent(),
    this.relationshipId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InteractionParticipantsCompanion.insert({
    required String interactionId,
    required String relationshipId,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : interactionId = Value(interactionId),
        relationshipId = Value(relationshipId);
  static Insertable<InteractionParticipant> custom({
    Expression<String>? interactionId,
    Expression<String>? relationshipId,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (interactionId != null) 'interaction_id': interactionId,
      if (relationshipId != null) 'relationship_id': relationshipId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InteractionParticipantsCompanion copyWith(
      {Value<String>? interactionId,
      Value<String>? relationshipId,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return InteractionParticipantsCompanion(
      interactionId: interactionId ?? this.interactionId,
      relationshipId: relationshipId ?? this.relationshipId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (interactionId.present) {
      map['interaction_id'] = Variable<String>(interactionId.value);
    }
    if (relationshipId.present) {
      map['relationship_id'] = Variable<String>(relationshipId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InteractionParticipantsCompanion(')
          ..write('interactionId: $interactionId, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlbumsTable extends Albums with TableInfo<$AlbumsTable, Album> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, updatedAt, deletedAt, title, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'albums';
  @override
  VerificationContext validateIntegrity(Insertable<Album> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Album map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Album(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AlbumsTable createAlias(String alias) {
    return $AlbumsTable(attachedDatabase, alias);
  }
}

class Album extends DataClass implements Insertable<Album> {
  final String id;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String title;
  final DateTime createdAt;
  const Album(
      {required this.id,
      this.updatedAt,
      this.deletedAt,
      required this.title,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AlbumsCompanion toCompanion(bool nullToAbsent) {
    return AlbumsCompanion(
      id: Value(id),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      title: Value(title),
      createdAt: Value(createdAt),
    );
  }

  factory Album.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Album(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Album copyWith(
          {String? id,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent(),
          String? title,
          DateTime? createdAt}) =>
      Album(
        id: id ?? this.id,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
      );
  Album copyWithCompanion(AlbumsCompanion data) {
    return Album(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Album(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, updatedAt, deletedAt, title, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Album &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.title == this.title &&
          other.createdAt == this.createdAt);
}

class AlbumsCompanion extends UpdateCompanion<Album> {
  final Value<String> id;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AlbumsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlbumsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String title,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        createdAt = Value(createdAt);
  static Insertable<Album> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlbumsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return AlbumsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MemoriesTable extends Memories with TableInfo<$MemoriesTable, Memory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _takenAtMeta =
      const VerificationMeta('takenAt');
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
      'taken_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _albumIdMeta =
      const VerificationMeta('albumId');
  @override
  late final GeneratedColumn<String> albumId = GeneratedColumn<String>(
      'album_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES albums (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        updatedAt,
        deletedAt,
        type,
        title,
        body,
        createdAt,
        takenAt,
        albumId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memories';
  @override
  VerificationContext validateIntegrity(Insertable<Memory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('taken_at')) {
      context.handle(_takenAtMeta,
          takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta));
    }
    if (data.containsKey('album_id')) {
      context.handle(_albumIdMeta,
          albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Memory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Memory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      takenAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}taken_at']),
      albumId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album_id']),
    );
  }

  @override
  $MemoriesTable createAlias(String alias) {
    return $MemoriesTable(attachedDatabase, alias);
  }
}

class Memory extends DataClass implements Insertable<Memory> {
  final String id;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String type;
  final String? title;
  final String? body;
  final DateTime createdAt;
  final DateTime? takenAt;
  final String? albumId;
  const Memory(
      {required this.id,
      this.updatedAt,
      this.deletedAt,
      required this.type,
      this.title,
      this.body,
      required this.createdAt,
      this.takenAt,
      this.albumId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || takenAt != null) {
      map['taken_at'] = Variable<DateTime>(takenAt);
    }
    if (!nullToAbsent || albumId != null) {
      map['album_id'] = Variable<String>(albumId);
    }
    return map;
  }

  MemoriesCompanion toCompanion(bool nullToAbsent) {
    return MemoriesCompanion(
      id: Value(id),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      type: Value(type),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      createdAt: Value(createdAt),
      takenAt: takenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(takenAt),
      albumId: albumId == null && nullToAbsent
          ? const Value.absent()
          : Value(albumId),
    );
  }

  factory Memory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Memory(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String?>(json['title']),
      body: serializer.fromJson<String?>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      takenAt: serializer.fromJson<DateTime?>(json['takenAt']),
      albumId: serializer.fromJson<String?>(json['albumId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String?>(title),
      'body': serializer.toJson<String?>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'takenAt': serializer.toJson<DateTime?>(takenAt),
      'albumId': serializer.toJson<String?>(albumId),
    };
  }

  Memory copyWith(
          {String? id,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent(),
          String? type,
          Value<String?> title = const Value.absent(),
          Value<String?> body = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> takenAt = const Value.absent(),
          Value<String?> albumId = const Value.absent()}) =>
      Memory(
        id: id ?? this.id,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        type: type ?? this.type,
        title: title.present ? title.value : this.title,
        body: body.present ? body.value : this.body,
        createdAt: createdAt ?? this.createdAt,
        takenAt: takenAt.present ? takenAt.value : this.takenAt,
        albumId: albumId.present ? albumId.value : this.albumId,
      );
  Memory copyWithCompanion(MemoriesCompanion data) {
    return Memory(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      albumId: data.albumId.present ? data.albumId.value : this.albumId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Memory(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('takenAt: $takenAt, ')
          ..write('albumId: $albumId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, updatedAt, deletedAt, type, title, body, createdAt, takenAt, albumId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Memory &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.type == this.type &&
          other.title == this.title &&
          other.body == this.body &&
          other.createdAt == this.createdAt &&
          other.takenAt == this.takenAt &&
          other.albumId == this.albumId);
}

class MemoriesCompanion extends UpdateCompanion<Memory> {
  final Value<String> id;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> type;
  final Value<String?> title;
  final Value<String?> body;
  final Value<DateTime> createdAt;
  final Value<DateTime?> takenAt;
  final Value<String?> albumId;
  final Value<int> rowid;
  const MemoriesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.albumId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MemoriesCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String type,
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    required DateTime createdAt,
    this.takenAt = const Value.absent(),
    this.albumId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        createdAt = Value(createdAt);
  static Insertable<Memory> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? body,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? takenAt,
    Expression<String>? albumId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
      if (takenAt != null) 'taken_at': takenAt,
      if (albumId != null) 'album_id': albumId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MemoriesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? type,
      Value<String?>? title,
      Value<String?>? body,
      Value<DateTime>? createdAt,
      Value<DateTime?>? takenAt,
      Value<String?>? albumId,
      Value<int>? rowid}) {
    return MemoriesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      takenAt: takenAt ?? this.takenAt,
      albumId: albumId ?? this.albumId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    if (albumId.present) {
      map['album_id'] = Variable<String>(albumId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoriesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('takenAt: $takenAt, ')
          ..write('albumId: $albumId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MemoryLinksTable extends MemoryLinks
    with TableInfo<$MemoryLinksTable, MemoryLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoryLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _memoryIdMeta =
      const VerificationMeta('memoryId');
  @override
  late final GeneratedColumn<String> memoryId = GeneratedColumn<String>(
      'memory_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES memories (id)'));
  static const VerificationMeta _relationshipIdMeta =
      const VerificationMeta('relationshipId');
  @override
  late final GeneratedColumn<String> relationshipId = GeneratedColumn<String>(
      'relationship_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES relationships (id)'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [memoryId, relationshipId, deletedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memory_links';
  @override
  VerificationContext validateIntegrity(Insertable<MemoryLink> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('memory_id')) {
      context.handle(_memoryIdMeta,
          memoryId.isAcceptableOrUnknown(data['memory_id']!, _memoryIdMeta));
    } else if (isInserting) {
      context.missing(_memoryIdMeta);
    }
    if (data.containsKey('relationship_id')) {
      context.handle(
          _relationshipIdMeta,
          relationshipId.isAcceptableOrUnknown(
              data['relationship_id']!, _relationshipIdMeta));
    } else if (isInserting) {
      context.missing(_relationshipIdMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {memoryId, relationshipId};
  @override
  MemoryLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoryLink(
      memoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}memory_id'])!,
      relationshipId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}relationship_id'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $MemoryLinksTable createAlias(String alias) {
    return $MemoryLinksTable(attachedDatabase, alias);
  }
}

class MemoryLink extends DataClass implements Insertable<MemoryLink> {
  final String memoryId;
  final String relationshipId;
  final DateTime? deletedAt;
  const MemoryLink(
      {required this.memoryId, required this.relationshipId, this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['memory_id'] = Variable<String>(memoryId);
    map['relationship_id'] = Variable<String>(relationshipId);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  MemoryLinksCompanion toCompanion(bool nullToAbsent) {
    return MemoryLinksCompanion(
      memoryId: Value(memoryId),
      relationshipId: Value(relationshipId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory MemoryLink.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryLink(
      memoryId: serializer.fromJson<String>(json['memoryId']),
      relationshipId: serializer.fromJson<String>(json['relationshipId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'memoryId': serializer.toJson<String>(memoryId),
      'relationshipId': serializer.toJson<String>(relationshipId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  MemoryLink copyWith(
          {String? memoryId,
          String? relationshipId,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      MemoryLink(
        memoryId: memoryId ?? this.memoryId,
        relationshipId: relationshipId ?? this.relationshipId,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  MemoryLink copyWithCompanion(MemoryLinksCompanion data) {
    return MemoryLink(
      memoryId: data.memoryId.present ? data.memoryId.value : this.memoryId,
      relationshipId: data.relationshipId.present
          ? data.relationshipId.value
          : this.relationshipId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemoryLink(')
          ..write('memoryId: $memoryId, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(memoryId, relationshipId, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryLink &&
          other.memoryId == this.memoryId &&
          other.relationshipId == this.relationshipId &&
          other.deletedAt == this.deletedAt);
}

class MemoryLinksCompanion extends UpdateCompanion<MemoryLink> {
  final Value<String> memoryId;
  final Value<String> relationshipId;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const MemoryLinksCompanion({
    this.memoryId = const Value.absent(),
    this.relationshipId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MemoryLinksCompanion.insert({
    required String memoryId,
    required String relationshipId,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : memoryId = Value(memoryId),
        relationshipId = Value(relationshipId);
  static Insertable<MemoryLink> custom({
    Expression<String>? memoryId,
    Expression<String>? relationshipId,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (memoryId != null) 'memory_id': memoryId,
      if (relationshipId != null) 'relationship_id': relationshipId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MemoryLinksCompanion copyWith(
      {Value<String>? memoryId,
      Value<String>? relationshipId,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return MemoryLinksCompanion(
      memoryId: memoryId ?? this.memoryId,
      relationshipId: relationshipId ?? this.relationshipId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (memoryId.present) {
      map['memory_id'] = Variable<String>(memoryId.value);
    }
    if (relationshipId.present) {
      map['relationship_id'] = Variable<String>(relationshipId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoryLinksCompanion(')
          ..write('memoryId: $memoryId, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MediaAssetsTable extends MediaAssets
    with TableInfo<$MediaAssetsTable, MediaAsset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _memoryIdMeta =
      const VerificationMeta('memoryId');
  @override
  late final GeneratedColumn<String> memoryId = GeneratedColumn<String>(
      'memory_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES memories (id)'));
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _storagePathMeta =
      const VerificationMeta('storagePath');
  @override
  late final GeneratedColumn<String> storagePath = GeneratedColumn<String>(
      'storage_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _thumbStoragePathMeta =
      const VerificationMeta('thumbStoragePath');
  @override
  late final GeneratedColumn<String> thumbStoragePath = GeneratedColumn<String>(
      'thumb_storage_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sizeBytesMeta =
      const VerificationMeta('sizeBytes');
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
      'size_bytes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _uploadStatusMeta =
      const VerificationMeta('uploadStatus');
  @override
  late final GeneratedColumn<String> uploadStatus = GeneratedColumn<String>(
      'upload_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        updatedAt,
        deletedAt,
        memoryId,
        localPath,
        storagePath,
        thumbStoragePath,
        sizeBytes,
        uploadStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_assets';
  @override
  VerificationContext validateIntegrity(Insertable<MediaAsset> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('memory_id')) {
      context.handle(_memoryIdMeta,
          memoryId.isAcceptableOrUnknown(data['memory_id']!, _memoryIdMeta));
    } else if (isInserting) {
      context.missing(_memoryIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    }
    if (data.containsKey('storage_path')) {
      context.handle(
          _storagePathMeta,
          storagePath.isAcceptableOrUnknown(
              data['storage_path']!, _storagePathMeta));
    }
    if (data.containsKey('thumb_storage_path')) {
      context.handle(
          _thumbStoragePathMeta,
          thumbStoragePath.isAcceptableOrUnknown(
              data['thumb_storage_path']!, _thumbStoragePathMeta));
    }
    if (data.containsKey('size_bytes')) {
      context.handle(_sizeBytesMeta,
          sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta));
    }
    if (data.containsKey('upload_status')) {
      context.handle(
          _uploadStatusMeta,
          uploadStatus.isAcceptableOrUnknown(
              data['upload_status']!, _uploadStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaAsset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaAsset(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      memoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}memory_id'])!,
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path']),
      storagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}storage_path']),
      thumbStoragePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}thumb_storage_path']),
      sizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size_bytes']),
      uploadStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}upload_status'])!,
    );
  }

  @override
  $MediaAssetsTable createAlias(String alias) {
    return $MediaAssetsTable(attachedDatabase, alias);
  }
}

class MediaAsset extends DataClass implements Insertable<MediaAsset> {
  final String id;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String memoryId;
  final String? localPath;
  final String? storagePath;
  final String? thumbStoragePath;
  final int? sizeBytes;
  final String uploadStatus;
  const MediaAsset(
      {required this.id,
      this.updatedAt,
      this.deletedAt,
      required this.memoryId,
      this.localPath,
      this.storagePath,
      this.thumbStoragePath,
      this.sizeBytes,
      required this.uploadStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['memory_id'] = Variable<String>(memoryId);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || storagePath != null) {
      map['storage_path'] = Variable<String>(storagePath);
    }
    if (!nullToAbsent || thumbStoragePath != null) {
      map['thumb_storage_path'] = Variable<String>(thumbStoragePath);
    }
    if (!nullToAbsent || sizeBytes != null) {
      map['size_bytes'] = Variable<int>(sizeBytes);
    }
    map['upload_status'] = Variable<String>(uploadStatus);
    return map;
  }

  MediaAssetsCompanion toCompanion(bool nullToAbsent) {
    return MediaAssetsCompanion(
      id: Value(id),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      memoryId: Value(memoryId),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      storagePath: storagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(storagePath),
      thumbStoragePath: thumbStoragePath == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbStoragePath),
      sizeBytes: sizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(sizeBytes),
      uploadStatus: Value(uploadStatus),
    );
  }

  factory MediaAsset.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaAsset(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      memoryId: serializer.fromJson<String>(json['memoryId']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      storagePath: serializer.fromJson<String?>(json['storagePath']),
      thumbStoragePath: serializer.fromJson<String?>(json['thumbStoragePath']),
      sizeBytes: serializer.fromJson<int?>(json['sizeBytes']),
      uploadStatus: serializer.fromJson<String>(json['uploadStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'memoryId': serializer.toJson<String>(memoryId),
      'localPath': serializer.toJson<String?>(localPath),
      'storagePath': serializer.toJson<String?>(storagePath),
      'thumbStoragePath': serializer.toJson<String?>(thumbStoragePath),
      'sizeBytes': serializer.toJson<int?>(sizeBytes),
      'uploadStatus': serializer.toJson<String>(uploadStatus),
    };
  }

  MediaAsset copyWith(
          {String? id,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent(),
          String? memoryId,
          Value<String?> localPath = const Value.absent(),
          Value<String?> storagePath = const Value.absent(),
          Value<String?> thumbStoragePath = const Value.absent(),
          Value<int?> sizeBytes = const Value.absent(),
          String? uploadStatus}) =>
      MediaAsset(
        id: id ?? this.id,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        memoryId: memoryId ?? this.memoryId,
        localPath: localPath.present ? localPath.value : this.localPath,
        storagePath: storagePath.present ? storagePath.value : this.storagePath,
        thumbStoragePath: thumbStoragePath.present
            ? thumbStoragePath.value
            : this.thumbStoragePath,
        sizeBytes: sizeBytes.present ? sizeBytes.value : this.sizeBytes,
        uploadStatus: uploadStatus ?? this.uploadStatus,
      );
  MediaAsset copyWithCompanion(MediaAssetsCompanion data) {
    return MediaAsset(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      memoryId: data.memoryId.present ? data.memoryId.value : this.memoryId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      storagePath:
          data.storagePath.present ? data.storagePath.value : this.storagePath,
      thumbStoragePath: data.thumbStoragePath.present
          ? data.thumbStoragePath.value
          : this.thumbStoragePath,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      uploadStatus: data.uploadStatus.present
          ? data.uploadStatus.value
          : this.uploadStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaAsset(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('memoryId: $memoryId, ')
          ..write('localPath: $localPath, ')
          ..write('storagePath: $storagePath, ')
          ..write('thumbStoragePath: $thumbStoragePath, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('uploadStatus: $uploadStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, updatedAt, deletedAt, memoryId, localPath,
      storagePath, thumbStoragePath, sizeBytes, uploadStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaAsset &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.memoryId == this.memoryId &&
          other.localPath == this.localPath &&
          other.storagePath == this.storagePath &&
          other.thumbStoragePath == this.thumbStoragePath &&
          other.sizeBytes == this.sizeBytes &&
          other.uploadStatus == this.uploadStatus);
}

class MediaAssetsCompanion extends UpdateCompanion<MediaAsset> {
  final Value<String> id;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> memoryId;
  final Value<String?> localPath;
  final Value<String?> storagePath;
  final Value<String?> thumbStoragePath;
  final Value<int?> sizeBytes;
  final Value<String> uploadStatus;
  final Value<int> rowid;
  const MediaAssetsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.memoryId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.storagePath = const Value.absent(),
    this.thumbStoragePath = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.uploadStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediaAssetsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String memoryId,
    this.localPath = const Value.absent(),
    this.storagePath = const Value.absent(),
    this.thumbStoragePath = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.uploadStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        memoryId = Value(memoryId);
  static Insertable<MediaAsset> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? memoryId,
    Expression<String>? localPath,
    Expression<String>? storagePath,
    Expression<String>? thumbStoragePath,
    Expression<int>? sizeBytes,
    Expression<String>? uploadStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (memoryId != null) 'memory_id': memoryId,
      if (localPath != null) 'local_path': localPath,
      if (storagePath != null) 'storage_path': storagePath,
      if (thumbStoragePath != null) 'thumb_storage_path': thumbStoragePath,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (uploadStatus != null) 'upload_status': uploadStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediaAssetsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? memoryId,
      Value<String?>? localPath,
      Value<String?>? storagePath,
      Value<String?>? thumbStoragePath,
      Value<int?>? sizeBytes,
      Value<String>? uploadStatus,
      Value<int>? rowid}) {
    return MediaAssetsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      memoryId: memoryId ?? this.memoryId,
      localPath: localPath ?? this.localPath,
      storagePath: storagePath ?? this.storagePath,
      thumbStoragePath: thumbStoragePath ?? this.thumbStoragePath,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (memoryId.present) {
      map['memory_id'] = Variable<String>(memoryId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (storagePath.present) {
      map['storage_path'] = Variable<String>(storagePath.value);
    }
    if (thumbStoragePath.present) {
      map['thumb_storage_path'] = Variable<String>(thumbStoragePath.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (uploadStatus.present) {
      map['upload_status'] = Variable<String>(uploadStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaAssetsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('memoryId: $memoryId, ')
          ..write('localPath: $localPath, ')
          ..write('storagePath: $storagePath, ')
          ..write('thumbStoragePath: $thumbStoragePath, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('uploadStatus: $uploadStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ImportantDatesTable extends ImportantDates
    with TableInfo<$ImportantDatesTable, ImportantDate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImportantDatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _relationshipIdMeta =
      const VerificationMeta('relationshipId');
  @override
  late final GeneratedColumn<String> relationshipId = GeneratedColumn<String>(
      'relationship_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES relationships (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _recursAnnuallyMeta =
      const VerificationMeta('recursAnnually');
  @override
  late final GeneratedColumn<bool> recursAnnually = GeneratedColumn<bool>(
      'recurs_annually', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("recurs_annually" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        updatedAt,
        deletedAt,
        relationshipId,
        type,
        date,
        recursAnnually,
        label
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'important_dates';
  @override
  VerificationContext validateIntegrity(Insertable<ImportantDate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('relationship_id')) {
      context.handle(
          _relationshipIdMeta,
          relationshipId.isAcceptableOrUnknown(
              data['relationship_id']!, _relationshipIdMeta));
    } else if (isInserting) {
      context.missing(_relationshipIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('recurs_annually')) {
      context.handle(
          _recursAnnuallyMeta,
          recursAnnually.isAcceptableOrUnknown(
              data['recurs_annually']!, _recursAnnuallyMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImportantDate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImportantDate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      relationshipId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}relationship_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      recursAnnually: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}recurs_annually'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label']),
    );
  }

  @override
  $ImportantDatesTable createAlias(String alias) {
    return $ImportantDatesTable(attachedDatabase, alias);
  }
}

class ImportantDate extends DataClass implements Insertable<ImportantDate> {
  final String id;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String relationshipId;
  final String type;
  final DateTime date;
  final bool recursAnnually;
  final String? label;
  const ImportantDate(
      {required this.id,
      this.updatedAt,
      this.deletedAt,
      required this.relationshipId,
      required this.type,
      required this.date,
      required this.recursAnnually,
      this.label});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['relationship_id'] = Variable<String>(relationshipId);
    map['type'] = Variable<String>(type);
    map['date'] = Variable<DateTime>(date);
    map['recurs_annually'] = Variable<bool>(recursAnnually);
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    return map;
  }

  ImportantDatesCompanion toCompanion(bool nullToAbsent) {
    return ImportantDatesCompanion(
      id: Value(id),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      relationshipId: Value(relationshipId),
      type: Value(type),
      date: Value(date),
      recursAnnually: Value(recursAnnually),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
    );
  }

  factory ImportantDate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImportantDate(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      relationshipId: serializer.fromJson<String>(json['relationshipId']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<DateTime>(json['date']),
      recursAnnually: serializer.fromJson<bool>(json['recursAnnually']),
      label: serializer.fromJson<String?>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'relationshipId': serializer.toJson<String>(relationshipId),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<DateTime>(date),
      'recursAnnually': serializer.toJson<bool>(recursAnnually),
      'label': serializer.toJson<String?>(label),
    };
  }

  ImportantDate copyWith(
          {String? id,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent(),
          String? relationshipId,
          String? type,
          DateTime? date,
          bool? recursAnnually,
          Value<String?> label = const Value.absent()}) =>
      ImportantDate(
        id: id ?? this.id,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        relationshipId: relationshipId ?? this.relationshipId,
        type: type ?? this.type,
        date: date ?? this.date,
        recursAnnually: recursAnnually ?? this.recursAnnually,
        label: label.present ? label.value : this.label,
      );
  ImportantDate copyWithCompanion(ImportantDatesCompanion data) {
    return ImportantDate(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      relationshipId: data.relationshipId.present
          ? data.relationshipId.value
          : this.relationshipId,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      recursAnnually: data.recursAnnually.present
          ? data.recursAnnually.value
          : this.recursAnnually,
      label: data.label.present ? data.label.value : this.label,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImportantDate(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('recursAnnually: $recursAnnually, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, updatedAt, deletedAt, relationshipId,
      type, date, recursAnnually, label);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImportantDate &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.relationshipId == this.relationshipId &&
          other.type == this.type &&
          other.date == this.date &&
          other.recursAnnually == this.recursAnnually &&
          other.label == this.label);
}

class ImportantDatesCompanion extends UpdateCompanion<ImportantDate> {
  final Value<String> id;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> relationshipId;
  final Value<String> type;
  final Value<DateTime> date;
  final Value<bool> recursAnnually;
  final Value<String?> label;
  final Value<int> rowid;
  const ImportantDatesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.relationshipId = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.recursAnnually = const Value.absent(),
    this.label = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImportantDatesCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String relationshipId,
    required String type,
    required DateTime date,
    this.recursAnnually = const Value.absent(),
    this.label = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        relationshipId = Value(relationshipId),
        type = Value(type),
        date = Value(date);
  static Insertable<ImportantDate> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? relationshipId,
    Expression<String>? type,
    Expression<DateTime>? date,
    Expression<bool>? recursAnnually,
    Expression<String>? label,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (relationshipId != null) 'relationship_id': relationshipId,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (recursAnnually != null) 'recurs_annually': recursAnnually,
      if (label != null) 'label': label,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImportantDatesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? relationshipId,
      Value<String>? type,
      Value<DateTime>? date,
      Value<bool>? recursAnnually,
      Value<String?>? label,
      Value<int>? rowid}) {
    return ImportantDatesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      relationshipId: relationshipId ?? this.relationshipId,
      type: type ?? this.type,
      date: date ?? this.date,
      recursAnnually: recursAnnually ?? this.recursAnnually,
      label: label ?? this.label,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (relationshipId.present) {
      map['relationship_id'] = Variable<String>(relationshipId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (recursAnnually.present) {
      map['recurs_annually'] = Variable<bool>(recursAnnually.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImportantDatesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('recursAnnually: $recursAnnually, ')
          ..write('label: $label, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PromisesTable extends Promises with TableInfo<$PromisesTable, Promise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PromisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _relationshipIdMeta =
      const VerificationMeta('relationshipId');
  @override
  late final GeneratedColumn<String> relationshipId = GeneratedColumn<String>(
      'relationship_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES relationships (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('todo'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        updatedAt,
        deletedAt,
        relationshipId,
        title,
        dueDate,
        priority,
        status
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'promises';
  @override
  VerificationContext validateIntegrity(Insertable<Promise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('relationship_id')) {
      context.handle(
          _relationshipIdMeta,
          relationshipId.isAcceptableOrUnknown(
              data['relationship_id']!, _relationshipIdMeta));
    } else if (isInserting) {
      context.missing(_relationshipIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Promise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Promise(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      relationshipId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}relationship_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $PromisesTable createAlias(String alias) {
    return $PromisesTable(attachedDatabase, alias);
  }
}

class Promise extends DataClass implements Insertable<Promise> {
  final String id;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String relationshipId;
  final String title;
  final DateTime? dueDate;
  final int? priority;
  final String status;
  const Promise(
      {required this.id,
      this.updatedAt,
      this.deletedAt,
      required this.relationshipId,
      required this.title,
      this.dueDate,
      this.priority,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['relationship_id'] = Variable<String>(relationshipId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || priority != null) {
      map['priority'] = Variable<int>(priority);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  PromisesCompanion toCompanion(bool nullToAbsent) {
    return PromisesCompanion(
      id: Value(id),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      relationshipId: Value(relationshipId),
      title: Value(title),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      priority: priority == null && nullToAbsent
          ? const Value.absent()
          : Value(priority),
      status: Value(status),
    );
  }

  factory Promise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Promise(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      relationshipId: serializer.fromJson<String>(json['relationshipId']),
      title: serializer.fromJson<String>(json['title']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      priority: serializer.fromJson<int?>(json['priority']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'relationshipId': serializer.toJson<String>(relationshipId),
      'title': serializer.toJson<String>(title),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'priority': serializer.toJson<int?>(priority),
      'status': serializer.toJson<String>(status),
    };
  }

  Promise copyWith(
          {String? id,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent(),
          String? relationshipId,
          String? title,
          Value<DateTime?> dueDate = const Value.absent(),
          Value<int?> priority = const Value.absent(),
          String? status}) =>
      Promise(
        id: id ?? this.id,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        relationshipId: relationshipId ?? this.relationshipId,
        title: title ?? this.title,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        priority: priority.present ? priority.value : this.priority,
        status: status ?? this.status,
      );
  Promise copyWithCompanion(PromisesCompanion data) {
    return Promise(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      relationshipId: data.relationshipId.present
          ? data.relationshipId.value
          : this.relationshipId,
      title: data.title.present ? data.title.value : this.title,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      priority: data.priority.present ? data.priority.value : this.priority,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Promise(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('priority: $priority, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, updatedAt, deletedAt, relationshipId,
      title, dueDate, priority, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Promise &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.relationshipId == this.relationshipId &&
          other.title == this.title &&
          other.dueDate == this.dueDate &&
          other.priority == this.priority &&
          other.status == this.status);
}

class PromisesCompanion extends UpdateCompanion<Promise> {
  final Value<String> id;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> relationshipId;
  final Value<String> title;
  final Value<DateTime?> dueDate;
  final Value<int?> priority;
  final Value<String> status;
  final Value<int> rowid;
  const PromisesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.relationshipId = const Value.absent(),
    this.title = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PromisesCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String relationshipId,
    required String title,
    this.dueDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        relationshipId = Value(relationshipId),
        title = Value(title);
  static Insertable<Promise> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? relationshipId,
    Expression<String>? title,
    Expression<DateTime>? dueDate,
    Expression<int>? priority,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (relationshipId != null) 'relationship_id': relationshipId,
      if (title != null) 'title': title,
      if (dueDate != null) 'due_date': dueDate,
      if (priority != null) 'priority': priority,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PromisesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? relationshipId,
      Value<String>? title,
      Value<DateTime?>? dueDate,
      Value<int?>? priority,
      Value<String>? status,
      Value<int>? rowid}) {
    return PromisesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      relationshipId: relationshipId ?? this.relationshipId,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (relationshipId.present) {
      map['relationship_id'] = Variable<String>(relationshipId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromisesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _relationshipIdMeta =
      const VerificationMeta('relationshipId');
  @override
  late final GeneratedColumn<String> relationshipId = GeneratedColumn<String>(
      'relationship_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES relationships (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startsAtMeta =
      const VerificationMeta('startsAt');
  @override
  late final GeneratedColumn<DateTime> startsAt = GeneratedColumn<DateTime>(
      'starts_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
      'kind', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, updatedAt, deletedAt, relationshipId, title, startsAt, kind];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('relationship_id')) {
      context.handle(
          _relationshipIdMeta,
          relationshipId.isAcceptableOrUnknown(
              data['relationship_id']!, _relationshipIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('starts_at')) {
      context.handle(_startsAtMeta,
          startsAt.isAcceptableOrUnknown(data['starts_at']!, _startsAtMeta));
    } else if (isInserting) {
      context.missing(_startsAtMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
          _kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      relationshipId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}relationship_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      startsAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}starts_at'])!,
      kind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kind']),
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final String id;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? relationshipId;
  final String title;
  final DateTime startsAt;
  final String? kind;
  const Event(
      {required this.id,
      this.updatedAt,
      this.deletedAt,
      this.relationshipId,
      required this.title,
      required this.startsAt,
      this.kind});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || relationshipId != null) {
      map['relationship_id'] = Variable<String>(relationshipId);
    }
    map['title'] = Variable<String>(title);
    map['starts_at'] = Variable<DateTime>(startsAt);
    if (!nullToAbsent || kind != null) {
      map['kind'] = Variable<String>(kind);
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      relationshipId: relationshipId == null && nullToAbsent
          ? const Value.absent()
          : Value(relationshipId),
      title: Value(title),
      startsAt: Value(startsAt),
      kind: kind == null && nullToAbsent ? const Value.absent() : Value(kind),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      relationshipId: serializer.fromJson<String?>(json['relationshipId']),
      title: serializer.fromJson<String>(json['title']),
      startsAt: serializer.fromJson<DateTime>(json['startsAt']),
      kind: serializer.fromJson<String?>(json['kind']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'relationshipId': serializer.toJson<String?>(relationshipId),
      'title': serializer.toJson<String>(title),
      'startsAt': serializer.toJson<DateTime>(startsAt),
      'kind': serializer.toJson<String?>(kind),
    };
  }

  Event copyWith(
          {String? id,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent(),
          Value<String?> relationshipId = const Value.absent(),
          String? title,
          DateTime? startsAt,
          Value<String?> kind = const Value.absent()}) =>
      Event(
        id: id ?? this.id,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        relationshipId:
            relationshipId.present ? relationshipId.value : this.relationshipId,
        title: title ?? this.title,
        startsAt: startsAt ?? this.startsAt,
        kind: kind.present ? kind.value : this.kind,
      );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      relationshipId: data.relationshipId.present
          ? data.relationshipId.value
          : this.relationshipId,
      title: data.title.present ? data.title.value : this.title,
      startsAt: data.startsAt.present ? data.startsAt.value : this.startsAt,
      kind: data.kind.present ? data.kind.value : this.kind,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('title: $title, ')
          ..write('startsAt: $startsAt, ')
          ..write('kind: $kind')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, updatedAt, deletedAt, relationshipId, title, startsAt, kind);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.relationshipId == this.relationshipId &&
          other.title == this.title &&
          other.startsAt == this.startsAt &&
          other.kind == this.kind);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<String> id;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String?> relationshipId;
  final Value<String> title;
  final Value<DateTime> startsAt;
  final Value<String?> kind;
  final Value<int> rowid;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.relationshipId = const Value.absent(),
    this.title = const Value.absent(),
    this.startsAt = const Value.absent(),
    this.kind = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.relationshipId = const Value.absent(),
    required String title,
    required DateTime startsAt,
    this.kind = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        startsAt = Value(startsAt);
  static Insertable<Event> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? relationshipId,
    Expression<String>? title,
    Expression<DateTime>? startsAt,
    Expression<String>? kind,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (relationshipId != null) 'relationship_id': relationshipId,
      if (title != null) 'title': title,
      if (startsAt != null) 'starts_at': startsAt,
      if (kind != null) 'kind': kind,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String?>? relationshipId,
      Value<String>? title,
      Value<DateTime>? startsAt,
      Value<String?>? kind,
      Value<int>? rowid}) {
    return EventsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      relationshipId: relationshipId ?? this.relationshipId,
      title: title ?? this.title,
      startsAt: startsAt ?? this.startsAt,
      kind: kind ?? this.kind,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (relationshipId.present) {
      map['relationship_id'] = Variable<String>(relationshipId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startsAt.present) {
      map['starts_at'] = Variable<DateTime>(startsAt.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('title: $title, ')
          ..write('startsAt: $startsAt, ')
          ..write('kind: $kind, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PreferencesTable extends Preferences
    with TableInfo<$PreferencesTable, Preference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _relationshipIdMeta =
      const VerificationMeta('relationshipId');
  @override
  late final GeneratedColumn<String> relationshipId = GeneratedColumn<String>(
      'relationship_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES relationships (id)'));
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueJsonMeta =
      const VerificationMeta('valueJson');
  @override
  late final GeneratedColumn<String> valueJson = GeneratedColumn<String>(
      'value_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, updatedAt, deletedAt, relationshipId, key, valueJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preferences';
  @override
  VerificationContext validateIntegrity(Insertable<Preference> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('relationship_id')) {
      context.handle(
          _relationshipIdMeta,
          relationshipId.isAcceptableOrUnknown(
              data['relationship_id']!, _relationshipIdMeta));
    } else if (isInserting) {
      context.missing(_relationshipIdMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value_json')) {
      context.handle(_valueJsonMeta,
          valueJson.isAcceptableOrUnknown(data['value_json']!, _valueJsonMeta));
    } else if (isInserting) {
      context.missing(_valueJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Preference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Preference(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      relationshipId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}relationship_id'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      valueJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value_json'])!,
    );
  }

  @override
  $PreferencesTable createAlias(String alias) {
    return $PreferencesTable(attachedDatabase, alias);
  }
}

class Preference extends DataClass implements Insertable<Preference> {
  final String id;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String relationshipId;
  final String key;
  final String valueJson;
  const Preference(
      {required this.id,
      this.updatedAt,
      this.deletedAt,
      required this.relationshipId,
      required this.key,
      required this.valueJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['relationship_id'] = Variable<String>(relationshipId);
    map['key'] = Variable<String>(key);
    map['value_json'] = Variable<String>(valueJson);
    return map;
  }

  PreferencesCompanion toCompanion(bool nullToAbsent) {
    return PreferencesCompanion(
      id: Value(id),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      relationshipId: Value(relationshipId),
      key: Value(key),
      valueJson: Value(valueJson),
    );
  }

  factory Preference.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Preference(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      relationshipId: serializer.fromJson<String>(json['relationshipId']),
      key: serializer.fromJson<String>(json['key']),
      valueJson: serializer.fromJson<String>(json['valueJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'relationshipId': serializer.toJson<String>(relationshipId),
      'key': serializer.toJson<String>(key),
      'valueJson': serializer.toJson<String>(valueJson),
    };
  }

  Preference copyWith(
          {String? id,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent(),
          String? relationshipId,
          String? key,
          String? valueJson}) =>
      Preference(
        id: id ?? this.id,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        relationshipId: relationshipId ?? this.relationshipId,
        key: key ?? this.key,
        valueJson: valueJson ?? this.valueJson,
      );
  Preference copyWithCompanion(PreferencesCompanion data) {
    return Preference(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      relationshipId: data.relationshipId.present
          ? data.relationshipId.value
          : this.relationshipId,
      key: data.key.present ? data.key.value : this.key,
      valueJson: data.valueJson.present ? data.valueJson.value : this.valueJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Preference(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, updatedAt, deletedAt, relationshipId, key, valueJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Preference &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.relationshipId == this.relationshipId &&
          other.key == this.key &&
          other.valueJson == this.valueJson);
}

class PreferencesCompanion extends UpdateCompanion<Preference> {
  final Value<String> id;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> relationshipId;
  final Value<String> key;
  final Value<String> valueJson;
  final Value<int> rowid;
  const PreferencesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.relationshipId = const Value.absent(),
    this.key = const Value.absent(),
    this.valueJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PreferencesCompanion.insert({
    required String id,
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String relationshipId,
    required String key,
    required String valueJson,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        relationshipId = Value(relationshipId),
        key = Value(key),
        valueJson = Value(valueJson);
  static Insertable<Preference> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? relationshipId,
    Expression<String>? key,
    Expression<String>? valueJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (relationshipId != null) 'relationship_id': relationshipId,
      if (key != null) 'key': key,
      if (valueJson != null) 'value_json': valueJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PreferencesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? relationshipId,
      Value<String>? key,
      Value<String>? valueJson,
      Value<int>? rowid}) {
    return PreferencesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      relationshipId: relationshipId ?? this.relationshipId,
      key: key ?? this.key,
      valueJson: valueJson ?? this.valueJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (relationshipId.present) {
      map['relationship_id'] = Variable<String>(relationshipId.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (valueJson.present) {
      map['value_json'] = Variable<String>(valueJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferencesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PresenceSnapshotsTable extends PresenceSnapshots
    with TableInfo<$PresenceSnapshotsTable, PresenceSnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PresenceSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _relationshipIdMeta =
      const VerificationMeta('relationshipId');
  @override
  late final GeneratedColumn<String> relationshipId = GeneratedColumn<String>(
      'relationship_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES relationships (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _scoreCalcMeta =
      const VerificationMeta('scoreCalc');
  @override
  late final GeneratedColumn<int> scoreCalc = GeneratedColumn<int>(
      'score_calc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _scoreDisplayMeta =
      const VerificationMeta('scoreDisplay');
  @override
  late final GeneratedColumn<int> scoreDisplay = GeneratedColumn<int>(
      'score_display', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _componentsJsonMeta =
      const VerificationMeta('componentsJson');
  @override
  late final GeneratedColumn<String> componentsJson = GeneratedColumn<String>(
      'components_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [relationshipId, date, scoreCalc, scoreDisplay, componentsJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'presence_snapshots';
  @override
  VerificationContext validateIntegrity(Insertable<PresenceSnapshot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('relationship_id')) {
      context.handle(
          _relationshipIdMeta,
          relationshipId.isAcceptableOrUnknown(
              data['relationship_id']!, _relationshipIdMeta));
    } else if (isInserting) {
      context.missing(_relationshipIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('score_calc')) {
      context.handle(_scoreCalcMeta,
          scoreCalc.isAcceptableOrUnknown(data['score_calc']!, _scoreCalcMeta));
    } else if (isInserting) {
      context.missing(_scoreCalcMeta);
    }
    if (data.containsKey('score_display')) {
      context.handle(
          _scoreDisplayMeta,
          scoreDisplay.isAcceptableOrUnknown(
              data['score_display']!, _scoreDisplayMeta));
    } else if (isInserting) {
      context.missing(_scoreDisplayMeta);
    }
    if (data.containsKey('components_json')) {
      context.handle(
          _componentsJsonMeta,
          componentsJson.isAcceptableOrUnknown(
              data['components_json']!, _componentsJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {relationshipId, date};
  @override
  PresenceSnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PresenceSnapshot(
      relationshipId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}relationship_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      scoreCalc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score_calc'])!,
      scoreDisplay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score_display'])!,
      componentsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}components_json']),
    );
  }

  @override
  $PresenceSnapshotsTable createAlias(String alias) {
    return $PresenceSnapshotsTable(attachedDatabase, alias);
  }
}

class PresenceSnapshot extends DataClass
    implements Insertable<PresenceSnapshot> {
  final String relationshipId;
  final DateTime date;
  final int scoreCalc;
  final int scoreDisplay;
  final String? componentsJson;
  const PresenceSnapshot(
      {required this.relationshipId,
      required this.date,
      required this.scoreCalc,
      required this.scoreDisplay,
      this.componentsJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['relationship_id'] = Variable<String>(relationshipId);
    map['date'] = Variable<DateTime>(date);
    map['score_calc'] = Variable<int>(scoreCalc);
    map['score_display'] = Variable<int>(scoreDisplay);
    if (!nullToAbsent || componentsJson != null) {
      map['components_json'] = Variable<String>(componentsJson);
    }
    return map;
  }

  PresenceSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return PresenceSnapshotsCompanion(
      relationshipId: Value(relationshipId),
      date: Value(date),
      scoreCalc: Value(scoreCalc),
      scoreDisplay: Value(scoreDisplay),
      componentsJson: componentsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(componentsJson),
    );
  }

  factory PresenceSnapshot.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PresenceSnapshot(
      relationshipId: serializer.fromJson<String>(json['relationshipId']),
      date: serializer.fromJson<DateTime>(json['date']),
      scoreCalc: serializer.fromJson<int>(json['scoreCalc']),
      scoreDisplay: serializer.fromJson<int>(json['scoreDisplay']),
      componentsJson: serializer.fromJson<String?>(json['componentsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'relationshipId': serializer.toJson<String>(relationshipId),
      'date': serializer.toJson<DateTime>(date),
      'scoreCalc': serializer.toJson<int>(scoreCalc),
      'scoreDisplay': serializer.toJson<int>(scoreDisplay),
      'componentsJson': serializer.toJson<String?>(componentsJson),
    };
  }

  PresenceSnapshot copyWith(
          {String? relationshipId,
          DateTime? date,
          int? scoreCalc,
          int? scoreDisplay,
          Value<String?> componentsJson = const Value.absent()}) =>
      PresenceSnapshot(
        relationshipId: relationshipId ?? this.relationshipId,
        date: date ?? this.date,
        scoreCalc: scoreCalc ?? this.scoreCalc,
        scoreDisplay: scoreDisplay ?? this.scoreDisplay,
        componentsJson:
            componentsJson.present ? componentsJson.value : this.componentsJson,
      );
  PresenceSnapshot copyWithCompanion(PresenceSnapshotsCompanion data) {
    return PresenceSnapshot(
      relationshipId: data.relationshipId.present
          ? data.relationshipId.value
          : this.relationshipId,
      date: data.date.present ? data.date.value : this.date,
      scoreCalc: data.scoreCalc.present ? data.scoreCalc.value : this.scoreCalc,
      scoreDisplay: data.scoreDisplay.present
          ? data.scoreDisplay.value
          : this.scoreDisplay,
      componentsJson: data.componentsJson.present
          ? data.componentsJson.value
          : this.componentsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PresenceSnapshot(')
          ..write('relationshipId: $relationshipId, ')
          ..write('date: $date, ')
          ..write('scoreCalc: $scoreCalc, ')
          ..write('scoreDisplay: $scoreDisplay, ')
          ..write('componentsJson: $componentsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      relationshipId, date, scoreCalc, scoreDisplay, componentsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PresenceSnapshot &&
          other.relationshipId == this.relationshipId &&
          other.date == this.date &&
          other.scoreCalc == this.scoreCalc &&
          other.scoreDisplay == this.scoreDisplay &&
          other.componentsJson == this.componentsJson);
}

class PresenceSnapshotsCompanion extends UpdateCompanion<PresenceSnapshot> {
  final Value<String> relationshipId;
  final Value<DateTime> date;
  final Value<int> scoreCalc;
  final Value<int> scoreDisplay;
  final Value<String?> componentsJson;
  final Value<int> rowid;
  const PresenceSnapshotsCompanion({
    this.relationshipId = const Value.absent(),
    this.date = const Value.absent(),
    this.scoreCalc = const Value.absent(),
    this.scoreDisplay = const Value.absent(),
    this.componentsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PresenceSnapshotsCompanion.insert({
    required String relationshipId,
    required DateTime date,
    required int scoreCalc,
    required int scoreDisplay,
    this.componentsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : relationshipId = Value(relationshipId),
        date = Value(date),
        scoreCalc = Value(scoreCalc),
        scoreDisplay = Value(scoreDisplay);
  static Insertable<PresenceSnapshot> custom({
    Expression<String>? relationshipId,
    Expression<DateTime>? date,
    Expression<int>? scoreCalc,
    Expression<int>? scoreDisplay,
    Expression<String>? componentsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (relationshipId != null) 'relationship_id': relationshipId,
      if (date != null) 'date': date,
      if (scoreCalc != null) 'score_calc': scoreCalc,
      if (scoreDisplay != null) 'score_display': scoreDisplay,
      if (componentsJson != null) 'components_json': componentsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PresenceSnapshotsCompanion copyWith(
      {Value<String>? relationshipId,
      Value<DateTime>? date,
      Value<int>? scoreCalc,
      Value<int>? scoreDisplay,
      Value<String?>? componentsJson,
      Value<int>? rowid}) {
    return PresenceSnapshotsCompanion(
      relationshipId: relationshipId ?? this.relationshipId,
      date: date ?? this.date,
      scoreCalc: scoreCalc ?? this.scoreCalc,
      scoreDisplay: scoreDisplay ?? this.scoreDisplay,
      componentsJson: componentsJson ?? this.componentsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (relationshipId.present) {
      map['relationship_id'] = Variable<String>(relationshipId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (scoreCalc.present) {
      map['score_calc'] = Variable<int>(scoreCalc.value);
    }
    if (scoreDisplay.present) {
      map['score_display'] = Variable<int>(scoreDisplay.value);
    }
    if (componentsJson.present) {
      map['components_json'] = Variable<String>(componentsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PresenceSnapshotsCompanion(')
          ..write('relationshipId: $relationshipId, ')
          ..write('date: $date, ')
          ..write('scoreCalc: $scoreCalc, ')
          ..write('scoreDisplay: $scoreDisplay, ')
          ..write('componentsJson: $componentsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueJsonMeta =
      const VerificationMeta('valueJson');
  @override
  late final GeneratedColumn<String> valueJson = GeneratedColumn<String>(
      'value_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, valueJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value_json')) {
      context.handle(_valueJsonMeta,
          valueJson.isAcceptableOrUnknown(data['value_json']!, _valueJsonMeta));
    } else if (isInserting) {
      context.missing(_valueJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      valueJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value_json'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String valueJson;
  const AppSetting({required this.key, required this.valueJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value_json'] = Variable<String>(valueJson);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      valueJson: Value(valueJson),
    );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      valueJson: serializer.fromJson<String>(json['valueJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'valueJson': serializer.toJson<String>(valueJson),
    };
  }

  AppSetting copyWith({String? key, String? valueJson}) => AppSetting(
        key: key ?? this.key,
        valueJson: valueJson ?? this.valueJson,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      valueJson: data.valueJson.present ? data.valueJson.value : this.valueJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, valueJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.valueJson == this.valueJson);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> valueJson;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.valueJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String valueJson,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        valueJson = Value(valueJson);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? valueJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (valueJson != null) 'value_json': valueJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<String>? key, Value<String>? valueJson, Value<int>? rowid}) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      valueJson: valueJson ?? this.valueJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (valueJson.present) {
      map['value_json'] = Variable<String>(valueJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutboxTable extends Outbox with TableInfo<$OutboxTable, OutboxData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
      'seq', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
      'entity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _opMeta = const VerificationMeta('op');
  @override
  late final GeneratedColumn<String> op = GeneratedColumn<String>(
      'op', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadJsonMeta =
      const VerificationMeta('payloadJson');
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
      'payload_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _attemptsMeta =
      const VerificationMeta('attempts');
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
      'attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [seq, entity, entityId, op, payloadJson, createdAt, attempts];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox';
  @override
  VerificationContext validateIntegrity(Insertable<OutboxData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('seq')) {
      context.handle(
          _seqMeta, seq.isAcceptableOrUnknown(data['seq']!, _seqMeta));
    }
    if (data.containsKey('entity')) {
      context.handle(_entityMeta,
          entity.isAcceptableOrUnknown(data['entity']!, _entityMeta));
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('op')) {
      context.handle(_opMeta, op.isAcceptableOrUnknown(data['op']!, _opMeta));
    } else if (isInserting) {
      context.missing(_opMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
          _payloadJsonMeta,
          payloadJson.isAcceptableOrUnknown(
              data['payload_json']!, _payloadJsonMeta));
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(_attemptsMeta,
          attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {seq};
  @override
  OutboxData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxData(
      seq: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}seq'])!,
      entity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      op: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}op'])!,
      payloadJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      attempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempts'])!,
    );
  }

  @override
  $OutboxTable createAlias(String alias) {
    return $OutboxTable(attachedDatabase, alias);
  }
}

class OutboxData extends DataClass implements Insertable<OutboxData> {
  final int seq;
  final String entity;
  final String entityId;
  final String op;
  final String payloadJson;
  final DateTime createdAt;
  final int attempts;
  const OutboxData(
      {required this.seq,
      required this.entity,
      required this.entityId,
      required this.op,
      required this.payloadJson,
      required this.createdAt,
      required this.attempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['seq'] = Variable<int>(seq);
    map['entity'] = Variable<String>(entity);
    map['entity_id'] = Variable<String>(entityId);
    map['op'] = Variable<String>(op);
    map['payload_json'] = Variable<String>(payloadJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['attempts'] = Variable<int>(attempts);
    return map;
  }

  OutboxCompanion toCompanion(bool nullToAbsent) {
    return OutboxCompanion(
      seq: Value(seq),
      entity: Value(entity),
      entityId: Value(entityId),
      op: Value(op),
      payloadJson: Value(payloadJson),
      createdAt: Value(createdAt),
      attempts: Value(attempts),
    );
  }

  factory OutboxData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxData(
      seq: serializer.fromJson<int>(json['seq']),
      entity: serializer.fromJson<String>(json['entity']),
      entityId: serializer.fromJson<String>(json['entityId']),
      op: serializer.fromJson<String>(json['op']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      attempts: serializer.fromJson<int>(json['attempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'seq': serializer.toJson<int>(seq),
      'entity': serializer.toJson<String>(entity),
      'entityId': serializer.toJson<String>(entityId),
      'op': serializer.toJson<String>(op),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'attempts': serializer.toJson<int>(attempts),
    };
  }

  OutboxData copyWith(
          {int? seq,
          String? entity,
          String? entityId,
          String? op,
          String? payloadJson,
          DateTime? createdAt,
          int? attempts}) =>
      OutboxData(
        seq: seq ?? this.seq,
        entity: entity ?? this.entity,
        entityId: entityId ?? this.entityId,
        op: op ?? this.op,
        payloadJson: payloadJson ?? this.payloadJson,
        createdAt: createdAt ?? this.createdAt,
        attempts: attempts ?? this.attempts,
      );
  OutboxData copyWithCompanion(OutboxCompanion data) {
    return OutboxData(
      seq: data.seq.present ? data.seq.value : this.seq,
      entity: data.entity.present ? data.entity.value : this.entity,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      op: data.op.present ? data.op.value : this.op,
      payloadJson:
          data.payloadJson.present ? data.payloadJson.value : this.payloadJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxData(')
          ..write('seq: $seq, ')
          ..write('entity: $entity, ')
          ..write('entityId: $entityId, ')
          ..write('op: $op, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('attempts: $attempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(seq, entity, entityId, op, payloadJson, createdAt, attempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxData &&
          other.seq == this.seq &&
          other.entity == this.entity &&
          other.entityId == this.entityId &&
          other.op == this.op &&
          other.payloadJson == this.payloadJson &&
          other.createdAt == this.createdAt &&
          other.attempts == this.attempts);
}

class OutboxCompanion extends UpdateCompanion<OutboxData> {
  final Value<int> seq;
  final Value<String> entity;
  final Value<String> entityId;
  final Value<String> op;
  final Value<String> payloadJson;
  final Value<DateTime> createdAt;
  final Value<int> attempts;
  const OutboxCompanion({
    this.seq = const Value.absent(),
    this.entity = const Value.absent(),
    this.entityId = const Value.absent(),
    this.op = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.attempts = const Value.absent(),
  });
  OutboxCompanion.insert({
    this.seq = const Value.absent(),
    required String entity,
    required String entityId,
    required String op,
    required String payloadJson,
    required DateTime createdAt,
    this.attempts = const Value.absent(),
  })  : entity = Value(entity),
        entityId = Value(entityId),
        op = Value(op),
        payloadJson = Value(payloadJson),
        createdAt = Value(createdAt);
  static Insertable<OutboxData> custom({
    Expression<int>? seq,
    Expression<String>? entity,
    Expression<String>? entityId,
    Expression<String>? op,
    Expression<String>? payloadJson,
    Expression<DateTime>? createdAt,
    Expression<int>? attempts,
  }) {
    return RawValuesInsertable({
      if (seq != null) 'seq': seq,
      if (entity != null) 'entity': entity,
      if (entityId != null) 'entity_id': entityId,
      if (op != null) 'op': op,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAt != null) 'created_at': createdAt,
      if (attempts != null) 'attempts': attempts,
    });
  }

  OutboxCompanion copyWith(
      {Value<int>? seq,
      Value<String>? entity,
      Value<String>? entityId,
      Value<String>? op,
      Value<String>? payloadJson,
      Value<DateTime>? createdAt,
      Value<int>? attempts}) {
    return OutboxCompanion(
      seq: seq ?? this.seq,
      entity: entity ?? this.entity,
      entityId: entityId ?? this.entityId,
      op: op ?? this.op,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      attempts: attempts ?? this.attempts,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (op.present) {
      map['op'] = Variable<String>(op.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxCompanion(')
          ..write('seq: $seq, ')
          ..write('entity: $entity, ')
          ..write('entityId: $entityId, ')
          ..write('op: $op, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('attempts: $attempts')
          ..write(')'))
        .toString();
  }
}

abstract class _$AmioraDatabase extends GeneratedDatabase {
  _$AmioraDatabase(QueryExecutor e) : super(e);
  $AmioraDatabaseManager get managers => $AmioraDatabaseManager(this);
  late final $RelationshipsTable relationships = $RelationshipsTable(this);
  late final $InteractionsTable interactions = $InteractionsTable(this);
  late final $InteractionParticipantsTable interactionParticipants =
      $InteractionParticipantsTable(this);
  late final $AlbumsTable albums = $AlbumsTable(this);
  late final $MemoriesTable memories = $MemoriesTable(this);
  late final $MemoryLinksTable memoryLinks = $MemoryLinksTable(this);
  late final $MediaAssetsTable mediaAssets = $MediaAssetsTable(this);
  late final $ImportantDatesTable importantDates = $ImportantDatesTable(this);
  late final $PromisesTable promises = $PromisesTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $PreferencesTable preferences = $PreferencesTable(this);
  late final $PresenceSnapshotsTable presenceSnapshots =
      $PresenceSnapshotsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $OutboxTable outbox = $OutboxTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        relationships,
        interactions,
        interactionParticipants,
        albums,
        memories,
        memoryLinks,
        mediaAssets,
        importantDates,
        promises,
        events,
        preferences,
        presenceSnapshots,
        appSettings,
        outbox
      ];
}

typedef $$RelationshipsTableCreateCompanionBuilder = RelationshipsCompanion
    Function({
  required String id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  required String firstName,
  Value<String?> lastName,
  required String category,
  Value<String> status,
  required int cadenceDays,
  required DateTime createdAt,
  Value<DateTime?> archivedAt,
  Value<DateTime?> birthday,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<String?> job,
  Value<String?> notes,
  Value<String?> photoLocalPath,
  Value<int> rowid,
});
typedef $$RelationshipsTableUpdateCompanionBuilder = RelationshipsCompanion
    Function({
  Value<String> id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> firstName,
  Value<String?> lastName,
  Value<String> category,
  Value<String> status,
  Value<int> cadenceDays,
  Value<DateTime> createdAt,
  Value<DateTime?> archivedAt,
  Value<DateTime?> birthday,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<String?> job,
  Value<String?> notes,
  Value<String?> photoLocalPath,
  Value<int> rowid,
});

final class $$RelationshipsTableReferences extends BaseReferences<
    _$AmioraDatabase, $RelationshipsTable, Relationship> {
  $$RelationshipsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InteractionParticipantsTable,
      List<InteractionParticipant>> _interactionParticipantsRefsTable(
          _$AmioraDatabase db) =>
      MultiTypedResultKey.fromTable(db.interactionParticipants,
          aliasName:
              'relationships__id__interaction_participants__relationship_id');

  $$InteractionParticipantsTableProcessedTableManager
      get interactionParticipantsRefs {
    final manager = $$InteractionParticipantsTableTableManager(
            $_db, $_db.interactionParticipants)
        .filter(
            (f) => f.relationshipId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_interactionParticipantsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MemoryLinksTable, List<MemoryLink>>
      _memoryLinksRefsTable(_$AmioraDatabase db) =>
          MultiTypedResultKey.fromTable(db.memoryLinks,
              aliasName: 'relationships__id__memory_links__relationship_id');

  $$MemoryLinksTableProcessedTableManager get memoryLinksRefs {
    final manager = $$MemoryLinksTableTableManager($_db, $_db.memoryLinks)
        .filter(
            (f) => f.relationshipId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_memoryLinksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ImportantDatesTable, List<ImportantDate>>
      _importantDatesRefsTable(_$AmioraDatabase db) =>
          MultiTypedResultKey.fromTable(db.importantDates,
              aliasName: 'relationships__id__important_dates__relationship_id');

  $$ImportantDatesTableProcessedTableManager get importantDatesRefs {
    final manager = $$ImportantDatesTableTableManager($_db, $_db.importantDates)
        .filter(
            (f) => f.relationshipId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_importantDatesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PromisesTable, List<Promise>> _promisesRefsTable(
          _$AmioraDatabase db) =>
      MultiTypedResultKey.fromTable(db.promises,
          aliasName: 'relationships__id__promises__relationship_id');

  $$PromisesTableProcessedTableManager get promisesRefs {
    final manager = $$PromisesTableTableManager($_db, $_db.promises).filter(
        (f) => f.relationshipId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_promisesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
          _$AmioraDatabase db) =>
      MultiTypedResultKey.fromTable(db.events,
          aliasName: 'relationships__id__events__relationship_id');

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager($_db, $_db.events).filter(
        (f) => f.relationshipId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PreferencesTable, List<Preference>>
      _preferencesRefsTable(_$AmioraDatabase db) =>
          MultiTypedResultKey.fromTable(db.preferences,
              aliasName: 'relationships__id__preferences__relationship_id');

  $$PreferencesTableProcessedTableManager get preferencesRefs {
    final manager = $$PreferencesTableTableManager($_db, $_db.preferences)
        .filter(
            (f) => f.relationshipId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_preferencesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PresenceSnapshotsTable, List<PresenceSnapshot>>
      _presenceSnapshotsRefsTable(_$AmioraDatabase db) =>
          MultiTypedResultKey.fromTable(db.presenceSnapshots,
              aliasName:
                  'relationships__id__presence_snapshots__relationship_id');

  $$PresenceSnapshotsTableProcessedTableManager get presenceSnapshotsRefs {
    final manager = $$PresenceSnapshotsTableTableManager(
            $_db, $_db.presenceSnapshots)
        .filter(
            (f) => f.relationshipId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_presenceSnapshotsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RelationshipsTableFilterComposer
    extends Composer<_$AmioraDatabase, $RelationshipsTable> {
  $$RelationshipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cadenceDays => $composableBuilder(
      column: $table.cadenceDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
      column: $table.archivedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get job => $composableBuilder(
      column: $table.job, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoLocalPath => $composableBuilder(
      column: $table.photoLocalPath,
      builder: (column) => ColumnFilters(column));

  Expression<bool> interactionParticipantsRefs(
      Expression<bool> Function($$InteractionParticipantsTableFilterComposer f)
          f) {
    final $$InteractionParticipantsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.interactionParticipants,
            getReferencedColumn: (t) => t.relationshipId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$InteractionParticipantsTableFilterComposer(
                  $db: $db,
                  $table: $db.interactionParticipants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> memoryLinksRefs(
      Expression<bool> Function($$MemoryLinksTableFilterComposer f) f) {
    final $$MemoryLinksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.memoryLinks,
        getReferencedColumn: (t) => t.relationshipId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoryLinksTableFilterComposer(
              $db: $db,
              $table: $db.memoryLinks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> importantDatesRefs(
      Expression<bool> Function($$ImportantDatesTableFilterComposer f) f) {
    final $$ImportantDatesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.importantDates,
        getReferencedColumn: (t) => t.relationshipId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ImportantDatesTableFilterComposer(
              $db: $db,
              $table: $db.importantDates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> promisesRefs(
      Expression<bool> Function($$PromisesTableFilterComposer f) f) {
    final $$PromisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.promises,
        getReferencedColumn: (t) => t.relationshipId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PromisesTableFilterComposer(
              $db: $db,
              $table: $db.promises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> eventsRefs(
      Expression<bool> Function($$EventsTableFilterComposer f) f) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.relationshipId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableFilterComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> preferencesRefs(
      Expression<bool> Function($$PreferencesTableFilterComposer f) f) {
    final $$PreferencesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.preferences,
        getReferencedColumn: (t) => t.relationshipId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PreferencesTableFilterComposer(
              $db: $db,
              $table: $db.preferences,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> presenceSnapshotsRefs(
      Expression<bool> Function($$PresenceSnapshotsTableFilterComposer f) f) {
    final $$PresenceSnapshotsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.presenceSnapshots,
        getReferencedColumn: (t) => t.relationshipId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PresenceSnapshotsTableFilterComposer(
              $db: $db,
              $table: $db.presenceSnapshots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RelationshipsTableOrderingComposer
    extends Composer<_$AmioraDatabase, $RelationshipsTable> {
  $$RelationshipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cadenceDays => $composableBuilder(
      column: $table.cadenceDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
      column: $table.archivedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get job => $composableBuilder(
      column: $table.job, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoLocalPath => $composableBuilder(
      column: $table.photoLocalPath,
      builder: (column) => ColumnOrderings(column));
}

class $$RelationshipsTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $RelationshipsTable> {
  $$RelationshipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get cadenceDays => $composableBuilder(
      column: $table.cadenceDays, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
      column: $table.archivedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get job =>
      $composableBuilder(column: $table.job, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoLocalPath => $composableBuilder(
      column: $table.photoLocalPath, builder: (column) => column);

  Expression<T> interactionParticipantsRefs<T extends Object>(
      Expression<T> Function($$InteractionParticipantsTableAnnotationComposer a)
          f) {
    final $$InteractionParticipantsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.interactionParticipants,
            getReferencedColumn: (t) => t.relationshipId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$InteractionParticipantsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.interactionParticipants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> memoryLinksRefs<T extends Object>(
      Expression<T> Function($$MemoryLinksTableAnnotationComposer a) f) {
    final $$MemoryLinksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.memoryLinks,
        getReferencedColumn: (t) => t.relationshipId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoryLinksTableAnnotationComposer(
              $db: $db,
              $table: $db.memoryLinks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> importantDatesRefs<T extends Object>(
      Expression<T> Function($$ImportantDatesTableAnnotationComposer a) f) {
    final $$ImportantDatesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.importantDates,
        getReferencedColumn: (t) => t.relationshipId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ImportantDatesTableAnnotationComposer(
              $db: $db,
              $table: $db.importantDates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> promisesRefs<T extends Object>(
      Expression<T> Function($$PromisesTableAnnotationComposer a) f) {
    final $$PromisesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.promises,
        getReferencedColumn: (t) => t.relationshipId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PromisesTableAnnotationComposer(
              $db: $db,
              $table: $db.promises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> eventsRefs<T extends Object>(
      Expression<T> Function($$EventsTableAnnotationComposer a) f) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.relationshipId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableAnnotationComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> preferencesRefs<T extends Object>(
      Expression<T> Function($$PreferencesTableAnnotationComposer a) f) {
    final $$PreferencesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.preferences,
        getReferencedColumn: (t) => t.relationshipId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PreferencesTableAnnotationComposer(
              $db: $db,
              $table: $db.preferences,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> presenceSnapshotsRefs<T extends Object>(
      Expression<T> Function($$PresenceSnapshotsTableAnnotationComposer a) f) {
    final $$PresenceSnapshotsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.presenceSnapshots,
            getReferencedColumn: (t) => t.relationshipId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PresenceSnapshotsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.presenceSnapshots,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$RelationshipsTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $RelationshipsTable,
    Relationship,
    $$RelationshipsTableFilterComposer,
    $$RelationshipsTableOrderingComposer,
    $$RelationshipsTableAnnotationComposer,
    $$RelationshipsTableCreateCompanionBuilder,
    $$RelationshipsTableUpdateCompanionBuilder,
    (Relationship, $$RelationshipsTableReferences),
    Relationship,
    PrefetchHooks Function(
        {bool interactionParticipantsRefs,
        bool memoryLinksRefs,
        bool importantDatesRefs,
        bool promisesRefs,
        bool eventsRefs,
        bool preferencesRefs,
        bool presenceSnapshotsRefs})> {
  $$RelationshipsTableTableManager(
      _$AmioraDatabase db, $RelationshipsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RelationshipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RelationshipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RelationshipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String?> lastName = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> cadenceDays = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> archivedAt = const Value.absent(),
            Value<DateTime?> birthday = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> job = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> photoLocalPath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationshipsCompanion(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            firstName: firstName,
            lastName: lastName,
            category: category,
            status: status,
            cadenceDays: cadenceDays,
            createdAt: createdAt,
            archivedAt: archivedAt,
            birthday: birthday,
            phone: phone,
            email: email,
            address: address,
            job: job,
            notes: notes,
            photoLocalPath: photoLocalPath,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String firstName,
            Value<String?> lastName = const Value.absent(),
            required String category,
            Value<String> status = const Value.absent(),
            required int cadenceDays,
            required DateTime createdAt,
            Value<DateTime?> archivedAt = const Value.absent(),
            Value<DateTime?> birthday = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> job = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> photoLocalPath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationshipsCompanion.insert(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            firstName: firstName,
            lastName: lastName,
            category: category,
            status: status,
            cadenceDays: cadenceDays,
            createdAt: createdAt,
            archivedAt: archivedAt,
            birthday: birthday,
            phone: phone,
            email: email,
            address: address,
            job: job,
            notes: notes,
            photoLocalPath: photoLocalPath,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RelationshipsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {interactionParticipantsRefs = false,
              memoryLinksRefs = false,
              importantDatesRefs = false,
              promisesRefs = false,
              eventsRefs = false,
              preferencesRefs = false,
              presenceSnapshotsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (interactionParticipantsRefs) db.interactionParticipants,
                if (memoryLinksRefs) db.memoryLinks,
                if (importantDatesRefs) db.importantDates,
                if (promisesRefs) db.promises,
                if (eventsRefs) db.events,
                if (preferencesRefs) db.preferences,
                if (presenceSnapshotsRefs) db.presenceSnapshots
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (interactionParticipantsRefs)
                    await $_getPrefetchedData<Relationship, $RelationshipsTable,
                            InteractionParticipant>(
                        currentTable: table,
                        referencedTable: $$RelationshipsTableReferences
                            ._interactionParticipantsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RelationshipsTableReferences(db, table, p0)
                                .interactionParticipantsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.relationshipId == item.id),
                        typedResults: items),
                  if (memoryLinksRefs)
                    await $_getPrefetchedData<Relationship, $RelationshipsTable,
                            MemoryLink>(
                        currentTable: table,
                        referencedTable: $$RelationshipsTableReferences
                            ._memoryLinksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RelationshipsTableReferences(db, table, p0)
                                .memoryLinksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.relationshipId == item.id),
                        typedResults: items),
                  if (importantDatesRefs)
                    await $_getPrefetchedData<Relationship, $RelationshipsTable,
                            ImportantDate>(
                        currentTable: table,
                        referencedTable: $$RelationshipsTableReferences
                            ._importantDatesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RelationshipsTableReferences(db, table, p0)
                                .importantDatesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.relationshipId == item.id),
                        typedResults: items),
                  if (promisesRefs)
                    await $_getPrefetchedData<Relationship, $RelationshipsTable,
                            Promise>(
                        currentTable: table,
                        referencedTable: $$RelationshipsTableReferences
                            ._promisesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RelationshipsTableReferences(db, table, p0)
                                .promisesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.relationshipId == item.id),
                        typedResults: items),
                  if (eventsRefs)
                    await $_getPrefetchedData<Relationship, $RelationshipsTable,
                            Event>(
                        currentTable: table,
                        referencedTable:
                            $$RelationshipsTableReferences._eventsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RelationshipsTableReferences(db, table, p0)
                                .eventsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.relationshipId == item.id),
                        typedResults: items),
                  if (preferencesRefs)
                    await $_getPrefetchedData<Relationship, $RelationshipsTable,
                            Preference>(
                        currentTable: table,
                        referencedTable: $$RelationshipsTableReferences
                            ._preferencesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RelationshipsTableReferences(db, table, p0)
                                .preferencesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.relationshipId == item.id),
                        typedResults: items),
                  if (presenceSnapshotsRefs)
                    await $_getPrefetchedData<Relationship, $RelationshipsTable,
                            PresenceSnapshot>(
                        currentTable: table,
                        referencedTable: $$RelationshipsTableReferences
                            ._presenceSnapshotsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RelationshipsTableReferences(db, table, p0)
                                .presenceSnapshotsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.relationshipId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RelationshipsTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $RelationshipsTable,
    Relationship,
    $$RelationshipsTableFilterComposer,
    $$RelationshipsTableOrderingComposer,
    $$RelationshipsTableAnnotationComposer,
    $$RelationshipsTableCreateCompanionBuilder,
    $$RelationshipsTableUpdateCompanionBuilder,
    (Relationship, $$RelationshipsTableReferences),
    Relationship,
    PrefetchHooks Function(
        {bool interactionParticipantsRefs,
        bool memoryLinksRefs,
        bool importantDatesRefs,
        bool promisesRefs,
        bool eventsRefs,
        bool preferencesRefs,
        bool presenceSnapshotsRefs})>;
typedef $$InteractionsTableCreateCompanionBuilder = InteractionsCompanion
    Function({
  required String id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  required String type,
  required DateTime occurredAt,
  Value<int?> durationMinutes,
  Value<String?> quality,
  Value<String?> location,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$InteractionsTableUpdateCompanionBuilder = InteractionsCompanion
    Function({
  Value<String> id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> type,
  Value<DateTime> occurredAt,
  Value<int?> durationMinutes,
  Value<String?> quality,
  Value<String?> location,
  Value<String?> note,
  Value<int> rowid,
});

final class $$InteractionsTableReferences
    extends BaseReferences<_$AmioraDatabase, $InteractionsTable, Interaction> {
  $$InteractionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InteractionParticipantsTable,
      List<InteractionParticipant>> _interactionParticipantsRefsTable(
          _$AmioraDatabase db) =>
      MultiTypedResultKey.fromTable(db.interactionParticipants,
          aliasName:
              'interactions__id__interaction_participants__interaction_id');

  $$InteractionParticipantsTableProcessedTableManager
      get interactionParticipantsRefs {
    final manager = $$InteractionParticipantsTableTableManager(
            $_db, $_db.interactionParticipants)
        .filter(
            (f) => f.interactionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_interactionParticipantsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$InteractionsTableFilterComposer
    extends Composer<_$AmioraDatabase, $InteractionsTable> {
  $$InteractionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get quality => $composableBuilder(
      column: $table.quality, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  Expression<bool> interactionParticipantsRefs(
      Expression<bool> Function($$InteractionParticipantsTableFilterComposer f)
          f) {
    final $$InteractionParticipantsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.interactionParticipants,
            getReferencedColumn: (t) => t.interactionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$InteractionParticipantsTableFilterComposer(
                  $db: $db,
                  $table: $db.interactionParticipants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$InteractionsTableOrderingComposer
    extends Composer<_$AmioraDatabase, $InteractionsTable> {
  $$InteractionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get quality => $composableBuilder(
      column: $table.quality, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));
}

class $$InteractionsTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $InteractionsTable> {
  $$InteractionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<String> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  Expression<T> interactionParticipantsRefs<T extends Object>(
      Expression<T> Function($$InteractionParticipantsTableAnnotationComposer a)
          f) {
    final $$InteractionParticipantsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.interactionParticipants,
            getReferencedColumn: (t) => t.interactionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$InteractionParticipantsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.interactionParticipants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$InteractionsTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $InteractionsTable,
    Interaction,
    $$InteractionsTableFilterComposer,
    $$InteractionsTableOrderingComposer,
    $$InteractionsTableAnnotationComposer,
    $$InteractionsTableCreateCompanionBuilder,
    $$InteractionsTableUpdateCompanionBuilder,
    (Interaction, $$InteractionsTableReferences),
    Interaction,
    PrefetchHooks Function({bool interactionParticipantsRefs})> {
  $$InteractionsTableTableManager(_$AmioraDatabase db, $InteractionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InteractionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InteractionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InteractionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> occurredAt = const Value.absent(),
            Value<int?> durationMinutes = const Value.absent(),
            Value<String?> quality = const Value.absent(),
            Value<String?> location = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InteractionsCompanion(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            type: type,
            occurredAt: occurredAt,
            durationMinutes: durationMinutes,
            quality: quality,
            location: location,
            note: note,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String type,
            required DateTime occurredAt,
            Value<int?> durationMinutes = const Value.absent(),
            Value<String?> quality = const Value.absent(),
            Value<String?> location = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InteractionsCompanion.insert(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            type: type,
            occurredAt: occurredAt,
            durationMinutes: durationMinutes,
            quality: quality,
            location: location,
            note: note,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$InteractionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({interactionParticipantsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (interactionParticipantsRefs) db.interactionParticipants
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (interactionParticipantsRefs)
                    await $_getPrefetchedData<Interaction, $InteractionsTable,
                            InteractionParticipant>(
                        currentTable: table,
                        referencedTable: $$InteractionsTableReferences
                            ._interactionParticipantsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$InteractionsTableReferences(db, table, p0)
                                .interactionParticipantsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.interactionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$InteractionsTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $InteractionsTable,
    Interaction,
    $$InteractionsTableFilterComposer,
    $$InteractionsTableOrderingComposer,
    $$InteractionsTableAnnotationComposer,
    $$InteractionsTableCreateCompanionBuilder,
    $$InteractionsTableUpdateCompanionBuilder,
    (Interaction, $$InteractionsTableReferences),
    Interaction,
    PrefetchHooks Function({bool interactionParticipantsRefs})>;
typedef $$InteractionParticipantsTableCreateCompanionBuilder
    = InteractionParticipantsCompanion Function({
  required String interactionId,
  required String relationshipId,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$InteractionParticipantsTableUpdateCompanionBuilder
    = InteractionParticipantsCompanion Function({
  Value<String> interactionId,
  Value<String> relationshipId,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$InteractionParticipantsTableReferences extends BaseReferences<
    _$AmioraDatabase, $InteractionParticipantsTable, InteractionParticipant> {
  $$InteractionParticipantsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $InteractionsTable _interactionIdTable(_$AmioraDatabase db) =>
      db.interactions.createAlias(
          'interaction_participants__interaction_id__interactions__id');

  $$InteractionsTableProcessedTableManager get interactionId {
    final $_column = $_itemColumn<String>('interaction_id')!;

    final manager = $$InteractionsTableTableManager($_db, $_db.interactions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_interactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RelationshipsTable _relationshipIdTable(_$AmioraDatabase db) =>
      db.relationships.createAlias(
          'interaction_participants__relationship_id__relationships__id');

  $$RelationshipsTableProcessedTableManager get relationshipId {
    final $_column = $_itemColumn<String>('relationship_id')!;

    final manager = $$RelationshipsTableTableManager($_db, $_db.relationships)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relationshipIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$InteractionParticipantsTableFilterComposer
    extends Composer<_$AmioraDatabase, $InteractionParticipantsTable> {
  $$InteractionParticipantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$InteractionsTableFilterComposer get interactionId {
    final $$InteractionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.interactionId,
        referencedTable: $db.interactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InteractionsTableFilterComposer(
              $db: $db,
              $table: $db.interactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RelationshipsTableFilterComposer get relationshipId {
    final $$RelationshipsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableFilterComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InteractionParticipantsTableOrderingComposer
    extends Composer<_$AmioraDatabase, $InteractionParticipantsTable> {
  $$InteractionParticipantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$InteractionsTableOrderingComposer get interactionId {
    final $$InteractionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.interactionId,
        referencedTable: $db.interactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InteractionsTableOrderingComposer(
              $db: $db,
              $table: $db.interactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RelationshipsTableOrderingComposer get relationshipId {
    final $$RelationshipsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableOrderingComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InteractionParticipantsTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $InteractionParticipantsTable> {
  $$InteractionParticipantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$InteractionsTableAnnotationComposer get interactionId {
    final $$InteractionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.interactionId,
        referencedTable: $db.interactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InteractionsTableAnnotationComposer(
              $db: $db,
              $table: $db.interactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RelationshipsTableAnnotationComposer get relationshipId {
    final $$RelationshipsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableAnnotationComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InteractionParticipantsTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $InteractionParticipantsTable,
    InteractionParticipant,
    $$InteractionParticipantsTableFilterComposer,
    $$InteractionParticipantsTableOrderingComposer,
    $$InteractionParticipantsTableAnnotationComposer,
    $$InteractionParticipantsTableCreateCompanionBuilder,
    $$InteractionParticipantsTableUpdateCompanionBuilder,
    (InteractionParticipant, $$InteractionParticipantsTableReferences),
    InteractionParticipant,
    PrefetchHooks Function({bool interactionId, bool relationshipId})> {
  $$InteractionParticipantsTableTableManager(
      _$AmioraDatabase db, $InteractionParticipantsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InteractionParticipantsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$InteractionParticipantsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InteractionParticipantsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> interactionId = const Value.absent(),
            Value<String> relationshipId = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InteractionParticipantsCompanion(
            interactionId: interactionId,
            relationshipId: relationshipId,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String interactionId,
            required String relationshipId,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InteractionParticipantsCompanion.insert(
            interactionId: interactionId,
            relationshipId: relationshipId,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$InteractionParticipantsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {interactionId = false, relationshipId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (interactionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.interactionId,
                    referencedTable: $$InteractionParticipantsTableReferences
                        ._interactionIdTable(db),
                    referencedColumn: $$InteractionParticipantsTableReferences
                        ._interactionIdTable(db)
                        .id,
                  ) as T;
                }
                if (relationshipId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.relationshipId,
                    referencedTable: $$InteractionParticipantsTableReferences
                        ._relationshipIdTable(db),
                    referencedColumn: $$InteractionParticipantsTableReferences
                        ._relationshipIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$InteractionParticipantsTableProcessedTableManager
    = ProcessedTableManager<
        _$AmioraDatabase,
        $InteractionParticipantsTable,
        InteractionParticipant,
        $$InteractionParticipantsTableFilterComposer,
        $$InteractionParticipantsTableOrderingComposer,
        $$InteractionParticipantsTableAnnotationComposer,
        $$InteractionParticipantsTableCreateCompanionBuilder,
        $$InteractionParticipantsTableUpdateCompanionBuilder,
        (InteractionParticipant, $$InteractionParticipantsTableReferences),
        InteractionParticipant,
        PrefetchHooks Function({bool interactionId, bool relationshipId})>;
typedef $$AlbumsTableCreateCompanionBuilder = AlbumsCompanion Function({
  required String id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  required String title,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$AlbumsTableUpdateCompanionBuilder = AlbumsCompanion Function({
  Value<String> id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> title,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$AlbumsTableReferences
    extends BaseReferences<_$AmioraDatabase, $AlbumsTable, Album> {
  $$AlbumsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MemoriesTable, List<Memory>> _memoriesRefsTable(
          _$AmioraDatabase db) =>
      MultiTypedResultKey.fromTable(db.memories,
          aliasName: 'albums__id__memories__album_id');

  $$MemoriesTableProcessedTableManager get memoriesRefs {
    final manager = $$MemoriesTableTableManager($_db, $_db.memories)
        .filter((f) => f.albumId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_memoriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AlbumsTableFilterComposer
    extends Composer<_$AmioraDatabase, $AlbumsTable> {
  $$AlbumsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> memoriesRefs(
      Expression<bool> Function($$MemoriesTableFilterComposer f) f) {
    final $$MemoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.memories,
        getReferencedColumn: (t) => t.albumId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoriesTableFilterComposer(
              $db: $db,
              $table: $db.memories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AlbumsTableOrderingComposer
    extends Composer<_$AmioraDatabase, $AlbumsTable> {
  $$AlbumsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AlbumsTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $AlbumsTable> {
  $$AlbumsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> memoriesRefs<T extends Object>(
      Expression<T> Function($$MemoriesTableAnnotationComposer a) f) {
    final $$MemoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.memories,
        getReferencedColumn: (t) => t.albumId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.memories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AlbumsTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $AlbumsTable,
    Album,
    $$AlbumsTableFilterComposer,
    $$AlbumsTableOrderingComposer,
    $$AlbumsTableAnnotationComposer,
    $$AlbumsTableCreateCompanionBuilder,
    $$AlbumsTableUpdateCompanionBuilder,
    (Album, $$AlbumsTableReferences),
    Album,
    PrefetchHooks Function({bool memoriesRefs})> {
  $$AlbumsTableTableManager(_$AmioraDatabase db, $AlbumsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlbumsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlbumsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlbumsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumsCompanion(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            title: title,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String title,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumsCompanion.insert(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            title: title,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AlbumsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({memoriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (memoriesRefs) db.memories],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (memoriesRefs)
                    await $_getPrefetchedData<Album, $AlbumsTable, Memory>(
                        currentTable: table,
                        referencedTable:
                            $$AlbumsTableReferences._memoriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AlbumsTableReferences(db, table, p0).memoriesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.albumId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AlbumsTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $AlbumsTable,
    Album,
    $$AlbumsTableFilterComposer,
    $$AlbumsTableOrderingComposer,
    $$AlbumsTableAnnotationComposer,
    $$AlbumsTableCreateCompanionBuilder,
    $$AlbumsTableUpdateCompanionBuilder,
    (Album, $$AlbumsTableReferences),
    Album,
    PrefetchHooks Function({bool memoriesRefs})>;
typedef $$MemoriesTableCreateCompanionBuilder = MemoriesCompanion Function({
  required String id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  required String type,
  Value<String?> title,
  Value<String?> body,
  required DateTime createdAt,
  Value<DateTime?> takenAt,
  Value<String?> albumId,
  Value<int> rowid,
});
typedef $$MemoriesTableUpdateCompanionBuilder = MemoriesCompanion Function({
  Value<String> id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> type,
  Value<String?> title,
  Value<String?> body,
  Value<DateTime> createdAt,
  Value<DateTime?> takenAt,
  Value<String?> albumId,
  Value<int> rowid,
});

final class $$MemoriesTableReferences
    extends BaseReferences<_$AmioraDatabase, $MemoriesTable, Memory> {
  $$MemoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AlbumsTable _albumIdTable(_$AmioraDatabase db) =>
      db.albums.createAlias('memories__album_id__albums__id');

  $$AlbumsTableProcessedTableManager? get albumId {
    final $_column = $_itemColumn<String>('album_id');
    if ($_column == null) return null;
    final manager = $$AlbumsTableTableManager($_db, $_db.albums)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_albumIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MemoryLinksTable, List<MemoryLink>>
      _memoryLinksRefsTable(_$AmioraDatabase db) =>
          MultiTypedResultKey.fromTable(db.memoryLinks,
              aliasName: 'memories__id__memory_links__memory_id');

  $$MemoryLinksTableProcessedTableManager get memoryLinksRefs {
    final manager = $$MemoryLinksTableTableManager($_db, $_db.memoryLinks)
        .filter((f) => f.memoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_memoryLinksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MediaAssetsTable, List<MediaAsset>>
      _mediaAssetsRefsTable(_$AmioraDatabase db) =>
          MultiTypedResultKey.fromTable(db.mediaAssets,
              aliasName: 'memories__id__media_assets__memory_id');

  $$MediaAssetsTableProcessedTableManager get mediaAssetsRefs {
    final manager = $$MediaAssetsTableTableManager($_db, $_db.mediaAssets)
        .filter((f) => f.memoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mediaAssetsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MemoriesTableFilterComposer
    extends Composer<_$AmioraDatabase, $MemoriesTable> {
  $$MemoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
      column: $table.takenAt, builder: (column) => ColumnFilters(column));

  $$AlbumsTableFilterComposer get albumId {
    final $$AlbumsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.albumId,
        referencedTable: $db.albums,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlbumsTableFilterComposer(
              $db: $db,
              $table: $db.albums,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> memoryLinksRefs(
      Expression<bool> Function($$MemoryLinksTableFilterComposer f) f) {
    final $$MemoryLinksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.memoryLinks,
        getReferencedColumn: (t) => t.memoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoryLinksTableFilterComposer(
              $db: $db,
              $table: $db.memoryLinks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> mediaAssetsRefs(
      Expression<bool> Function($$MediaAssetsTableFilterComposer f) f) {
    final $$MediaAssetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mediaAssets,
        getReferencedColumn: (t) => t.memoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MediaAssetsTableFilterComposer(
              $db: $db,
              $table: $db.mediaAssets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MemoriesTableOrderingComposer
    extends Composer<_$AmioraDatabase, $MemoriesTable> {
  $$MemoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
      column: $table.takenAt, builder: (column) => ColumnOrderings(column));

  $$AlbumsTableOrderingComposer get albumId {
    final $$AlbumsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.albumId,
        referencedTable: $db.albums,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlbumsTableOrderingComposer(
              $db: $db,
              $table: $db.albums,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MemoriesTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $MemoriesTable> {
  $$MemoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  $$AlbumsTableAnnotationComposer get albumId {
    final $$AlbumsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.albumId,
        referencedTable: $db.albums,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlbumsTableAnnotationComposer(
              $db: $db,
              $table: $db.albums,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> memoryLinksRefs<T extends Object>(
      Expression<T> Function($$MemoryLinksTableAnnotationComposer a) f) {
    final $$MemoryLinksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.memoryLinks,
        getReferencedColumn: (t) => t.memoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoryLinksTableAnnotationComposer(
              $db: $db,
              $table: $db.memoryLinks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> mediaAssetsRefs<T extends Object>(
      Expression<T> Function($$MediaAssetsTableAnnotationComposer a) f) {
    final $$MediaAssetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mediaAssets,
        getReferencedColumn: (t) => t.memoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MediaAssetsTableAnnotationComposer(
              $db: $db,
              $table: $db.mediaAssets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MemoriesTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $MemoriesTable,
    Memory,
    $$MemoriesTableFilterComposer,
    $$MemoriesTableOrderingComposer,
    $$MemoriesTableAnnotationComposer,
    $$MemoriesTableCreateCompanionBuilder,
    $$MemoriesTableUpdateCompanionBuilder,
    (Memory, $$MemoriesTableReferences),
    Memory,
    PrefetchHooks Function(
        {bool albumId, bool memoryLinksRefs, bool mediaAssetsRefs})> {
  $$MemoriesTableTableManager(_$AmioraDatabase db, $MemoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> body = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> takenAt = const Value.absent(),
            Value<String?> albumId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MemoriesCompanion(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            type: type,
            title: title,
            body: body,
            createdAt: createdAt,
            takenAt: takenAt,
            albumId: albumId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String type,
            Value<String?> title = const Value.absent(),
            Value<String?> body = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> takenAt = const Value.absent(),
            Value<String?> albumId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MemoriesCompanion.insert(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            type: type,
            title: title,
            body: body,
            createdAt: createdAt,
            takenAt: takenAt,
            albumId: albumId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MemoriesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {albumId = false,
              memoryLinksRefs = false,
              mediaAssetsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (memoryLinksRefs) db.memoryLinks,
                if (mediaAssetsRefs) db.mediaAssets
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (albumId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.albumId,
                    referencedTable:
                        $$MemoriesTableReferences._albumIdTable(db),
                    referencedColumn:
                        $$MemoriesTableReferences._albumIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (memoryLinksRefs)
                    await $_getPrefetchedData<Memory, $MemoriesTable,
                            MemoryLink>(
                        currentTable: table,
                        referencedTable:
                            $$MemoriesTableReferences._memoryLinksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MemoriesTableReferences(db, table, p0)
                                .memoryLinksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.memoryId == item.id),
                        typedResults: items),
                  if (mediaAssetsRefs)
                    await $_getPrefetchedData<Memory, $MemoriesTable,
                            MediaAsset>(
                        currentTable: table,
                        referencedTable:
                            $$MemoriesTableReferences._mediaAssetsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MemoriesTableReferences(db, table, p0)
                                .mediaAssetsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.memoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MemoriesTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $MemoriesTable,
    Memory,
    $$MemoriesTableFilterComposer,
    $$MemoriesTableOrderingComposer,
    $$MemoriesTableAnnotationComposer,
    $$MemoriesTableCreateCompanionBuilder,
    $$MemoriesTableUpdateCompanionBuilder,
    (Memory, $$MemoriesTableReferences),
    Memory,
    PrefetchHooks Function(
        {bool albumId, bool memoryLinksRefs, bool mediaAssetsRefs})>;
typedef $$MemoryLinksTableCreateCompanionBuilder = MemoryLinksCompanion
    Function({
  required String memoryId,
  required String relationshipId,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$MemoryLinksTableUpdateCompanionBuilder = MemoryLinksCompanion
    Function({
  Value<String> memoryId,
  Value<String> relationshipId,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$MemoryLinksTableReferences
    extends BaseReferences<_$AmioraDatabase, $MemoryLinksTable, MemoryLink> {
  $$MemoryLinksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MemoriesTable _memoryIdTable(_$AmioraDatabase db) =>
      db.memories.createAlias('memory_links__memory_id__memories__id');

  $$MemoriesTableProcessedTableManager get memoryId {
    final $_column = $_itemColumn<String>('memory_id')!;

    final manager = $$MemoriesTableTableManager($_db, $_db.memories)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RelationshipsTable _relationshipIdTable(_$AmioraDatabase db) =>
      db.relationships
          .createAlias('memory_links__relationship_id__relationships__id');

  $$RelationshipsTableProcessedTableManager get relationshipId {
    final $_column = $_itemColumn<String>('relationship_id')!;

    final manager = $$RelationshipsTableTableManager($_db, $_db.relationships)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relationshipIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MemoryLinksTableFilterComposer
    extends Composer<_$AmioraDatabase, $MemoryLinksTable> {
  $$MemoryLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$MemoriesTableFilterComposer get memoryId {
    final $$MemoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.memoryId,
        referencedTable: $db.memories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoriesTableFilterComposer(
              $db: $db,
              $table: $db.memories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RelationshipsTableFilterComposer get relationshipId {
    final $$RelationshipsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableFilterComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MemoryLinksTableOrderingComposer
    extends Composer<_$AmioraDatabase, $MemoryLinksTable> {
  $$MemoryLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$MemoriesTableOrderingComposer get memoryId {
    final $$MemoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.memoryId,
        referencedTable: $db.memories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoriesTableOrderingComposer(
              $db: $db,
              $table: $db.memories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RelationshipsTableOrderingComposer get relationshipId {
    final $$RelationshipsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableOrderingComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MemoryLinksTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $MemoryLinksTable> {
  $$MemoryLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$MemoriesTableAnnotationComposer get memoryId {
    final $$MemoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.memoryId,
        referencedTable: $db.memories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.memories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RelationshipsTableAnnotationComposer get relationshipId {
    final $$RelationshipsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableAnnotationComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MemoryLinksTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $MemoryLinksTable,
    MemoryLink,
    $$MemoryLinksTableFilterComposer,
    $$MemoryLinksTableOrderingComposer,
    $$MemoryLinksTableAnnotationComposer,
    $$MemoryLinksTableCreateCompanionBuilder,
    $$MemoryLinksTableUpdateCompanionBuilder,
    (MemoryLink, $$MemoryLinksTableReferences),
    MemoryLink,
    PrefetchHooks Function({bool memoryId, bool relationshipId})> {
  $$MemoryLinksTableTableManager(_$AmioraDatabase db, $MemoryLinksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemoryLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemoryLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemoryLinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> memoryId = const Value.absent(),
            Value<String> relationshipId = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MemoryLinksCompanion(
            memoryId: memoryId,
            relationshipId: relationshipId,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String memoryId,
            required String relationshipId,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MemoryLinksCompanion.insert(
            memoryId: memoryId,
            relationshipId: relationshipId,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MemoryLinksTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({memoryId = false, relationshipId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (memoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.memoryId,
                    referencedTable:
                        $$MemoryLinksTableReferences._memoryIdTable(db),
                    referencedColumn:
                        $$MemoryLinksTableReferences._memoryIdTable(db).id,
                  ) as T;
                }
                if (relationshipId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.relationshipId,
                    referencedTable:
                        $$MemoryLinksTableReferences._relationshipIdTable(db),
                    referencedColumn: $$MemoryLinksTableReferences
                        ._relationshipIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MemoryLinksTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $MemoryLinksTable,
    MemoryLink,
    $$MemoryLinksTableFilterComposer,
    $$MemoryLinksTableOrderingComposer,
    $$MemoryLinksTableAnnotationComposer,
    $$MemoryLinksTableCreateCompanionBuilder,
    $$MemoryLinksTableUpdateCompanionBuilder,
    (MemoryLink, $$MemoryLinksTableReferences),
    MemoryLink,
    PrefetchHooks Function({bool memoryId, bool relationshipId})>;
typedef $$MediaAssetsTableCreateCompanionBuilder = MediaAssetsCompanion
    Function({
  required String id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  required String memoryId,
  Value<String?> localPath,
  Value<String?> storagePath,
  Value<String?> thumbStoragePath,
  Value<int?> sizeBytes,
  Value<String> uploadStatus,
  Value<int> rowid,
});
typedef $$MediaAssetsTableUpdateCompanionBuilder = MediaAssetsCompanion
    Function({
  Value<String> id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> memoryId,
  Value<String?> localPath,
  Value<String?> storagePath,
  Value<String?> thumbStoragePath,
  Value<int?> sizeBytes,
  Value<String> uploadStatus,
  Value<int> rowid,
});

final class $$MediaAssetsTableReferences
    extends BaseReferences<_$AmioraDatabase, $MediaAssetsTable, MediaAsset> {
  $$MediaAssetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MemoriesTable _memoryIdTable(_$AmioraDatabase db) =>
      db.memories.createAlias('media_assets__memory_id__memories__id');

  $$MemoriesTableProcessedTableManager get memoryId {
    final $_column = $_itemColumn<String>('memory_id')!;

    final manager = $$MemoriesTableTableManager($_db, $_db.memories)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MediaAssetsTableFilterComposer
    extends Composer<_$AmioraDatabase, $MediaAssetsTable> {
  $$MediaAssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storagePath => $composableBuilder(
      column: $table.storagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thumbStoragePath => $composableBuilder(
      column: $table.thumbStoragePath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uploadStatus => $composableBuilder(
      column: $table.uploadStatus, builder: (column) => ColumnFilters(column));

  $$MemoriesTableFilterComposer get memoryId {
    final $$MemoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.memoryId,
        referencedTable: $db.memories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoriesTableFilterComposer(
              $db: $db,
              $table: $db.memories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MediaAssetsTableOrderingComposer
    extends Composer<_$AmioraDatabase, $MediaAssetsTable> {
  $$MediaAssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storagePath => $composableBuilder(
      column: $table.storagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thumbStoragePath => $composableBuilder(
      column: $table.thumbStoragePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uploadStatus => $composableBuilder(
      column: $table.uploadStatus,
      builder: (column) => ColumnOrderings(column));

  $$MemoriesTableOrderingComposer get memoryId {
    final $$MemoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.memoryId,
        referencedTable: $db.memories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoriesTableOrderingComposer(
              $db: $db,
              $table: $db.memories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MediaAssetsTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $MediaAssetsTable> {
  $$MediaAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get storagePath => $composableBuilder(
      column: $table.storagePath, builder: (column) => column);

  GeneratedColumn<String> get thumbStoragePath => $composableBuilder(
      column: $table.thumbStoragePath, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get uploadStatus => $composableBuilder(
      column: $table.uploadStatus, builder: (column) => column);

  $$MemoriesTableAnnotationComposer get memoryId {
    final $$MemoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.memoryId,
        referencedTable: $db.memories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.memories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MediaAssetsTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $MediaAssetsTable,
    MediaAsset,
    $$MediaAssetsTableFilterComposer,
    $$MediaAssetsTableOrderingComposer,
    $$MediaAssetsTableAnnotationComposer,
    $$MediaAssetsTableCreateCompanionBuilder,
    $$MediaAssetsTableUpdateCompanionBuilder,
    (MediaAsset, $$MediaAssetsTableReferences),
    MediaAsset,
    PrefetchHooks Function({bool memoryId})> {
  $$MediaAssetsTableTableManager(_$AmioraDatabase db, $MediaAssetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaAssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> memoryId = const Value.absent(),
            Value<String?> localPath = const Value.absent(),
            Value<String?> storagePath = const Value.absent(),
            Value<String?> thumbStoragePath = const Value.absent(),
            Value<int?> sizeBytes = const Value.absent(),
            Value<String> uploadStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MediaAssetsCompanion(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            memoryId: memoryId,
            localPath: localPath,
            storagePath: storagePath,
            thumbStoragePath: thumbStoragePath,
            sizeBytes: sizeBytes,
            uploadStatus: uploadStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String memoryId,
            Value<String?> localPath = const Value.absent(),
            Value<String?> storagePath = const Value.absent(),
            Value<String?> thumbStoragePath = const Value.absent(),
            Value<int?> sizeBytes = const Value.absent(),
            Value<String> uploadStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MediaAssetsCompanion.insert(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            memoryId: memoryId,
            localPath: localPath,
            storagePath: storagePath,
            thumbStoragePath: thumbStoragePath,
            sizeBytes: sizeBytes,
            uploadStatus: uploadStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MediaAssetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({memoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (memoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.memoryId,
                    referencedTable:
                        $$MediaAssetsTableReferences._memoryIdTable(db),
                    referencedColumn:
                        $$MediaAssetsTableReferences._memoryIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MediaAssetsTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $MediaAssetsTable,
    MediaAsset,
    $$MediaAssetsTableFilterComposer,
    $$MediaAssetsTableOrderingComposer,
    $$MediaAssetsTableAnnotationComposer,
    $$MediaAssetsTableCreateCompanionBuilder,
    $$MediaAssetsTableUpdateCompanionBuilder,
    (MediaAsset, $$MediaAssetsTableReferences),
    MediaAsset,
    PrefetchHooks Function({bool memoryId})>;
typedef $$ImportantDatesTableCreateCompanionBuilder = ImportantDatesCompanion
    Function({
  required String id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  required String relationshipId,
  required String type,
  required DateTime date,
  Value<bool> recursAnnually,
  Value<String?> label,
  Value<int> rowid,
});
typedef $$ImportantDatesTableUpdateCompanionBuilder = ImportantDatesCompanion
    Function({
  Value<String> id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> relationshipId,
  Value<String> type,
  Value<DateTime> date,
  Value<bool> recursAnnually,
  Value<String?> label,
  Value<int> rowid,
});

final class $$ImportantDatesTableReferences extends BaseReferences<
    _$AmioraDatabase, $ImportantDatesTable, ImportantDate> {
  $$ImportantDatesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RelationshipsTable _relationshipIdTable(_$AmioraDatabase db) =>
      db.relationships
          .createAlias('important_dates__relationship_id__relationships__id');

  $$RelationshipsTableProcessedTableManager get relationshipId {
    final $_column = $_itemColumn<String>('relationship_id')!;

    final manager = $$RelationshipsTableTableManager($_db, $_db.relationships)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relationshipIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ImportantDatesTableFilterComposer
    extends Composer<_$AmioraDatabase, $ImportantDatesTable> {
  $$ImportantDatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get recursAnnually => $composableBuilder(
      column: $table.recursAnnually,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  $$RelationshipsTableFilterComposer get relationshipId {
    final $$RelationshipsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableFilterComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ImportantDatesTableOrderingComposer
    extends Composer<_$AmioraDatabase, $ImportantDatesTable> {
  $$ImportantDatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get recursAnnually => $composableBuilder(
      column: $table.recursAnnually,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  $$RelationshipsTableOrderingComposer get relationshipId {
    final $$RelationshipsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableOrderingComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ImportantDatesTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $ImportantDatesTable> {
  $$ImportantDatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get recursAnnually => $composableBuilder(
      column: $table.recursAnnually, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  $$RelationshipsTableAnnotationComposer get relationshipId {
    final $$RelationshipsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableAnnotationComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ImportantDatesTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $ImportantDatesTable,
    ImportantDate,
    $$ImportantDatesTableFilterComposer,
    $$ImportantDatesTableOrderingComposer,
    $$ImportantDatesTableAnnotationComposer,
    $$ImportantDatesTableCreateCompanionBuilder,
    $$ImportantDatesTableUpdateCompanionBuilder,
    (ImportantDate, $$ImportantDatesTableReferences),
    ImportantDate,
    PrefetchHooks Function({bool relationshipId})> {
  $$ImportantDatesTableTableManager(
      _$AmioraDatabase db, $ImportantDatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImportantDatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImportantDatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImportantDatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> relationshipId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> recursAnnually = const Value.absent(),
            Value<String?> label = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ImportantDatesCompanion(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            relationshipId: relationshipId,
            type: type,
            date: date,
            recursAnnually: recursAnnually,
            label: label,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String relationshipId,
            required String type,
            required DateTime date,
            Value<bool> recursAnnually = const Value.absent(),
            Value<String?> label = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ImportantDatesCompanion.insert(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            relationshipId: relationshipId,
            type: type,
            date: date,
            recursAnnually: recursAnnually,
            label: label,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ImportantDatesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({relationshipId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (relationshipId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.relationshipId,
                    referencedTable: $$ImportantDatesTableReferences
                        ._relationshipIdTable(db),
                    referencedColumn: $$ImportantDatesTableReferences
                        ._relationshipIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ImportantDatesTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $ImportantDatesTable,
    ImportantDate,
    $$ImportantDatesTableFilterComposer,
    $$ImportantDatesTableOrderingComposer,
    $$ImportantDatesTableAnnotationComposer,
    $$ImportantDatesTableCreateCompanionBuilder,
    $$ImportantDatesTableUpdateCompanionBuilder,
    (ImportantDate, $$ImportantDatesTableReferences),
    ImportantDate,
    PrefetchHooks Function({bool relationshipId})>;
typedef $$PromisesTableCreateCompanionBuilder = PromisesCompanion Function({
  required String id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  required String relationshipId,
  required String title,
  Value<DateTime?> dueDate,
  Value<int?> priority,
  Value<String> status,
  Value<int> rowid,
});
typedef $$PromisesTableUpdateCompanionBuilder = PromisesCompanion Function({
  Value<String> id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> relationshipId,
  Value<String> title,
  Value<DateTime?> dueDate,
  Value<int?> priority,
  Value<String> status,
  Value<int> rowid,
});

final class $$PromisesTableReferences
    extends BaseReferences<_$AmioraDatabase, $PromisesTable, Promise> {
  $$PromisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RelationshipsTable _relationshipIdTable(_$AmioraDatabase db) =>
      db.relationships
          .createAlias('promises__relationship_id__relationships__id');

  $$RelationshipsTableProcessedTableManager get relationshipId {
    final $_column = $_itemColumn<String>('relationship_id')!;

    final manager = $$RelationshipsTableTableManager($_db, $_db.relationships)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relationshipIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PromisesTableFilterComposer
    extends Composer<_$AmioraDatabase, $PromisesTable> {
  $$PromisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  $$RelationshipsTableFilterComposer get relationshipId {
    final $$RelationshipsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableFilterComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PromisesTableOrderingComposer
    extends Composer<_$AmioraDatabase, $PromisesTable> {
  $$PromisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  $$RelationshipsTableOrderingComposer get relationshipId {
    final $$RelationshipsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableOrderingComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PromisesTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $PromisesTable> {
  $$PromisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$RelationshipsTableAnnotationComposer get relationshipId {
    final $$RelationshipsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableAnnotationComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PromisesTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $PromisesTable,
    Promise,
    $$PromisesTableFilterComposer,
    $$PromisesTableOrderingComposer,
    $$PromisesTableAnnotationComposer,
    $$PromisesTableCreateCompanionBuilder,
    $$PromisesTableUpdateCompanionBuilder,
    (Promise, $$PromisesTableReferences),
    Promise,
    PrefetchHooks Function({bool relationshipId})> {
  $$PromisesTableTableManager(_$AmioraDatabase db, $PromisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PromisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PromisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PromisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> relationshipId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<int?> priority = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PromisesCompanion(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            relationshipId: relationshipId,
            title: title,
            dueDate: dueDate,
            priority: priority,
            status: status,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String relationshipId,
            required String title,
            Value<DateTime?> dueDate = const Value.absent(),
            Value<int?> priority = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PromisesCompanion.insert(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            relationshipId: relationshipId,
            title: title,
            dueDate: dueDate,
            priority: priority,
            status: status,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PromisesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({relationshipId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (relationshipId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.relationshipId,
                    referencedTable:
                        $$PromisesTableReferences._relationshipIdTable(db),
                    referencedColumn:
                        $$PromisesTableReferences._relationshipIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PromisesTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $PromisesTable,
    Promise,
    $$PromisesTableFilterComposer,
    $$PromisesTableOrderingComposer,
    $$PromisesTableAnnotationComposer,
    $$PromisesTableCreateCompanionBuilder,
    $$PromisesTableUpdateCompanionBuilder,
    (Promise, $$PromisesTableReferences),
    Promise,
    PrefetchHooks Function({bool relationshipId})>;
typedef $$EventsTableCreateCompanionBuilder = EventsCompanion Function({
  required String id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String?> relationshipId,
  required String title,
  required DateTime startsAt,
  Value<String?> kind,
  Value<int> rowid,
});
typedef $$EventsTableUpdateCompanionBuilder = EventsCompanion Function({
  Value<String> id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String?> relationshipId,
  Value<String> title,
  Value<DateTime> startsAt,
  Value<String?> kind,
  Value<int> rowid,
});

final class $$EventsTableReferences
    extends BaseReferences<_$AmioraDatabase, $EventsTable, Event> {
  $$EventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RelationshipsTable _relationshipIdTable(_$AmioraDatabase db) =>
      db.relationships
          .createAlias('events__relationship_id__relationships__id');

  $$RelationshipsTableProcessedTableManager? get relationshipId {
    final $_column = $_itemColumn<String>('relationship_id');
    if ($_column == null) return null;
    final manager = $$RelationshipsTableTableManager($_db, $_db.relationships)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relationshipIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EventsTableFilterComposer
    extends Composer<_$AmioraDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startsAt => $composableBuilder(
      column: $table.startsAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnFilters(column));

  $$RelationshipsTableFilterComposer get relationshipId {
    final $$RelationshipsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableFilterComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventsTableOrderingComposer
    extends Composer<_$AmioraDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startsAt => $composableBuilder(
      column: $table.startsAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnOrderings(column));

  $$RelationshipsTableOrderingComposer get relationshipId {
    final $$RelationshipsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableOrderingComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get startsAt =>
      $composableBuilder(column: $table.startsAt, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  $$RelationshipsTableAnnotationComposer get relationshipId {
    final $$RelationshipsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableAnnotationComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventsTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $EventsTable,
    Event,
    $$EventsTableFilterComposer,
    $$EventsTableOrderingComposer,
    $$EventsTableAnnotationComposer,
    $$EventsTableCreateCompanionBuilder,
    $$EventsTableUpdateCompanionBuilder,
    (Event, $$EventsTableReferences),
    Event,
    PrefetchHooks Function({bool relationshipId})> {
  $$EventsTableTableManager(_$AmioraDatabase db, $EventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String?> relationshipId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> startsAt = const Value.absent(),
            Value<String?> kind = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EventsCompanion(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            relationshipId: relationshipId,
            title: title,
            startsAt: startsAt,
            kind: kind,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String?> relationshipId = const Value.absent(),
            required String title,
            required DateTime startsAt,
            Value<String?> kind = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EventsCompanion.insert(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            relationshipId: relationshipId,
            title: title,
            startsAt: startsAt,
            kind: kind,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$EventsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({relationshipId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (relationshipId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.relationshipId,
                    referencedTable:
                        $$EventsTableReferences._relationshipIdTable(db),
                    referencedColumn:
                        $$EventsTableReferences._relationshipIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EventsTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $EventsTable,
    Event,
    $$EventsTableFilterComposer,
    $$EventsTableOrderingComposer,
    $$EventsTableAnnotationComposer,
    $$EventsTableCreateCompanionBuilder,
    $$EventsTableUpdateCompanionBuilder,
    (Event, $$EventsTableReferences),
    Event,
    PrefetchHooks Function({bool relationshipId})>;
typedef $$PreferencesTableCreateCompanionBuilder = PreferencesCompanion
    Function({
  required String id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  required String relationshipId,
  required String key,
  required String valueJson,
  Value<int> rowid,
});
typedef $$PreferencesTableUpdateCompanionBuilder = PreferencesCompanion
    Function({
  Value<String> id,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> relationshipId,
  Value<String> key,
  Value<String> valueJson,
  Value<int> rowid,
});

final class $$PreferencesTableReferences
    extends BaseReferences<_$AmioraDatabase, $PreferencesTable, Preference> {
  $$PreferencesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RelationshipsTable _relationshipIdTable(_$AmioraDatabase db) =>
      db.relationships
          .createAlias('preferences__relationship_id__relationships__id');

  $$RelationshipsTableProcessedTableManager get relationshipId {
    final $_column = $_itemColumn<String>('relationship_id')!;

    final manager = $$RelationshipsTableTableManager($_db, $_db.relationships)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relationshipIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PreferencesTableFilterComposer
    extends Composer<_$AmioraDatabase, $PreferencesTable> {
  $$PreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get valueJson => $composableBuilder(
      column: $table.valueJson, builder: (column) => ColumnFilters(column));

  $$RelationshipsTableFilterComposer get relationshipId {
    final $$RelationshipsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableFilterComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PreferencesTableOrderingComposer
    extends Composer<_$AmioraDatabase, $PreferencesTable> {
  $$PreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get valueJson => $composableBuilder(
      column: $table.valueJson, builder: (column) => ColumnOrderings(column));

  $$RelationshipsTableOrderingComposer get relationshipId {
    final $$RelationshipsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableOrderingComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PreferencesTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $PreferencesTable> {
  $$PreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get valueJson =>
      $composableBuilder(column: $table.valueJson, builder: (column) => column);

  $$RelationshipsTableAnnotationComposer get relationshipId {
    final $$RelationshipsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableAnnotationComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PreferencesTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $PreferencesTable,
    Preference,
    $$PreferencesTableFilterComposer,
    $$PreferencesTableOrderingComposer,
    $$PreferencesTableAnnotationComposer,
    $$PreferencesTableCreateCompanionBuilder,
    $$PreferencesTableUpdateCompanionBuilder,
    (Preference, $$PreferencesTableReferences),
    Preference,
    PrefetchHooks Function({bool relationshipId})> {
  $$PreferencesTableTableManager(_$AmioraDatabase db, $PreferencesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> relationshipId = const Value.absent(),
            Value<String> key = const Value.absent(),
            Value<String> valueJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PreferencesCompanion(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            relationshipId: relationshipId,
            key: key,
            valueJson: valueJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String relationshipId,
            required String key,
            required String valueJson,
            Value<int> rowid = const Value.absent(),
          }) =>
              PreferencesCompanion.insert(
            id: id,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            relationshipId: relationshipId,
            key: key,
            valueJson: valueJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PreferencesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({relationshipId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (relationshipId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.relationshipId,
                    referencedTable:
                        $$PreferencesTableReferences._relationshipIdTable(db),
                    referencedColumn: $$PreferencesTableReferences
                        ._relationshipIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PreferencesTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $PreferencesTable,
    Preference,
    $$PreferencesTableFilterComposer,
    $$PreferencesTableOrderingComposer,
    $$PreferencesTableAnnotationComposer,
    $$PreferencesTableCreateCompanionBuilder,
    $$PreferencesTableUpdateCompanionBuilder,
    (Preference, $$PreferencesTableReferences),
    Preference,
    PrefetchHooks Function({bool relationshipId})>;
typedef $$PresenceSnapshotsTableCreateCompanionBuilder
    = PresenceSnapshotsCompanion Function({
  required String relationshipId,
  required DateTime date,
  required int scoreCalc,
  required int scoreDisplay,
  Value<String?> componentsJson,
  Value<int> rowid,
});
typedef $$PresenceSnapshotsTableUpdateCompanionBuilder
    = PresenceSnapshotsCompanion Function({
  Value<String> relationshipId,
  Value<DateTime> date,
  Value<int> scoreCalc,
  Value<int> scoreDisplay,
  Value<String?> componentsJson,
  Value<int> rowid,
});

final class $$PresenceSnapshotsTableReferences extends BaseReferences<
    _$AmioraDatabase, $PresenceSnapshotsTable, PresenceSnapshot> {
  $$PresenceSnapshotsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RelationshipsTable _relationshipIdTable(_$AmioraDatabase db) => db
      .relationships
      .createAlias('presence_snapshots__relationship_id__relationships__id');

  $$RelationshipsTableProcessedTableManager get relationshipId {
    final $_column = $_itemColumn<String>('relationship_id')!;

    final manager = $$RelationshipsTableTableManager($_db, $_db.relationships)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relationshipIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PresenceSnapshotsTableFilterComposer
    extends Composer<_$AmioraDatabase, $PresenceSnapshotsTable> {
  $$PresenceSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get scoreCalc => $composableBuilder(
      column: $table.scoreCalc, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get scoreDisplay => $composableBuilder(
      column: $table.scoreDisplay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get componentsJson => $composableBuilder(
      column: $table.componentsJson,
      builder: (column) => ColumnFilters(column));

  $$RelationshipsTableFilterComposer get relationshipId {
    final $$RelationshipsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableFilterComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PresenceSnapshotsTableOrderingComposer
    extends Composer<_$AmioraDatabase, $PresenceSnapshotsTable> {
  $$PresenceSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scoreCalc => $composableBuilder(
      column: $table.scoreCalc, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scoreDisplay => $composableBuilder(
      column: $table.scoreDisplay,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get componentsJson => $composableBuilder(
      column: $table.componentsJson,
      builder: (column) => ColumnOrderings(column));

  $$RelationshipsTableOrderingComposer get relationshipId {
    final $$RelationshipsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableOrderingComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PresenceSnapshotsTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $PresenceSnapshotsTable> {
  $$PresenceSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get scoreCalc =>
      $composableBuilder(column: $table.scoreCalc, builder: (column) => column);

  GeneratedColumn<int> get scoreDisplay => $composableBuilder(
      column: $table.scoreDisplay, builder: (column) => column);

  GeneratedColumn<String> get componentsJson => $composableBuilder(
      column: $table.componentsJson, builder: (column) => column);

  $$RelationshipsTableAnnotationComposer get relationshipId {
    final $$RelationshipsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relationshipId,
        referencedTable: $db.relationships,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RelationshipsTableAnnotationComposer(
              $db: $db,
              $table: $db.relationships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PresenceSnapshotsTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $PresenceSnapshotsTable,
    PresenceSnapshot,
    $$PresenceSnapshotsTableFilterComposer,
    $$PresenceSnapshotsTableOrderingComposer,
    $$PresenceSnapshotsTableAnnotationComposer,
    $$PresenceSnapshotsTableCreateCompanionBuilder,
    $$PresenceSnapshotsTableUpdateCompanionBuilder,
    (PresenceSnapshot, $$PresenceSnapshotsTableReferences),
    PresenceSnapshot,
    PrefetchHooks Function({bool relationshipId})> {
  $$PresenceSnapshotsTableTableManager(
      _$AmioraDatabase db, $PresenceSnapshotsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PresenceSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PresenceSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PresenceSnapshotsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> relationshipId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> scoreCalc = const Value.absent(),
            Value<int> scoreDisplay = const Value.absent(),
            Value<String?> componentsJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PresenceSnapshotsCompanion(
            relationshipId: relationshipId,
            date: date,
            scoreCalc: scoreCalc,
            scoreDisplay: scoreDisplay,
            componentsJson: componentsJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String relationshipId,
            required DateTime date,
            required int scoreCalc,
            required int scoreDisplay,
            Value<String?> componentsJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PresenceSnapshotsCompanion.insert(
            relationshipId: relationshipId,
            date: date,
            scoreCalc: scoreCalc,
            scoreDisplay: scoreDisplay,
            componentsJson: componentsJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PresenceSnapshotsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({relationshipId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (relationshipId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.relationshipId,
                    referencedTable: $$PresenceSnapshotsTableReferences
                        ._relationshipIdTable(db),
                    referencedColumn: $$PresenceSnapshotsTableReferences
                        ._relationshipIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PresenceSnapshotsTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $PresenceSnapshotsTable,
    PresenceSnapshot,
    $$PresenceSnapshotsTableFilterComposer,
    $$PresenceSnapshotsTableOrderingComposer,
    $$PresenceSnapshotsTableAnnotationComposer,
    $$PresenceSnapshotsTableCreateCompanionBuilder,
    $$PresenceSnapshotsTableUpdateCompanionBuilder,
    (PresenceSnapshot, $$PresenceSnapshotsTableReferences),
    PresenceSnapshot,
    PrefetchHooks Function({bool relationshipId})>;
typedef $$AppSettingsTableCreateCompanionBuilder = AppSettingsCompanion
    Function({
  required String key,
  required String valueJson,
  Value<int> rowid,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<String> key,
  Value<String> valueJson,
  Value<int> rowid,
});

class $$AppSettingsTableFilterComposer
    extends Composer<_$AmioraDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get valueJson => $composableBuilder(
      column: $table.valueJson, builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AmioraDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get valueJson => $composableBuilder(
      column: $table.valueJson, builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get valueJson =>
      $composableBuilder(column: $table.valueJson, builder: (column) => column);
}

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (
      AppSetting,
      BaseReferences<_$AmioraDatabase, $AppSettingsTable, AppSetting>
    ),
    AppSetting,
    PrefetchHooks Function()> {
  $$AppSettingsTableTableManager(_$AmioraDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> valueJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            key: key,
            valueJson: valueJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String valueJson,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsCompanion.insert(
            key: key,
            valueJson: valueJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (
      AppSetting,
      BaseReferences<_$AmioraDatabase, $AppSettingsTable, AppSetting>
    ),
    AppSetting,
    PrefetchHooks Function()>;
typedef $$OutboxTableCreateCompanionBuilder = OutboxCompanion Function({
  Value<int> seq,
  required String entity,
  required String entityId,
  required String op,
  required String payloadJson,
  required DateTime createdAt,
  Value<int> attempts,
});
typedef $$OutboxTableUpdateCompanionBuilder = OutboxCompanion Function({
  Value<int> seq,
  Value<String> entity,
  Value<String> entityId,
  Value<String> op,
  Value<String> payloadJson,
  Value<DateTime> createdAt,
  Value<int> attempts,
});

class $$OutboxTableFilterComposer
    extends Composer<_$AmioraDatabase, $OutboxTable> {
  $$OutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get seq => $composableBuilder(
      column: $table.seq, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entity => $composableBuilder(
      column: $table.entity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get op => $composableBuilder(
      column: $table.op, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnFilters(column));
}

class $$OutboxTableOrderingComposer
    extends Composer<_$AmioraDatabase, $OutboxTable> {
  $$OutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get seq => $composableBuilder(
      column: $table.seq, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entity => $composableBuilder(
      column: $table.entity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get op => $composableBuilder(
      column: $table.op, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnOrderings(column));
}

class $$OutboxTableAnnotationComposer
    extends Composer<_$AmioraDatabase, $OutboxTable> {
  $$OutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get seq =>
      $composableBuilder(column: $table.seq, builder: (column) => column);

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get op =>
      $composableBuilder(column: $table.op, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);
}

class $$OutboxTableTableManager extends RootTableManager<
    _$AmioraDatabase,
    $OutboxTable,
    OutboxData,
    $$OutboxTableFilterComposer,
    $$OutboxTableOrderingComposer,
    $$OutboxTableAnnotationComposer,
    $$OutboxTableCreateCompanionBuilder,
    $$OutboxTableUpdateCompanionBuilder,
    (OutboxData, BaseReferences<_$AmioraDatabase, $OutboxTable, OutboxData>),
    OutboxData,
    PrefetchHooks Function()> {
  $$OutboxTableTableManager(_$AmioraDatabase db, $OutboxTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> seq = const Value.absent(),
            Value<String> entity = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> op = const Value.absent(),
            Value<String> payloadJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> attempts = const Value.absent(),
          }) =>
              OutboxCompanion(
            seq: seq,
            entity: entity,
            entityId: entityId,
            op: op,
            payloadJson: payloadJson,
            createdAt: createdAt,
            attempts: attempts,
          ),
          createCompanionCallback: ({
            Value<int> seq = const Value.absent(),
            required String entity,
            required String entityId,
            required String op,
            required String payloadJson,
            required DateTime createdAt,
            Value<int> attempts = const Value.absent(),
          }) =>
              OutboxCompanion.insert(
            seq: seq,
            entity: entity,
            entityId: entityId,
            op: op,
            payloadJson: payloadJson,
            createdAt: createdAt,
            attempts: attempts,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OutboxTableProcessedTableManager = ProcessedTableManager<
    _$AmioraDatabase,
    $OutboxTable,
    OutboxData,
    $$OutboxTableFilterComposer,
    $$OutboxTableOrderingComposer,
    $$OutboxTableAnnotationComposer,
    $$OutboxTableCreateCompanionBuilder,
    $$OutboxTableUpdateCompanionBuilder,
    (OutboxData, BaseReferences<_$AmioraDatabase, $OutboxTable, OutboxData>),
    OutboxData,
    PrefetchHooks Function()>;

class $AmioraDatabaseManager {
  final _$AmioraDatabase _db;
  $AmioraDatabaseManager(this._db);
  $$RelationshipsTableTableManager get relationships =>
      $$RelationshipsTableTableManager(_db, _db.relationships);
  $$InteractionsTableTableManager get interactions =>
      $$InteractionsTableTableManager(_db, _db.interactions);
  $$InteractionParticipantsTableTableManager get interactionParticipants =>
      $$InteractionParticipantsTableTableManager(
          _db, _db.interactionParticipants);
  $$AlbumsTableTableManager get albums =>
      $$AlbumsTableTableManager(_db, _db.albums);
  $$MemoriesTableTableManager get memories =>
      $$MemoriesTableTableManager(_db, _db.memories);
  $$MemoryLinksTableTableManager get memoryLinks =>
      $$MemoryLinksTableTableManager(_db, _db.memoryLinks);
  $$MediaAssetsTableTableManager get mediaAssets =>
      $$MediaAssetsTableTableManager(_db, _db.mediaAssets);
  $$ImportantDatesTableTableManager get importantDates =>
      $$ImportantDatesTableTableManager(_db, _db.importantDates);
  $$PromisesTableTableManager get promises =>
      $$PromisesTableTableManager(_db, _db.promises);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$PreferencesTableTableManager get preferences =>
      $$PreferencesTableTableManager(_db, _db.preferences);
  $$PresenceSnapshotsTableTableManager get presenceSnapshots =>
      $$PresenceSnapshotsTableTableManager(_db, _db.presenceSnapshots);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$OutboxTableTableManager get outbox =>
      $$OutboxTableTableManager(_db, _db.outbox);
}
