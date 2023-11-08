import '../models/address_type.dart';

abstract class AddressTypeDatasource {
  Future<List<AddressType>> getAddressTypeList(int entityId);
}
