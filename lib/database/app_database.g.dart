// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Subject extends DataClass implements Insertable<Subject> {
  final int id;
  final int? parentId;
  final String title;
  const Subject({required this.id, this.parentId, required this.title});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['title'] = Variable<String>(title);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      title: Value(title),
    );
  }

  factory Subject.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int?>(parentId),
      'title': serializer.toJson<String>(title),
    };
  }

  Subject copyWith(
          {int? id,
          Value<int?> parentId = const Value.absent(),
          String? title}) =>
      Subject(
        id: id ?? this.id,
        parentId: parentId.present ? parentId.value : this.parentId,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parentId, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.title == this.title);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<String> title;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.title = const Value.absent(),
  });
  SubjectsCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    required String title,
  }) : title = Value(title);
  static Insertable<Subject> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (title != null) 'title': title,
    });
  }

  SubjectsCompanion copyWith(
      {Value<int>? id, Value<int?>? parentId, Value<String>? title}) {
    return SubjectsCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES subjects(id) ON DELETE CASCADE');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title =
      GeneratedColumn<String>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 2,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, parentId, title];
  @override
  String get aliasedName => _alias ?? 'subjects';
  @override
  String get actualTableName => 'subjects';
  @override
  VerificationContext validateIntegrity(Insertable<Subject> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parentId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final int id;
  final int? parentId;
  final String title;
  final bool isCredit;
  const Account(
      {required this.id,
      this.parentId,
      required this.title,
      required this.isCredit});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['title'] = Variable<String>(title);
    map['is_credit'] = Variable<bool>(isCredit);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      title: Value(title),
      isCredit: Value(isCredit),
    );
  }

  factory Account.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      title: serializer.fromJson<String>(json['title']),
      isCredit: serializer.fromJson<bool>(json['isCredit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int?>(parentId),
      'title': serializer.toJson<String>(title),
      'isCredit': serializer.toJson<bool>(isCredit),
    };
  }

  Account copyWith(
          {int? id,
          Value<int?> parentId = const Value.absent(),
          String? title,
          bool? isCredit}) =>
      Account(
        id: id ?? this.id,
        parentId: parentId.present ? parentId.value : this.parentId,
        title: title ?? this.title,
        isCredit: isCredit ?? this.isCredit,
      );
  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('title: $title, ')
          ..write('isCredit: $isCredit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parentId, title, isCredit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.title == this.title &&
          other.isCredit == this.isCredit);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<String> title;
  final Value<bool> isCredit;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.title = const Value.absent(),
    this.isCredit = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    required String title,
    required bool isCredit,
  })  : title = Value(title),
        isCredit = Value(isCredit);
  static Insertable<Account> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<String>? title,
    Expression<bool>? isCredit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (title != null) 'title': title,
      if (isCredit != null) 'is_credit': isCredit,
    });
  }

  AccountsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? parentId,
      Value<String>? title,
      Value<bool>? isCredit}) {
    return AccountsCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      title: title ?? this.title,
      isCredit: isCredit ?? this.isCredit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isCredit.present) {
      map['is_credit'] = Variable<bool>(isCredit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('title: $title, ')
          ..write('isCredit: $isCredit')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES accounts(id) ON DELETE CASCADE');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title =
      GeneratedColumn<String>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 2,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  final VerificationMeta _isCreditMeta = const VerificationMeta('isCredit');
  @override
  late final GeneratedColumn<bool> isCredit = GeneratedColumn<bool>(
      'is_credit', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK ("is_credit" IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [id, parentId, title, isCredit];
  @override
  String get aliasedName => _alias ?? 'accounts';
  @override
  String get actualTableName => 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<Account> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_credit')) {
      context.handle(_isCreditMeta,
          isCredit.isAcceptableOrUnknown(data['is_credit']!, _isCreditMeta));
    } else if (isInserting) {
      context.missing(_isCreditMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parentId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      isCredit: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_credit'])!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Debenture extends DataClass implements Insertable<Debenture> {
  final int id;

  /// the opreation type(bill, journal, ....) which generate this Debentures
  final int source;

  /// the opreation id which generate this Debentures
  final int sourceId;
  const Debenture(
      {required this.id, required this.source, required this.sourceId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source'] = Variable<int>(source);
    map['source_id'] = Variable<int>(sourceId);
    return map;
  }

  DebenturesCompanion toCompanion(bool nullToAbsent) {
    return DebenturesCompanion(
      id: Value(id),
      source: Value(source),
      sourceId: Value(sourceId),
    );
  }

  factory Debenture.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Debenture(
      id: serializer.fromJson<int>(json['id']),
      source: serializer.fromJson<int>(json['source']),
      sourceId: serializer.fromJson<int>(json['sourceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'source': serializer.toJson<int>(source),
      'sourceId': serializer.toJson<int>(sourceId),
    };
  }

  Debenture copyWith({int? id, int? source, int? sourceId}) => Debenture(
        id: id ?? this.id,
        source: source ?? this.source,
        sourceId: sourceId ?? this.sourceId,
      );
  @override
  String toString() {
    return (StringBuffer('Debenture(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, source, sourceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Debenture &&
          other.id == this.id &&
          other.source == this.source &&
          other.sourceId == this.sourceId);
}

class DebenturesCompanion extends UpdateCompanion<Debenture> {
  final Value<int> id;
  final Value<int> source;
  final Value<int> sourceId;
  const DebenturesCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceId = const Value.absent(),
  });
  DebenturesCompanion.insert({
    this.id = const Value.absent(),
    required int source,
    required int sourceId,
  })  : source = Value(source),
        sourceId = Value(sourceId);
  static Insertable<Debenture> custom({
    Expression<int>? id,
    Expression<int>? source,
    Expression<int>? sourceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (sourceId != null) 'source_id': sourceId,
    });
  }

  DebenturesCompanion copyWith(
      {Value<int>? id, Value<int>? source, Value<int>? sourceId}) {
    return DebenturesCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceId: sourceId ?? this.sourceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<int>(source.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<int>(sourceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebenturesCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId')
          ..write(')'))
        .toString();
  }
}

class $DebenturesTable extends Debentures
    with TableInfo<$DebenturesTable, Debenture> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebenturesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<int> source = GeneratedColumn<int>(
      'source', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _sourceIdMeta = const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<int> sourceId = GeneratedColumn<int>(
      'source_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, source, sourceId];
  @override
  String get aliasedName => _alias ?? 'debentures';
  @override
  String get actualTableName => 'debentures';
  @override
  VerificationContext validateIntegrity(Insertable<Debenture> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Debenture map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Debenture(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      source: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}source'])!,
      sourceId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}source_id'])!,
    );
  }

  @override
  $DebenturesTable createAlias(String alias) {
    return $DebenturesTable(attachedDatabase, alias);
  }
}

class Bill extends DataClass implements Insertable<Bill> {
  final int id;
  final String? notes;
  final DateTime date;
  final double total;
  const Bill(
      {required this.id, this.notes, required this.date, required this.total});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['date'] = Variable<DateTime>(date);
    map['total'] = Variable<double>(total);
    return map;
  }

  BillsCompanion toCompanion(bool nullToAbsent) {
    return BillsCompanion(
      id: Value(id),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      date: Value(date),
      total: Value(total),
    );
  }

  factory Bill.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bill(
      id: serializer.fromJson<int>(json['id']),
      notes: serializer.fromJson<String?>(json['notes']),
      date: serializer.fromJson<DateTime>(json['date']),
      total: serializer.fromJson<double>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'notes': serializer.toJson<String?>(notes),
      'date': serializer.toJson<DateTime>(date),
      'total': serializer.toJson<double>(total),
    };
  }

  Bill copyWith(
          {int? id,
          Value<String?> notes = const Value.absent(),
          DateTime? date,
          double? total}) =>
      Bill(
        id: id ?? this.id,
        notes: notes.present ? notes.value : this.notes,
        date: date ?? this.date,
        total: total ?? this.total,
      );
  @override
  String toString() {
    return (StringBuffer('Bill(')
          ..write('id: $id, ')
          ..write('notes: $notes, ')
          ..write('date: $date, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, notes, date, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bill &&
          other.id == this.id &&
          other.notes == this.notes &&
          other.date == this.date &&
          other.total == this.total);
}

class BillsCompanion extends UpdateCompanion<Bill> {
  final Value<int> id;
  final Value<String?> notes;
  final Value<DateTime> date;
  final Value<double> total;
  const BillsCompanion({
    this.id = const Value.absent(),
    this.notes = const Value.absent(),
    this.date = const Value.absent(),
    this.total = const Value.absent(),
  });
  BillsCompanion.insert({
    this.id = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime date,
    required double total,
  })  : date = Value(date),
        total = Value(total);
  static Insertable<Bill> custom({
    Expression<int>? id,
    Expression<String>? notes,
    Expression<DateTime>? date,
    Expression<double>? total,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notes != null) 'notes': notes,
      if (date != null) 'date': date,
      if (total != null) 'total': total,
    });
  }

  BillsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? notes,
      Value<DateTime>? date,
      Value<double>? total}) {
    return BillsCompanion(
      id: id ?? this.id,
      notes: notes ?? this.notes,
      date: date ?? this.date,
      total: total ?? this.total,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillsCompanion(')
          ..write('id: $id, ')
          ..write('notes: $notes, ')
          ..write('date: $date, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }
}

class $BillsTable extends Bills with TableInfo<$BillsTable, Bill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, notes, date, total];
  @override
  String get aliasedName => _alias ?? 'bills';
  @override
  String get actualTableName => 'bills';
  @override
  VerificationContext validateIntegrity(Insertable<Bill> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bill(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      notes: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      date: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      total: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
    );
  }

  @override
  $BillsTable createAlias(String alias) {
    return $BillsTable(attachedDatabase, alias);
  }
}

class BillItem extends DataClass implements Insertable<BillItem> {
  final int id;
  final int? parentId;
  final int? subjectId;
  final int quantity;
  final double price;
  final String? notes;
  const BillItem(
      {required this.id,
      this.parentId,
      this.subjectId,
      required this.quantity,
      required this.price,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<int>(subjectId);
    }
    map['quantity'] = Variable<int>(quantity);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  BillItemsCompanion toCompanion(bool nullToAbsent) {
    return BillItemsCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
      quantity: Value(quantity),
      price: Value(price),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory BillItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillItem(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      subjectId: serializer.fromJson<int?>(json['subjectId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      price: serializer.fromJson<double>(json['price']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int?>(parentId),
      'subjectId': serializer.toJson<int?>(subjectId),
      'quantity': serializer.toJson<int>(quantity),
      'price': serializer.toJson<double>(price),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  BillItem copyWith(
          {int? id,
          Value<int?> parentId = const Value.absent(),
          Value<int?> subjectId = const Value.absent(),
          int? quantity,
          double? price,
          Value<String?> notes = const Value.absent()}) =>
      BillItem(
        id: id ?? this.id,
        parentId: parentId.present ? parentId.value : this.parentId,
        subjectId: subjectId.present ? subjectId.value : this.subjectId,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        notes: notes.present ? notes.value : this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('BillItem(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('subjectId: $subjectId, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, parentId, subjectId, quantity, price, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillItem &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.subjectId == this.subjectId &&
          other.quantity == this.quantity &&
          other.price == this.price &&
          other.notes == this.notes);
}

class BillItemsCompanion extends UpdateCompanion<BillItem> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<int?> subjectId;
  final Value<int> quantity;
  final Value<double> price;
  final Value<String?> notes;
  const BillItemsCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.price = const Value.absent(),
    this.notes = const Value.absent(),
  });
  BillItemsCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.quantity = const Value.absent(),
    required double price,
    this.notes = const Value.absent(),
  }) : price = Value(price);
  static Insertable<BillItem> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<int>? subjectId,
    Expression<int>? quantity,
    Expression<double>? price,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (subjectId != null) 'subject_id': subjectId,
      if (quantity != null) 'quantity': quantity,
      if (price != null) 'price': price,
      if (notes != null) 'notes': notes,
    });
  }

  BillItemsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? parentId,
      Value<int?>? subjectId,
      Value<int>? quantity,
      Value<double>? price,
      Value<String?>? notes}) {
    return BillItemsCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      subjectId: subjectId ?? this.subjectId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillItemsCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('subjectId: $subjectId, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $BillItemsTable extends BillItems
    with TableInfo<$BillItemsTable, BillItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillItemsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES bills(id) ON DELETE CASCADE');
  final VerificationMeta _subjectIdMeta = const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
      'subject_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES subjects(id) ON DELETE CASCADE');
  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, parentId, subjectId, quantity, price, notes];
  @override
  String get aliasedName => _alias ?? 'bill_items';
  @override
  String get actualTableName => 'bill_items';
  @override
  VerificationContext validateIntegrity(Insertable<BillItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillItem(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parentId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      subjectId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}subject_id']),
      quantity: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      price: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      notes: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $BillItemsTable createAlias(String alias) {
    return $BillItemsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $DebenturesTable debentures = $DebenturesTable(this);
  late final $BillsTable bills = $BillsTable(this);
  late final $BillItemsTable billItems = $BillItemsTable(this);
  late final SubjectsDao subjectsDao = SubjectsDao(this as AppDatabase);
  late final AccountsDao accountsDao = AccountsDao(this as AppDatabase);
  late final DebenturesDao debenturesDao = DebenturesDao(this as AppDatabase);
  late final BillsDao billsDao = BillsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [subjects, accounts, debentures, bills, billItems];
}
