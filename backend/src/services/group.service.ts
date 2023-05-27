import { GroupEntity } from '@/entities/group.entity';
import { UserEntity } from '@/entities/users.entity';
import { User } from '@/interfaces/users.interface';
import { Service } from 'typedi';
import { EntityRepository, Repository } from 'typeorm';
import { HttpException } from '@exceptions/HttpException';

@Service()
@EntityRepository()
export class GroupService extends Repository<GroupEntity> {
  public async findMyGroups(userID: number): Promise<GroupEntity[]> {
    const groups: GroupEntity[] = await GroupEntity.getRepository()
      .createQueryBuilder('groups')
      .leftJoinAndSelect('groups.participants', 'participants')
      .where('participants.id = :id', { id: userID })
      .select([
        'groups.id',
        'groups.name',
        'groups.description',
        'groups.createdAt',
        'groups.updatedAt',
        'participants.id',
        'participants.email',
        'participants.createdAt',
      ])
      .getMany();
    return groups;
  }

  public async findGroupById(groupID: number, userID: number): Promise<GroupEntity> {
    const findGroup: GroupEntity = await GroupEntity.getRepository()
      .createQueryBuilder('groups')
      .leftJoinAndSelect('groups.participants', 'participants')
      .where('groups.id = :id', { id: groupID })
      .getOne();
    if (findGroup === undefined) {
      throw new HttpException(404, 'Group not found');
    }
    if (findGroup.participants.find(participant => participant.id === userID)) {
      return findGroup;
    }
    throw new HttpException(401, 'Unauthorized');
  }

  public async createGroup(groupName: string, user: User, description: string): Promise<GroupEntity> {
    const newGroup: GroupEntity = await GroupEntity.create({
      name: groupName,
      description: description,
      participants: [user],
    }).save();
    return newGroup;
  }

  public async leaveGroup(groupID: number, userID: number): Promise<GroupEntity> {
    const group: GroupEntity = await GroupEntity.getRepository()
      .createQueryBuilder('groups')
      .leftJoinAndSelect('groups.participants', 'participants')
      .where('groups.id = :id', { id: groupID })
      .getOne();
    if (group) {
      // const findUser: UserEntity = await UserEntity.findOne({ where: { id: userID } });
      if (group.participants.find(participant => participant.id === userID)) {
        // throw new HttpException(409, "User already in group");
        group.participants = group.participants.filter(participant => participant.id !== userID);
        await group.save();
        return group;
      }
      // group.participants.push(findUser);
      // await group.save();
      // return group;
      throw new HttpException(404, 'User not in group');
    } else {
      throw new HttpException(404, 'Group not found');
    }
  }

  public async joinGroup(code: string, userID: number): Promise<GroupEntity> {
    const group: GroupEntity = await GroupEntity.getRepository()
      .createQueryBuilder('groups')
      .leftJoinAndSelect('groups.participants', 'participants')
      .where('groups.joinCode = :joinCode', { joinCode: code })
      .getOne();
    if (group) {
      const findUser: UserEntity = await UserEntity.findOne({ where: { id: userID } });
      if (group.participants.find(participant => participant.id === userID)) {
        throw new HttpException(409, 'User already in group');
      }
      group.participants.push(findUser);
      await group.save();
      return group;
    } else {
      throw new HttpException(404, 'Group not found');
    }
  }

  public async shareGroup(groupID: number, userID: number): Promise<string> {
    const findGroup: GroupEntity = await GroupEntity.getRepository()
      .createQueryBuilder('groups')
      .leftJoinAndSelect('groups.participants', 'participants')
      .where('groups.id = :id', { id: groupID })
      .getOne();
    if (findGroup === undefined) {
      throw new HttpException(404, 'Group not found');
    }
    if (findGroup.participants.find(participant => participant.id === userID)) {
      const charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789'; //from where to create
      let codeGen = '';
      for (let i = 0; i < 12; i++) codeGen += charset[Math.floor(Math.random() * charset.length)];
      findGroup.joinCode = codeGen;
      findGroup.joinCodeExpires = new Date(Date.now() + 1000 * 60 * 60 * 24 * 7);
      await findGroup.save();
      return codeGen;
    }
    throw new HttpException(401, 'Unauthorized');
  }
}
