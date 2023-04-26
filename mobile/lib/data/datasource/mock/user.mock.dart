import 'package:pay_cutter/data/models/user/user.model.dart';

abstract class UserMock {
  static UserModel getUser() => const UserModel(
        avatarUrl:
            'https://znews-photo.zingcdn.me/w660/Uploaded/mdf_eioxrd/2021_07_06/2.jpg',
        email: 'email@email.com',
        name: 'Full name',
        userID: 12,
      );

  static List<UserModel> getUsers() => List.generate(
        4,
        (index) => const UserModel(
          avatarUrl:
              'https://znews-photo.zingcdn.me/w660/Uploaded/mdf_eioxrd/2021_07_06/2.jpg',
          email: 'email@email.com',
          name: 'Full name',
          userID: 12,
        ),
      );
}
