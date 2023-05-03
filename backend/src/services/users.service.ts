import { hash } from 'bcrypt';
import { EntityRepository, Repository } from 'typeorm';
import { Service } from 'typedi';
import { UserEntity } from '@entities/users.entity';
import { HttpException } from '@exceptions/HttpException';
import { User } from '@interfaces/users.interface';
import axios, { AxiosResponse } from 'axios';

@Service()
@EntityRepository()
export class UserService extends Repository<UserEntity> {
  public async findAllUser(): Promise<User[]> {
    const users: User[] = await UserEntity.find();
    return users;
  }

  public async findUserById(userId: number): Promise<User> {
    const findUser: User = await UserEntity.findOne({ where: { id: userId } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    return findUser;
  }

  public async createUser(userData: User): Promise<User> {
    var url = 'https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=' + userData.googleToken;
    var user: User;
    var response: AxiosResponse<any, any>;
    try{
      response = await axios.get(url);
    }
    catch(e){
      if(e.response.status == 400){
        throw new HttpException(409, "Token doesn't match email");
      }
      else throw new HttpException(409, "Error");
    }
    if (userData.email != response.data.email) throw new HttpException(409, "Token doesn't match email");
    else {
      var findUser: User = await UserEntity.findOne({ where: { email: userData.email } });
      if(findUser == null){
        const createUserData: User = await UserEntity.create({ ...userData }).save();
        // findUser = createUserData;
        return createUserData;
      }
      // user = findUser;
      // return findUser;
      return findUser;
    }
    // return user;
    //  xmlHttp.open("GET", url, true); // false for synchronous request
    //  xmlHttp.send(null);
    // xmlHttp.onreadystatechange = async function () {
    //   // check if request is complete
    //   if (xmlHttp.readyState === 4) {
    //     // check if request is successful
    //     if (xmlHttp.status === 200) {
    //       // success
    //       var response = JSON.parse(xmlHttp.responseText);
    //       if (userData.email != response.email) {
    //         throw new HttpException(409, "Token doesn't match email");
    //       }
    //       else {
    //         console.log('Oke')
    //         const findUser: User = await UserEntity.findOne({ where: { email: userData.email } });
    //         // if (findUser) throw new HttpException(409, `This email ${userData.email} already exists`);

    //         // const hashedPassword = await hash(userData.password, 10);
    //         // const createUserData: User = await UserEntity.create({ ...userData, password: hashedPassword }).save();

    //         return findUser;
    //       }
    //     } else {
    //       // error
    //       console.log(xmlHttp.statusText);
    //       throw new HttpException(409, "Token doesn't match email");
    //     }
    //   }
    // }
    // xmlHttp.onerror = function (e) {
    //   console.log(e)
    // }
  }

  public async updateUser(userId: number, userData: User): Promise<User> {
    const findUser: User = await UserEntity.findOne({ where: { id: userId } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    await UserEntity.update(userId, { ...userData });

    const updateUser: User = await UserEntity.findOne({ where: { id: userId } });
    return updateUser;
  }

  public async deleteUser(userId: number): Promise<User> {
    const findUser: User = await UserEntity.findOne({ where: { id: userId } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    await UserEntity.delete({ id: userId });
    return findUser;
  }
}
