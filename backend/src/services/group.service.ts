import { GroupEntity } from "@/entities/group.entity";
import { UserEntity } from "@/entities/users.entity";
import { Service } from "typedi";
import { EntityRepository, Repository } from "typeorm";

@Service()
@EntityRepository()
export class GroupService extends Repository<GroupEntity>{
    public async findMyGroups(userID: number): Promise<GroupEntity[]> {
        const groups: GroupEntity[] = await GroupEntity.find(
            {
                where: { userID: userID }
            }
        );
        return groups;
    }

    public async findGroupById(groupID: number, userID: number,): Promise<GroupEntity> {
        const findGroup: GroupEntity = await GroupEntity.findOne({ where: { id: groupID } });
        if(findGroup.participants.find((participant) => participant.id === userID)){
            return findGroup;
        }
        return null;
    }

    public async createGroup(
        groupName: string,
        userID: number,
        description: string,
    ): Promise<GroupEntity> {
        const findUser: UserEntity = await UserEntity.findOne({ where: { id: userID } });
        const newGroup: GroupEntity = await GroupEntity.create({
            name: groupName,
            description: description,
            participants: [findUser],
        }).save();
        return newGroup;
    }

    public async leaveGroup(groupID: number, userID: number): Promise<GroupEntity> {
        const findGroup: GroupEntity = await GroupEntity.findOne({ where: { id: groupID } });
        const findUser: UserEntity = await UserEntity.findOne({ where: { id: userID } });
        if (findGroup && findUser) {
            findGroup.participants = findGroup.participants.filter((participant) => participant.id !== userID);
            await findGroup.save();
            findUser.groups = findUser.groups.filter((group) => group.id !== groupID);
            await findUser.save();
            return findGroup;
        } else {
            return null;
        }
    }

    public async joinGroup(code: string, userID: number): Promise<GroupEntity> {
        const group = await GroupEntity.findOne({ where: { joinCode: code } });
        if (group) {
            const findUser: UserEntity = await UserEntity.findOne({ where: { id: userID } });
            if (group.participants.find((participant) => participant.id === userID)) {
                return null;
            }
            group.participants.push(findUser);
            findUser.groups.push(group);
            await findUser.save();
            await group.save();
            return group;
        }
        else {
            return null;
        }
    }

    public async shareGroup(groupID: number, userID: number): Promise<GroupEntity> {
        const findGroup: GroupEntity = await GroupEntity.findOne({ where: { id: groupID } });
        if (findGroup.participants.find((participant) => participant.id === userID)) {
            var charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"; //from where to create
            var result = "";
            for (var i = 0; i < 12; i++)
                result += charset[Math.floor(Math.random() * charset.length)];
            findGroup.joinCode = result;
            findGroup.joinCodeExpires = new Date(Date.now() + 1000 * 60 * 60 * 24 * 7);
            await findGroup.save();
            return findGroup;
        }
        else {
            return null;
        }
    }
}