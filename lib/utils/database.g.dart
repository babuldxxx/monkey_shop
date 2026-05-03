// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserDataTable extends UserData with TableInfo<$UserDataTable, UserDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loginMeta = const VerificationMeta('login');
  @override
  late final GeneratedColumn<String> login = GeneratedColumn<String>(
    'login',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('user'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, login, password, role];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_data';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('login')) {
      context.handle(
        _loginMeta,
        login.isAcceptableOrUnknown(data['login']!, _loginMeta),
      );
    } else if (isInserting) {
      context.missing(_loginMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      login: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
    );
  }

  @override
  $UserDataTable createAlias(String alias) {
    return $UserDataTable(attachedDatabase, alias);
  }
}

class UserDto extends DataClass implements Insertable<UserDto> {
  final int id;
  final String name;
  final String login;
  final String password;
  final String role;
  const UserDto({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    required this.role,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['login'] = Variable<String>(login);
    map['password'] = Variable<String>(password);
    map['role'] = Variable<String>(role);
    return map;
  }

  UserDataCompanion toCompanion(bool nullToAbsent) {
    return UserDataCompanion(
      id: Value(id),
      name: Value(name),
      login: Value(login),
      password: Value(password),
      role: Value(role),
    );
  }

  factory UserDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserDto(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      login: serializer.fromJson<String>(json['login']),
      password: serializer.fromJson<String>(json['password']),
      role: serializer.fromJson<String>(json['role']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'login': serializer.toJson<String>(login),
      'password': serializer.toJson<String>(password),
      'role': serializer.toJson<String>(role),
    };
  }

  UserDto copyWith({
    int? id,
    String? name,
    String? login,
    String? password,
    String? role,
  }) => UserDto(
    id: id ?? this.id,
    name: name ?? this.name,
    login: login ?? this.login,
    password: password ?? this.password,
    role: role ?? this.role,
  );
  UserDto copyWithCompanion(UserDataCompanion data) {
    return UserDto(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      login: data.login.present ? data.login.value : this.login,
      password: data.password.present ? data.password.value : this.password,
      role: data.role.present ? data.role.value : this.role,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserDto(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('login: $login, ')
          ..write('password: $password, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, login, password, role);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDto &&
          other.id == this.id &&
          other.name == this.name &&
          other.login == this.login &&
          other.password == this.password &&
          other.role == this.role);
}

class UserDataCompanion extends UpdateCompanion<UserDto> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> login;
  final Value<String> password;
  final Value<String> role;
  const UserDataCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.login = const Value.absent(),
    this.password = const Value.absent(),
    this.role = const Value.absent(),
  });
  UserDataCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String login,
    required String password,
    this.role = const Value.absent(),
  }) : name = Value(name),
       login = Value(login),
       password = Value(password);
  static Insertable<UserDto> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? login,
    Expression<String>? password,
    Expression<String>? role,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (login != null) 'login': login,
      if (password != null) 'password': password,
      if (role != null) 'role': role,
    });
  }

  UserDataCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? login,
    Value<String>? password,
    Value<String>? role,
  }) {
    return UserDataCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      login: login ?? this.login,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (login.present) {
      map['login'] = Variable<String>(login.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserDataCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('login: $login, ')
          ..write('password: $password, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }
}

class $ProductDataTable extends ProductData
    with TableInfo<$ProductDataTable, ProductDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageDataMeta = const VerificationMeta(
    'imageData',
  );
  @override
  late final GeneratedColumn<Uint8List> imageData = GeneratedColumn<Uint8List>(
    'image_data',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qrDataMeta = const VerificationMeta('qrData');
  @override
  late final GeneratedColumn<String> qrData = GeneratedColumn<String>(
    'qr_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<int> createdBy = GeneratedColumn<int>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    imageData,
    status,
    qrData,
    createdBy,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_data';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_data')) {
      context.handle(
        _imageDataMeta,
        imageData.isAcceptableOrUnknown(data['image_data']!, _imageDataMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('qr_data')) {
      context.handle(
        _qrDataMeta,
        qrData.isAcceptableOrUnknown(data['qr_data']!, _qrDataMeta),
      );
    } else if (isInserting) {
      context.missing(_qrDataMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      imageData: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}image_data'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      qrData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qr_data'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_by'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $ProductDataTable createAlias(String alias) {
    return $ProductDataTable(attachedDatabase, alias);
  }
}

class ProductDto extends DataClass implements Insertable<ProductDto> {
  final int id;
  final String name;
  final String description;
  final Uint8List? imageData;
  final String status;
  final String qrData;
  final int createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const ProductDto({
    required this.id,
    required this.name,
    required this.description,
    this.imageData,
    required this.status,
    required this.qrData,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || imageData != null) {
      map['image_data'] = Variable<Uint8List>(imageData);
    }
    map['status'] = Variable<String>(status);
    map['qr_data'] = Variable<String>(qrData);
    map['created_by'] = Variable<int>(createdBy);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ProductDataCompanion toCompanion(bool nullToAbsent) {
    return ProductDataCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      imageData: imageData == null && nullToAbsent
          ? const Value.absent()
          : Value(imageData),
      status: Value(status),
      qrData: Value(qrData),
      createdBy: Value(createdBy),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ProductDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductDto(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      imageData: serializer.fromJson<Uint8List?>(json['imageData']),
      status: serializer.fromJson<String>(json['status']),
      qrData: serializer.fromJson<String>(json['qrData']),
      createdBy: serializer.fromJson<int>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'imageData': serializer.toJson<Uint8List?>(imageData),
      'status': serializer.toJson<String>(status),
      'qrData': serializer.toJson<String>(qrData),
      'createdBy': serializer.toJson<int>(createdBy),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ProductDto copyWith({
    int? id,
    String? name,
    String? description,
    Value<Uint8List?> imageData = const Value.absent(),
    String? status,
    String? qrData,
    int? createdBy,
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => ProductDto(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    imageData: imageData.present ? imageData.value : this.imageData,
    status: status ?? this.status,
    qrData: qrData ?? this.qrData,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  ProductDto copyWithCompanion(ProductDataCompanion data) {
    return ProductDto(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      imageData: data.imageData.present ? data.imageData.value : this.imageData,
      status: data.status.present ? data.status.value : this.status,
      qrData: data.qrData.present ? data.qrData.value : this.qrData,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductDto(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageData: $imageData, ')
          ..write('status: $status, ')
          ..write('qrData: $qrData, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    $driftBlobEquality.hash(imageData),
    status,
    qrData,
    createdBy,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductDto &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          $driftBlobEquality.equals(other.imageData, this.imageData) &&
          other.status == this.status &&
          other.qrData == this.qrData &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductDataCompanion extends UpdateCompanion<ProductDto> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<Uint8List?> imageData;
  final Value<String> status;
  final Value<String> qrData;
  final Value<int> createdBy;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  const ProductDataCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageData = const Value.absent(),
    this.status = const Value.absent(),
    this.qrData = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProductDataCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    this.imageData = const Value.absent(),
    required String status,
    required String qrData,
    required int createdBy,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       description = Value(description),
       status = Value(status),
       qrData = Value(qrData),
       createdBy = Value(createdBy);
  static Insertable<ProductDto> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<Uint8List>? imageData,
    Expression<String>? status,
    Expression<String>? qrData,
    Expression<int>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageData != null) 'image_data': imageData,
      if (status != null) 'status': status,
      if (qrData != null) 'qr_data': qrData,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProductDataCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<Uint8List?>? imageData,
    Value<String>? status,
    Value<String>? qrData,
    Value<int>? createdBy,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return ProductDataCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageData: imageData ?? this.imageData,
      status: status ?? this.status,
      qrData: qrData ?? this.qrData,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageData.present) {
      map['image_data'] = Variable<Uint8List>(imageData.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (qrData.present) {
      map['qr_data'] = Variable<String>(qrData.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<int>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductDataCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageData: $imageData, ')
          ..write('status: $status, ')
          ..write('qrData: $qrData, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TakeDataTable extends TakeData with TableInfo<$TakeDataTable, TakeDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TakeDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
    'taken_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _returnedAtMeta = const VerificationMeta(
    'returnedAt',
  );
  @override
  late final GeneratedColumn<DateTime> returnedAt = GeneratedColumn<DateTime>(
    'returned_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    productId,
    takenAt,
    returnedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'take_data';
  @override
  VerificationContext validateIntegrity(
    Insertable<TakeDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    } else if (isInserting) {
      context.missing(_takenAtMeta);
    }
    if (data.containsKey('returned_at')) {
      context.handle(
        _returnedAtMeta,
        returnedAt.isAcceptableOrUnknown(data['returned_at']!, _returnedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TakeDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TakeDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      takenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}taken_at'],
      )!,
      returnedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}returned_at'],
      ),
    );
  }

  @override
  $TakeDataTable createAlias(String alias) {
    return $TakeDataTable(attachedDatabase, alias);
  }
}

class TakeDto extends DataClass implements Insertable<TakeDto> {
  final int id;
  final int userId;
  final int productId;
  final DateTime takenAt;
  final DateTime? returnedAt;
  const TakeDto({
    required this.id,
    required this.userId,
    required this.productId,
    required this.takenAt,
    this.returnedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['product_id'] = Variable<int>(productId);
    map['taken_at'] = Variable<DateTime>(takenAt);
    if (!nullToAbsent || returnedAt != null) {
      map['returned_at'] = Variable<DateTime>(returnedAt);
    }
    return map;
  }

  TakeDataCompanion toCompanion(bool nullToAbsent) {
    return TakeDataCompanion(
      id: Value(id),
      userId: Value(userId),
      productId: Value(productId),
      takenAt: Value(takenAt),
      returnedAt: returnedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(returnedAt),
    );
  }

  factory TakeDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TakeDto(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      productId: serializer.fromJson<int>(json['productId']),
      takenAt: serializer.fromJson<DateTime>(json['takenAt']),
      returnedAt: serializer.fromJson<DateTime?>(json['returnedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'productId': serializer.toJson<int>(productId),
      'takenAt': serializer.toJson<DateTime>(takenAt),
      'returnedAt': serializer.toJson<DateTime?>(returnedAt),
    };
  }

  TakeDto copyWith({
    int? id,
    int? userId,
    int? productId,
    DateTime? takenAt,
    Value<DateTime?> returnedAt = const Value.absent(),
  }) => TakeDto(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    productId: productId ?? this.productId,
    takenAt: takenAt ?? this.takenAt,
    returnedAt: returnedAt.present ? returnedAt.value : this.returnedAt,
  );
  TakeDto copyWithCompanion(TakeDataCompanion data) {
    return TakeDto(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      productId: data.productId.present ? data.productId.value : this.productId,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      returnedAt: data.returnedAt.present
          ? data.returnedAt.value
          : this.returnedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TakeDto(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('productId: $productId, ')
          ..write('takenAt: $takenAt, ')
          ..write('returnedAt: $returnedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, productId, takenAt, returnedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TakeDto &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.productId == this.productId &&
          other.takenAt == this.takenAt &&
          other.returnedAt == this.returnedAt);
}

class TakeDataCompanion extends UpdateCompanion<TakeDto> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> productId;
  final Value<DateTime> takenAt;
  final Value<DateTime?> returnedAt;
  const TakeDataCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.productId = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.returnedAt = const Value.absent(),
  });
  TakeDataCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required int productId,
    required DateTime takenAt,
    this.returnedAt = const Value.absent(),
  }) : userId = Value(userId),
       productId = Value(productId),
       takenAt = Value(takenAt);
  static Insertable<TakeDto> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? productId,
    Expression<DateTime>? takenAt,
    Expression<DateTime>? returnedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (productId != null) 'product_id': productId,
      if (takenAt != null) 'taken_at': takenAt,
      if (returnedAt != null) 'returned_at': returnedAt,
    });
  }

  TakeDataCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<int>? productId,
    Value<DateTime>? takenAt,
    Value<DateTime?>? returnedAt,
  }) {
    return TakeDataCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      takenAt: takenAt ?? this.takenAt,
      returnedAt: returnedAt ?? this.returnedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    if (returnedAt.present) {
      map['returned_at'] = Variable<DateTime>(returnedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TakeDataCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('productId: $productId, ')
          ..write('takenAt: $takenAt, ')
          ..write('returnedAt: $returnedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $UserDataTable userData = $UserDataTable(this);
  late final $ProductDataTable productData = $ProductDataTable(this);
  late final $TakeDataTable takeData = $TakeDataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userData,
    productData,
    takeData,
  ];
}

typedef $$UserDataTableCreateCompanionBuilder =
    UserDataCompanion Function({
      Value<int> id,
      required String name,
      required String login,
      required String password,
      Value<String> role,
    });
typedef $$UserDataTableUpdateCompanionBuilder =
    UserDataCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> login,
      Value<String> password,
      Value<String> role,
    });

class $$UserDataTableFilterComposer
    extends Composer<_$Database, $UserDataTable> {
  $$UserDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get login => $composableBuilder(
    column: $table.login,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserDataTableOrderingComposer
    extends Composer<_$Database, $UserDataTable> {
  $$UserDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get login => $composableBuilder(
    column: $table.login,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserDataTableAnnotationComposer
    extends Composer<_$Database, $UserDataTable> {
  $$UserDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get login =>
      $composableBuilder(column: $table.login, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);
}

class $$UserDataTableTableManager
    extends
        RootTableManager<
          _$Database,
          $UserDataTable,
          UserDto,
          $$UserDataTableFilterComposer,
          $$UserDataTableOrderingComposer,
          $$UserDataTableAnnotationComposer,
          $$UserDataTableCreateCompanionBuilder,
          $$UserDataTableUpdateCompanionBuilder,
          (UserDto, BaseReferences<_$Database, $UserDataTable, UserDto>),
          UserDto,
          PrefetchHooks Function()
        > {
  $$UserDataTableTableManager(_$Database db, $UserDataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> login = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> role = const Value.absent(),
              }) => UserDataCompanion(
                id: id,
                name: name,
                login: login,
                password: password,
                role: role,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String login,
                required String password,
                Value<String> role = const Value.absent(),
              }) => UserDataCompanion.insert(
                id: id,
                name: name,
                login: login,
                password: password,
                role: role,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserDataTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $UserDataTable,
      UserDto,
      $$UserDataTableFilterComposer,
      $$UserDataTableOrderingComposer,
      $$UserDataTableAnnotationComposer,
      $$UserDataTableCreateCompanionBuilder,
      $$UserDataTableUpdateCompanionBuilder,
      (UserDto, BaseReferences<_$Database, $UserDataTable, UserDto>),
      UserDto,
      PrefetchHooks Function()
    >;
typedef $$ProductDataTableCreateCompanionBuilder =
    ProductDataCompanion Function({
      Value<int> id,
      required String name,
      required String description,
      Value<Uint8List?> imageData,
      required String status,
      required String qrData,
      required int createdBy,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$ProductDataTableUpdateCompanionBuilder =
    ProductDataCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<Uint8List?> imageData,
      Value<String> status,
      Value<String> qrData,
      Value<int> createdBy,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$ProductDataTableFilterComposer
    extends Composer<_$Database, $ProductDataTable> {
  $$ProductDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get imageData => $composableBuilder(
    column: $table.imageData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrData => $composableBuilder(
    column: $table.qrData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductDataTableOrderingComposer
    extends Composer<_$Database, $ProductDataTable> {
  $$ProductDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get imageData => $composableBuilder(
    column: $table.imageData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrData => $composableBuilder(
    column: $table.qrData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductDataTableAnnotationComposer
    extends Composer<_$Database, $ProductDataTable> {
  $$ProductDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get imageData =>
      $composableBuilder(column: $table.imageData, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get qrData =>
      $composableBuilder(column: $table.qrData, builder: (column) => column);

  GeneratedColumn<int> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProductDataTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProductDataTable,
          ProductDto,
          $$ProductDataTableFilterComposer,
          $$ProductDataTableOrderingComposer,
          $$ProductDataTableAnnotationComposer,
          $$ProductDataTableCreateCompanionBuilder,
          $$ProductDataTableUpdateCompanionBuilder,
          (
            ProductDto,
            BaseReferences<_$Database, $ProductDataTable, ProductDto>,
          ),
          ProductDto,
          PrefetchHooks Function()
        > {
  $$ProductDataTableTableManager(_$Database db, $ProductDataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<Uint8List?> imageData = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> qrData = const Value.absent(),
                Value<int> createdBy = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => ProductDataCompanion(
                id: id,
                name: name,
                description: description,
                imageData: imageData,
                status: status,
                qrData: qrData,
                createdBy: createdBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
                Value<Uint8List?> imageData = const Value.absent(),
                required String status,
                required String qrData,
                required int createdBy,
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => ProductDataCompanion.insert(
                id: id,
                name: name,
                description: description,
                imageData: imageData,
                status: status,
                qrData: qrData,
                createdBy: createdBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductDataTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProductDataTable,
      ProductDto,
      $$ProductDataTableFilterComposer,
      $$ProductDataTableOrderingComposer,
      $$ProductDataTableAnnotationComposer,
      $$ProductDataTableCreateCompanionBuilder,
      $$ProductDataTableUpdateCompanionBuilder,
      (ProductDto, BaseReferences<_$Database, $ProductDataTable, ProductDto>),
      ProductDto,
      PrefetchHooks Function()
    >;
typedef $$TakeDataTableCreateCompanionBuilder =
    TakeDataCompanion Function({
      Value<int> id,
      required int userId,
      required int productId,
      required DateTime takenAt,
      Value<DateTime?> returnedAt,
    });
typedef $$TakeDataTableUpdateCompanionBuilder =
    TakeDataCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<int> productId,
      Value<DateTime> takenAt,
      Value<DateTime?> returnedAt,
    });

class $$TakeDataTableFilterComposer
    extends Composer<_$Database, $TakeDataTable> {
  $$TakeDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TakeDataTableOrderingComposer
    extends Composer<_$Database, $TakeDataTable> {
  $$TakeDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TakeDataTableAnnotationComposer
    extends Composer<_$Database, $TakeDataTable> {
  $$TakeDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  GeneratedColumn<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => column,
  );
}

class $$TakeDataTableTableManager
    extends
        RootTableManager<
          _$Database,
          $TakeDataTable,
          TakeDto,
          $$TakeDataTableFilterComposer,
          $$TakeDataTableOrderingComposer,
          $$TakeDataTableAnnotationComposer,
          $$TakeDataTableCreateCompanionBuilder,
          $$TakeDataTableUpdateCompanionBuilder,
          (TakeDto, BaseReferences<_$Database, $TakeDataTable, TakeDto>),
          TakeDto,
          PrefetchHooks Function()
        > {
  $$TakeDataTableTableManager(_$Database db, $TakeDataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TakeDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TakeDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TakeDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<DateTime> takenAt = const Value.absent(),
                Value<DateTime?> returnedAt = const Value.absent(),
              }) => TakeDataCompanion(
                id: id,
                userId: userId,
                productId: productId,
                takenAt: takenAt,
                returnedAt: returnedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required int productId,
                required DateTime takenAt,
                Value<DateTime?> returnedAt = const Value.absent(),
              }) => TakeDataCompanion.insert(
                id: id,
                userId: userId,
                productId: productId,
                takenAt: takenAt,
                returnedAt: returnedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TakeDataTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $TakeDataTable,
      TakeDto,
      $$TakeDataTableFilterComposer,
      $$TakeDataTableOrderingComposer,
      $$TakeDataTableAnnotationComposer,
      $$TakeDataTableCreateCompanionBuilder,
      $$TakeDataTableUpdateCompanionBuilder,
      (TakeDto, BaseReferences<_$Database, $TakeDataTable, TakeDto>),
      TakeDto,
      PrefetchHooks Function()
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$UserDataTableTableManager get userData =>
      $$UserDataTableTableManager(_db, _db.userData);
  $$ProductDataTableTableManager get productData =>
      $$ProductDataTableTableManager(_db, _db.productData);
  $$TakeDataTableTableManager get takeData =>
      $$TakeDataTableTableManager(_db, _db.takeData);
}
