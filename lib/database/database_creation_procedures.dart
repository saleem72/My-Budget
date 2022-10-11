//

import 'package:drift/drift.dart';

import 'app_database.dart';

List<SubjectsCompanion> mainSubjects() => [
      SubjectsCompanion.insert(id: const Value(1), title: 'Food'),
      SubjectsCompanion.insert(id: const Value(2), title: 'Electricity'),
      SubjectsCompanion.insert(id: const Value(3), title: 'CLothes'),
    ];

List<SubjectsCompanion> foodSubSubjects() => [
      SubjectsCompanion.insert(parentId: const Value(1), title: 'Bread'),
      SubjectsCompanion.insert(parentId: const Value(1), title: 'Apple'),
      SubjectsCompanion.insert(parentId: const Value(1), title: 'Banana'),
    ];

List<SubjectsCompanion> electricitySubSubjects() => [
      SubjectsCompanion.insert(parentId: const Value(2), title: 'Microwave'),
      SubjectsCompanion.insert(parentId: const Value(2), title: 'TV'),
      SubjectsCompanion.insert(parentId: const Value(2), title: 'Fan'),
    ];

List<SubjectsCompanion> clothesSubSubjects() => [
      SubjectsCompanion.insert(
          id: const Value(4), parentId: const Value(3), title: 'Shirt'),
      SubjectsCompanion.insert(parentId: const Value(3), title: 'Dresses'),
      SubjectsCompanion.insert(parentId: const Value(3), title: 'Trousers'),
    ];

List<SubjectsCompanion> shirtsSubSubjects() => [
      SubjectsCompanion.insert(parentId: const Value(4), title: 'Green'),
      SubjectsCompanion.insert(parentId: const Value(4), title: 'Pink'),
      SubjectsCompanion.insert(parentId: const Value(4), title: 'White'),
    ];
