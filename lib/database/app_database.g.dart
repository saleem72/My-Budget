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

class DebentureItem extends DataClass implements Insertable<DebentureItem> {
  final int id;
  final int debentureId;
  final int debit;
  final int credit;
  final DateTime date;
  final double amount;
  final String? notes;
  const DebentureItem(
      {required this.id,
      required this.debentureId,
      required this.debit,
      required this.credit,
      required this.date,
      required this.amount,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['debenture_id'] = Variable<int>(debentureId);
    map['debit'] = Variable<int>(debit);
    map['credit'] = Variable<int>(credit);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  DebentureItemsCompanion toCompanion(bool nullToAbsent) {
    return DebentureItemsCompanion(
      id: Value(id),
      debentureId: Value(debentureId),
      debit: Value(debit),
      credit: Value(credit),
      date: Value(date),
      amount: Value(amount),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory DebentureItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DebentureItem(
      id: serializer.fromJson<int>(json['id']),
      debentureId: serializer.fromJson<int>(json['debentureId']),
      debit: serializer.fromJson<int>(json['debit']),
      credit: serializer.fromJson<int>(json['credit']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'debentureId': serializer.toJson<int>(debentureId),
      'debit': serializer.toJson<int>(debit),
      'credit': serializer.toJson<int>(credit),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<double>(amount),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  DebentureItem copyWith(
          {int? id,
          int? debentureId,
          int? debit,
          int? credit,
          DateTime? date,
          double? amount,
          Value<String?> notes = const Value.absent()}) =>
      DebentureItem(
        id: id ?? this.id,
        debentureId: debentureId ?? this.debentureId,
        debit: debit ?? this.debit,
        credit: credit ?? this.credit,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        notes: notes.present ? notes.value : this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('DebentureItem(')
          ..write('id: $id, ')
          ..write('debentureId: $debentureId, ')
          ..write('debit: $debit, ')
          ..write('credit: $credit, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, debentureId, debit, credit, date, amount, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DebentureItem &&
          other.id == this.id &&
          other.debentureId == this.debentureId &&
          other.debit == this.debit &&
          other.credit == this.credit &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.notes == this.notes);
}

class DebentureItemsCompanion extends UpdateCompanion<DebentureItem> {
  final Value<int> id;
  final Value<int> debentureId;
  final Value<int> debit;
  final Value<int> credit;
  final Value<DateTime> date;
  final Value<double> amount;
  final Value<String?> notes;
  const DebentureItemsCompanion({
    this.id = const Value.absent(),
    this.debentureId = const Value.absent(),
    this.debit = const Value.absent(),
    this.credit = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.notes = const Value.absent(),
  });
  DebentureItemsCompanion.insert({
    this.id = const Value.absent(),
    required int debentureId,
    required int debit,
    required int credit,
    required DateTime date,
    required double amount,
    this.notes = const Value.absent(),
  })  : debentureId = Value(debentureId),
        debit = Value(debit),
        credit = Value(credit),
        date = Value(date),
        amount = Value(amount);
  static Insertable<DebentureItem> custom({
    Expression<int>? id,
    Expression<int>? debentureId,
    Expression<int>? debit,
    Expression<int>? credit,
    Expression<DateTime>? date,
    Expression<double>? amount,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (debentureId != null) 'debenture_id': debentureId,
      if (debit != null) 'debit': debit,
      if (credit != null) 'credit': credit,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (notes != null) 'notes': notes,
    });
  }

  DebentureItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? debentureId,
      Value<int>? debit,
      Value<int>? credit,
      Value<DateTime>? date,
      Value<double>? amount,
      Value<String?>? notes}) {
    return DebentureItemsCompanion(
      id: id ?? this.id,
      debentureId: debentureId ?? this.debentureId,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (debentureId.present) {
      map['debenture_id'] = Variable<int>(debentureId.value);
    }
    if (debit.present) {
      map['debit'] = Variable<int>(debit.value);
    }
    if (credit.present) {
      map['credit'] = Variable<int>(credit.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebentureItemsCompanion(')
          ..write('id: $id, ')
          ..write('debentureId: $debentureId, ')
          ..write('debit: $debit, ')
          ..write('credit: $credit, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $DebentureItemsTable extends DebentureItems
    with TableInfo<$DebentureItemsTable, DebentureItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebentureItemsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _debentureIdMeta =
      const VerificationMeta('debentureId');
  @override
  late final GeneratedColumn<int> debentureId = GeneratedColumn<int>(
      'debenture_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "debentures" ("id")');
  final VerificationMeta _debitMeta = const VerificationMeta('debit');
  @override
  late final GeneratedColumn<int> debit = GeneratedColumn<int>(
      'debit', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "accounts" ("id")');
  final VerificationMeta _creditMeta = const VerificationMeta('credit');
  @override
  late final GeneratedColumn<int> credit = GeneratedColumn<int>(
      'credit', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "accounts" ("id")');
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, debentureId, debit, credit, date, amount, notes];
  @override
  String get aliasedName => _alias ?? 'debenture_items';
  @override
  String get actualTableName => 'debenture_items';
  @override
  VerificationContext validateIntegrity(Insertable<DebentureItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('debenture_id')) {
      context.handle(
          _debentureIdMeta,
          debentureId.isAcceptableOrUnknown(
              data['debenture_id']!, _debentureIdMeta));
    } else if (isInserting) {
      context.missing(_debentureIdMeta);
    }
    if (data.containsKey('debit')) {
      context.handle(
          _debitMeta, debit.isAcceptableOrUnknown(data['debit']!, _debitMeta));
    } else if (isInserting) {
      context.missing(_debitMeta);
    }
    if (data.containsKey('credit')) {
      context.handle(_creditMeta,
          credit.isAcceptableOrUnknown(data['credit']!, _creditMeta));
    } else if (isInserting) {
      context.missing(_creditMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
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
  DebentureItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DebentureItem(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      debentureId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}debenture_id'])!,
      debit: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}debit'])!,
      credit: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}credit'])!,
      date: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      amount: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      notes: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $DebentureItemsTable createAlias(String alias) {
    return $DebentureItemsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final int debentureId;
  final int source;
  final int related;
  final bool isCredit;
  final DateTime date;
  final double amount;
  final String? notes;
  const Transaction(
      {required this.id,
      required this.debentureId,
      required this.source,
      required this.related,
      required this.isCredit,
      required this.date,
      required this.amount,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['debenture_id'] = Variable<int>(debentureId);
    map['source'] = Variable<int>(source);
    map['related'] = Variable<int>(related);
    map['is_credit'] = Variable<bool>(isCredit);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      debentureId: Value(debentureId),
      source: Value(source),
      related: Value(related),
      isCredit: Value(isCredit),
      date: Value(date),
      amount: Value(amount),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      debentureId: serializer.fromJson<int>(json['debentureId']),
      source: serializer.fromJson<int>(json['source']),
      related: serializer.fromJson<int>(json['related']),
      isCredit: serializer.fromJson<bool>(json['isCredit']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'debentureId': serializer.toJson<int>(debentureId),
      'source': serializer.toJson<int>(source),
      'related': serializer.toJson<int>(related),
      'isCredit': serializer.toJson<bool>(isCredit),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<double>(amount),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Transaction copyWith(
          {int? id,
          int? debentureId,
          int? source,
          int? related,
          bool? isCredit,
          DateTime? date,
          double? amount,
          Value<String?> notes = const Value.absent()}) =>
      Transaction(
        id: id ?? this.id,
        debentureId: debentureId ?? this.debentureId,
        source: source ?? this.source,
        related: related ?? this.related,
        isCredit: isCredit ?? this.isCredit,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        notes: notes.present ? notes.value : this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('debentureId: $debentureId, ')
          ..write('source: $source, ')
          ..write('related: $related, ')
          ..write('isCredit: $isCredit, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, debentureId, source, related, isCredit, date, amount, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.debentureId == this.debentureId &&
          other.source == this.source &&
          other.related == this.related &&
          other.isCredit == this.isCredit &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.notes == this.notes);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<int> debentureId;
  final Value<int> source;
  final Value<int> related;
  final Value<bool> isCredit;
  final Value<DateTime> date;
  final Value<double> amount;
  final Value<String?> notes;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.debentureId = const Value.absent(),
    this.source = const Value.absent(),
    this.related = const Value.absent(),
    this.isCredit = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.notes = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int debentureId,
    required int source,
    required int related,
    this.isCredit = const Value.absent(),
    required DateTime date,
    required double amount,
    this.notes = const Value.absent(),
  })  : debentureId = Value(debentureId),
        source = Value(source),
        related = Value(related),
        date = Value(date),
        amount = Value(amount);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? debentureId,
    Expression<int>? source,
    Expression<int>? related,
    Expression<bool>? isCredit,
    Expression<DateTime>? date,
    Expression<double>? amount,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (debentureId != null) 'debenture_id': debentureId,
      if (source != null) 'source': source,
      if (related != null) 'related': related,
      if (isCredit != null) 'is_credit': isCredit,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (notes != null) 'notes': notes,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? debentureId,
      Value<int>? source,
      Value<int>? related,
      Value<bool>? isCredit,
      Value<DateTime>? date,
      Value<double>? amount,
      Value<String?>? notes}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      debentureId: debentureId ?? this.debentureId,
      source: source ?? this.source,
      related: related ?? this.related,
      isCredit: isCredit ?? this.isCredit,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (debentureId.present) {
      map['debenture_id'] = Variable<int>(debentureId.value);
    }
    if (source.present) {
      map['source'] = Variable<int>(source.value);
    }
    if (related.present) {
      map['related'] = Variable<int>(related.value);
    }
    if (isCredit.present) {
      map['is_credit'] = Variable<bool>(isCredit.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('debentureId: $debentureId, ')
          ..write('source: $source, ')
          ..write('related: $related, ')
          ..write('isCredit: $isCredit, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _debentureIdMeta =
      const VerificationMeta('debentureId');
  @override
  late final GeneratedColumn<int> debentureId = GeneratedColumn<int>(
      'debenture_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "debentures" ("id")');
  final VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<int> source = GeneratedColumn<int>(
      'source', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "accounts" ("id")');
  final VerificationMeta _relatedMeta = const VerificationMeta('related');
  @override
  late final GeneratedColumn<int> related = GeneratedColumn<int>(
      'related', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "accounts" ("id")');
  final VerificationMeta _isCreditMeta = const VerificationMeta('isCredit');
  @override
  late final GeneratedColumn<bool> isCredit = GeneratedColumn<bool>(
      'is_credit', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("is_credit" IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, debentureId, source, related, isCredit, date, amount, notes];
  @override
  String get aliasedName => _alias ?? 'transactions';
  @override
  String get actualTableName => 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('debenture_id')) {
      context.handle(
          _debentureIdMeta,
          debentureId.isAcceptableOrUnknown(
              data['debenture_id']!, _debentureIdMeta));
    } else if (isInserting) {
      context.missing(_debentureIdMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('related')) {
      context.handle(_relatedMeta,
          related.isAcceptableOrUnknown(data['related']!, _relatedMeta));
    } else if (isInserting) {
      context.missing(_relatedMeta);
    }
    if (data.containsKey('is_credit')) {
      context.handle(_isCreditMeta,
          isCredit.isAcceptableOrUnknown(data['is_credit']!, _isCreditMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
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
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      debentureId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}debenture_id'])!,
      source: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}source'])!,
      related: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}related'])!,
      isCredit: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_credit'])!,
      date: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      amount: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      notes: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Bill extends DataClass implements Insertable<Bill> {
  final int id;
  final String? notes;
  final DateTime date;
  const Bill({required this.id, this.notes, required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  BillsCompanion toCompanion(bool nullToAbsent) {
    return BillsCompanion(
      id: Value(id),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      date: Value(date),
    );
  }

  factory Bill.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bill(
      id: serializer.fromJson<int>(json['id']),
      notes: serializer.fromJson<String?>(json['notes']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'notes': serializer.toJson<String?>(notes),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Bill copyWith(
          {int? id,
          Value<String?> notes = const Value.absent(),
          DateTime? date}) =>
      Bill(
        id: id ?? this.id,
        notes: notes.present ? notes.value : this.notes,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Bill(')
          ..write('id: $id, ')
          ..write('notes: $notes, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, notes, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bill &&
          other.id == this.id &&
          other.notes == this.notes &&
          other.date == this.date);
}

class BillsCompanion extends UpdateCompanion<Bill> {
  final Value<int> id;
  final Value<String?> notes;
  final Value<DateTime> date;
  const BillsCompanion({
    this.id = const Value.absent(),
    this.notes = const Value.absent(),
    this.date = const Value.absent(),
  });
  BillsCompanion.insert({
    this.id = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime date,
  }) : date = Value(date);
  static Insertable<Bill> custom({
    Expression<int>? id,
    Expression<String>? notes,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notes != null) 'notes': notes,
      if (date != null) 'date': date,
    });
  }

  BillsCompanion copyWith(
      {Value<int>? id, Value<String?>? notes, Value<DateTime>? date}) {
    return BillsCompanion(
      id: id ?? this.id,
      notes: notes ?? this.notes,
      date: date ?? this.date,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillsCompanion(')
          ..write('id: $id, ')
          ..write('notes: $notes, ')
          ..write('date: $date')
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
  @override
  List<GeneratedColumn> get $columns => [id, notes, date];
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
  late final $DebentureItemsTable debentureItems = $DebentureItemsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
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
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        subjects,
        accounts,
        debentures,
        debentureItems,
        transactions,
        bills,
        billItems
      ];
}
