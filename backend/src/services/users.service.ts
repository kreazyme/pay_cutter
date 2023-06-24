import { hash } from 'bcrypt';
import { EntityRepository, Repository } from 'typeorm';
import { Service } from 'typedi';
import { UserEntity } from '@entities/users.entity';
import { HttpException } from '@exceptions/HttpException';
import { User } from '@interfaces/users.interface';
import axios, { AxiosResponse } from 'axios';
import { DataStoredInToken, TokenData } from '@/interfaces/auth.interface';
import { SECRET_KEY } from '@/config';
import { sign } from 'jsonwebtoken';

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
    const url = 'https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=' + userData.googleToken;
    let response: AxiosResponse<any, any>;
    try {
      response = await axios.get(url);
    } catch (e) {
      if (e.response.status == 400) {
        throw new HttpException(409, "Token doesn't match email");
      } else throw new HttpException(409, 'Error');
    }
    if (userData.email != response.data.email) throw new HttpException(409, "Token doesn't match email");
    else {
      const findUser: User = await UserEntity.findOne({ where: { email: userData.email } });
      if (findUser == null) {
        const createUserData: User = await UserEntity.create({ ...userData }).save();
        return createUserData;
      }
      else{
        // update fcm token
        await UserEntity.update(findUser.id, { ...userData });
        const updateUser: User = await UserEntity.findOne({ where: { id: findUser.id } });
        return updateUser;
      }
    }
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
