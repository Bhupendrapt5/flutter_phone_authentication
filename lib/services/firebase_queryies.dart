import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FireBaseQueries {
  final db = Firestore.instance;
  Future<void> addNewDocumentToSubCollection(
      {@required DocumentSnapshot snap,
      @required Map<String, dynamic> data,
      @required String subCollectionName}) async {
    try {
      await db.runTransaction((transaction) async {
        DocumentSnapshot freshSnap = await transaction.get(
            snap.reference.collection(subCollectionName.trim()).document());
        await transaction.set(freshSnap.reference, data);
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateDocument({
    @required Map<String, dynamic> data,
    @required DocumentSnapshot snap,
  }) async {
    try {
      await db.runTransaction((transaction) async {
        DocumentSnapshot freshSnap = await transaction.get(snap.reference);
        await transaction.update(freshSnap.reference, data);
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> removeArrayItemFromDocumentField({
    @required DocumentSnapshot snap,
    @required String fieldName,
    @required String value,
  }) async {
    try {
      await Firestore.instance.runTransaction((transaction) async {
        DocumentSnapshot freshSnap = await transaction.get(snap.reference);

        await transaction.update(freshSnap.reference, <String, dynamic>{
          fieldName.trim(): FieldValue.arrayRemove(<String>[value.trim()]),
        }).catchError((Error error) {
          print('transaction faild');
          throw error;
        });
      });
    } catch (err) {
      print('Cannor remove array Item : ${err.toString()}');
      rethrow;
    }
  }

  Future<void> addArrayItemToDocumentField({
    @required DocumentSnapshot snap,
    @required String fieldName,
    @required String value,
  }) async {
    try {
      await Firestore.instance.runTransaction((transaction) async {
        DocumentSnapshot freshSnap = await transaction.get(snap.reference);

        await transaction.update(freshSnap.reference, <String, dynamic>{
          fieldName.trim(): FieldValue.arrayUnion(<String>[value.trim()]),
        }).catchError((Error error) {
          print('transaction faild');
          throw error;
        });
      });
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateSingleFieldInDocument({
    @required DocumentSnapshot documentSnapshot,
    @required String fieldName,
    @required String fieldValue,
  }) async {
    try {
      await Firestore.instance.runTransaction((transaction) async {
        DocumentSnapshot freshSnap =
            await transaction.get(documentSnapshot.reference);
        await transaction.update(freshSnap.reference, <String, String>{
          fieldName: fieldValue,
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deletDocument({
    @required DocumentSnapshot snap,
  }) async {
    try {
      await db.runTransaction((transaction) async {
        await transaction.delete(snap.reference);
      });
    } catch (error) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> streamUserData(String authorId) {
    return db
        .collection('Profile')
        .where('author', isEqualTo: authorId)
        .where('flags.primary_info', isEqualTo: true)
        .limit(1)
        .snapshots();
  }
}
