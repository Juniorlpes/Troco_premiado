import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:troco_premiado/shared/cache/cache_box_enum.dart';
import 'package:troco_premiado/shared/cache/cache_controller.dart';
import 'package:troco_premiado/shared/models/company.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_account.dart';

class AccountRepository implements IAccount {
  FirebaseFirestore _firestore;

  AccountRepository({FirebaseFirestore firestore}) {
    _firestore = firestore ?? FirebaseFirestore.instance;
  }

  @override
  Future<Account> getAccount(String email) async {
    final accountCache =
        CacheController<Account>(cacheBoxEnum: CacheBox.Account);

    // var cachedAccount = await accountCache.getByKey('account');

    // if (cachedAccount != null && cachedAccount.active ?? false) {
    //   return cachedAccount;
    // }

    try {
      var rawDocs = await _firestore
          .collection('auth')
          .where('email', isEqualTo: email)
          .get();
      var doc = rawDocs.docs.first;

      if (doc == null) {
        return null;
      }

      await accountCache.writeByKey('account', Account.fromJson(doc.data()));

      return Account.fromJson(doc.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<Account> registerAccount({String email, String name}) async {
    final accountCache =
        CacheController<Account>(cacheBoxEnum: CacheBox.Account);
    try {
      var rawDocs = await _firestore
          .collection('auth')
          .where('email', isEqualTo: email)
          .get();

      if (rawDocs.docs.isEmpty) {
        var account = Account(
          email: email,
          name: name,
          active: false,
          company: null,
          //id: null, se o id for o doc referency, o attr id é desnecessario
          idCompany: null,
        );

        await _firestore.collection('auth').doc().set(account.toJson());

        await accountCache.writeByKey('account', account);

        return account;
      }

      return await getAccount(email);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<Company> getCompany(String companyId) async {
    try {
      var doc = await _firestore.collection('companies').doc(companyId).get();
      if (doc == null) {
        return null;
      }
      return Company.fromJson(doc.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<bool> setLocationCompany() {
    // TODO: implement setLocationCompany
    throw UnimplementedError();
  }
}
