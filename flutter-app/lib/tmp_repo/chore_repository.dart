import 'abstract_repository.dart';

class ChoreEntity extends Entity {
  ChoreEntity({required super.id, required this.label});

  final String label;
}

class ChoreRepository extends Repository<ChoreEntity> {
  ChoreRepository()
      : super(
          [
            ChoreEntity(id: 1, label: 'Trim houseplants'),
          ],
        );
}
