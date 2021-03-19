import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:troco_premiado/shared/models/company.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_account_facade.dart';

class AccountRepository implements IAccountFacade {
  FirebaseFirestore _firestore;

  AccountRepository({FirebaseFirestore firestore}) {
    _firestore = firestore ?? FirebaseFirestore.instance;
  }

  @override
  Future<Account> getAccount(String email) async {
    try {
      var rawDocs = await _firestore
          .collection('auth')
          .where('email', isEqualTo: email)
          .get();
      var doc = rawDocs.docs.first;

      if (doc == null) {
        return null;
      }

      return Account.fromJson(doc.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<Account> registerAccount({String email, String name}) async {
    try {
      var rawDocs = await _firestore
          .collection('auth')
          .where('email', isEqualTo: email)
          .get();

      if (rawDocs.docs.isEmpty) {
        var account = Account(
          email: email,
          name: name,
        ); //id,company serao colocados depois. type vai automatico

        await _firestore.collection('auth').doc().set(account.toJson());

        var newAccount = await _firestore
            .collection('auth')
            .where('email', isEqualTo: email)
            .get();

        final idAccount = newAccount.docs[0].reference.id;

        await newAccount.docs[0].reference.update({'id': idAccount});

        return account..id = idAccount;
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
