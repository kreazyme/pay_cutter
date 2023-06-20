import { CATEGORY_TABLE, CategoryEntity } from "@/entities/category.entity";
import { GroupEntity } from "@/entities/group.entity";
import { Service } from "typedi";
import { EntityRepository, Repository } from "typeorm";

@Service()
@EntityRepository()
export class CategoryService extends Repository<CategoryEntity>{
    public async findCategoryByGroupId(id: number) : Promise<CategoryEntity[]> {
        console.log(id)
        const findCategory: CategoryEntity[] = await CategoryEntity
            .createQueryBuilder(CATEGORY_TABLE)
            .where(`${CATEGORY_TABLE}.group_id = :id`, {id: id})
            .getMany();
        return findCategory;
    }

    public async createCategory(
        name: string,
        groupId: number,
        description?: string,
    ) : Promise<CategoryEntity> {
        const newCategory = new CategoryEntity();
        newCategory.name = name;
        if(description) newCategory.description = description;
        const findGroup = await GroupEntity.findOne(groupId);
        console.log(findGroup);
        newCategory.group = findGroup;
        return newCategory.save();
    }
}