import { GroupEntity } from "@/entities/group.entity";
import { Service } from "typedi";
import { EntityRepository, Repository } from "typeorm";

@Service()
@EntityRepository()
export class GroupService extends Repository<GroupEntity>{
    public async findMyGroups(userID: number): Promise<GroupEntity[]>{
        const groups: GroupEntity[] = await GroupEntity.find(
            {
                where: {userID: userID}
            }
        );
        return groups;
    }

    public async findGroupById(groupID: number): Promise<GroupEntity>{
        const findGroup: GroupEntity = await GroupEntity.findOne({where: {id: groupID}});
        return findGroup;
    }

    public async createGroup(groupName: string, userID: number, description: string, participants: number): Promise<GroupEntity>{
        const newGroup: GroupEntity = await GroupEntity.create({
            name: groupName,
            description: description,
            participants: participants,
        }).save();
        return newGroup;
    }
}