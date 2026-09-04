import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/user_model.dart';



class AuthService {


  final FirebaseAuth _auth =
      FirebaseAuth.instance;


  final FirebaseDatabase _database =
      FirebaseDatabase.instance;





  Future<UserModel?> register({

    required String name,

    required String email,

    required String password,

    required String role,

  }) async {


    try {


      UserCredential credential =

      await _auth
          .createUserWithEmailAndPassword(

        email: email,

        password: password,

      );



      User user =
          credential.user!;




      UserModel userModel = UserModel(


        userId: user.uid,


        name: name,


        email: email,


        role: role,


        createdAt:
        DateTime.now()
            .millisecondsSinceEpoch,


      );




      await _database

          .ref("users/${user.uid}")

          .set(
          userModel.toJson()
      );



      return userModel;



    }catch(e){


      print(
          "REGISTER ERROR = $e"
      );


      return null;


    }


  }









  Future<UserModel?> login({

    required String email,

    required String password,

  }) async {


    try{


      UserCredential credential =

      await _auth
          .signInWithEmailAndPassword(

        email: email,

        password: password,

      );



      User user =
          credential.user!;



      DatabaseEvent event =

      await _database

          .ref(
          "users/${user.uid}"
      )

          .once();





      if(event.snapshot.value == null){

        return null;

      }




      return UserModel.fromJson(

        Map<String,dynamic>.from(

          event.snapshot.value as Map,

        ),

      );




    }on FirebaseAuthException catch(e){


      print(
          "LOGIN ERROR = ${e.code}"
      );


      return null;



    }catch(e){


      print(
          "LOGIN GENERAL ERROR = $e"
      );


      return null;


    }



  }




  Future<void> logout() async {


    await _auth.signOut();


  }



}