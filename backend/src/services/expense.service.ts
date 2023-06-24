import { CATEGORY_TABLE, CategoryEntity } from '@/entities/category.entity';
import { ExpenseEntity } from '@/entities/expense.entity';
import { GroupEntity } from '@/entities/group.entity';
import { LocationEntity } from '@/entities/location.entity';
import { UserEntity } from '@/entities/users.entity';
import { HttpException } from '@exceptions/HttpException';
import { Service } from 'typedi';
import { EntityRepository, Repository } from 'typeorm';

@Service()
@EntityRepository()
export class ExpenseService extends Repository<ExpenseEntity> {
  public async findExpense(id: number): Promise<ExpenseEntity> {
    const findExpense :ExpenseEntity = await ExpenseEntity.findOne(
      {
        relations: ['toGroup', 'paidBy', 'participants', 'category', 'createdBy', 'location_id'],
        where: { id: id },
      }
    )
    if (!findExpense) throw new HttpException(404, 'Expense not found');
    return findExpense;
  }

  public async createExpense(
    name: string,
    description: string,
    amount: number,
    paidBy: number,
    groupId: number,
    participants: number[],
    createBy: number,
    imageURL: string,
    categoryId: string,
    lat: number,
    lng: number,
    address: string,
  ): Promise<ExpenseEntity> {
    const findGroup: GroupEntity = await GroupEntity.findOne(groupId);
    if (!findGroup) throw new HttpException(404, 'Group not found');
    const newParticipants: UserEntity[] = [];
    participants.forEach(async participant => {
      const findParticipant: UserEntity = await UserEntity.findOne(participant);
      if (!findParticipant) throw new HttpException(404, 'Participant number' + participant + ' not found');
      newParticipants.push(findParticipant);
    });
    const findCategory: CategoryEntity = await CategoryEntity.findOne(categoryId);
    if (!findCategory) throw new HttpException(404, 'Category not found');
    const newLocation: LocationEntity = new LocationEntity();
    if(lat && lng){
      newLocation.lat = lat;
      newLocation.lng = lng;
      newLocation.address = address;
      await newLocation.save();
    }
    const findPaidBy: UserEntity = await UserEntity.findOne(paidBy);
    if (!findPaidBy) throw new HttpException(404, 'PaidBy not found');
    const findCreateBy: UserEntity = await UserEntity.findOne(createBy);
    if (!findCreateBy) throw new HttpException(404, 'CreateBy not found');
    const newExpense: ExpenseEntity = new ExpenseEntity();
    newExpense.name = name;
    newExpense.description = description;
    newExpense.amount = amount;
    newExpense.paidBy = findPaidBy;
    newExpense.toGroup = findGroup;
    newExpense.participants = newParticipants;
    newExpense.imageURL = imageURL;
    newExpense.createdBy = findCreateBy;
    newExpense.category = findCategory;
    if(newLocation){
      newExpense.location = newLocation;
    }
    await newExpense.save();
    return newExpense;
  }

  public async getExpensesByGroup(groupId: number): Promise<ExpenseEntity[]> {
    // const findExpenses: ExpenseEntity[] = await ExpenseEntity.getRepository()
    //   .createQueryBuilder('expense_entity')
    //   .leftJoinAndSelect('expense_entity.paidBy', 'paidBy')
    //   .leftJoinAndSelect('expense_entity.participants', 'participants')
    //   .leftJoinAndSelect('expense_entity.createdBy', 'createdBy')
    //   .leftJoinAndSelect('expense_entity.location_id', 'location_id')
    //   .where('expense_entity.toGroup = :id', { id: groupId })
    //   .getMany();
    const findExpenses: ExpenseEntity[] = await ExpenseEntity.find(
      {
        relations: ['toGroup', 'paidBy', 'participants', 'category', 'createdBy', 'location'],
        where: { toGroup: groupId },
      }
    )
    return findExpenses;
  }

  public async deleteExpense(expenseId : number) : Promise<void> {
    const findExpense: ExpenseEntity = await ExpenseEntity.findOne(expenseId);
    if (!findExpense) throw new HttpException(404, 'Expense not found');
    await findExpense.remove();
  }

  public async updateExpense(
    id: number,
    name: string,
    description: string,
    amount: number,
    paidBy: number,
    groupId: number,
    participants: number[],
    createBy: number,
    imageURL: string,
  ): Promise<ExpenseEntity> {
    const findExpense: ExpenseEntity = await ExpenseEntity.findOne(id);
    if (!findExpense) throw new HttpException(404, 'Expense not found');
    findExpense.name = name;
    findExpense.description = description;
    findExpense.amount = amount;
    findExpense.paidBy = await UserEntity.findOne(paidBy);
    findExpense.toGroup = await GroupEntity.findOne(groupId);
    findExpense.participants = await UserEntity.findByIds(participants);
    findExpense.createdBy = await UserEntity.findOne(createBy);
    findExpense.imageURL = imageURL;
    await findExpense.save();
    return findExpense;
  }
}



// @Entity()
// export class Pin {
//   @PrimaryGeneratedColumn()
//   id: string;

//   @Column({ name: 'town_name' })
//   townName: string;

//   @Column()
//   state_id: string;

//   @ManyToOne(() => State, (state) => state.stateId)
//   state: State;
// }

// const pin = await pinRepository
//   .createQueryBuilder('pin')
//   .innerJoinAndSelect('pin.state', 'state')
//   .getMany();