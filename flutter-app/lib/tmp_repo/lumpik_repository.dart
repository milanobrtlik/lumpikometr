import 'abstract_repository.dart';

class LumpikEntity extends Entity {
  final String name;
  final String iconUrl;

  LumpikEntity({required super.id, required this.name, required this.iconUrl});
}

class LumpikRepository extends Repository<LumpikEntity> {
  LumpikRepository()
      : super(
          [
            LumpikEntity(
              id: 1,
              name: 'Maty',
              iconUrl:
                  'https://creazilla-store.fra1.digitaloceanspaces.com/icons/7911322/avatar-icon-md.png',
            ),
            LumpikEntity(
              id: 2,
              name: 'Simik',
              iconUrl:
                  'https://creazilla-store.fra1.digitaloceanspaces.com/icons/7912642/avatar-icon-md.png',
            ),
          ],
        );
}
