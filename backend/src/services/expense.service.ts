import { ExpenseEntity } from '@/entities/expense.entity';
import { GroupEntity } from '@/entities/group.entity';
import { UserEntity } from '@/entities/users.entity';
import { HttpException } from '@exceptions/HttpException';
import { Service } from 'typedi';
import { EntityRepository, Repository } from 'typeorm';

@Service()
@EntityRepository()
export class ExpenseService extends Repository<ExpenseEntity> {
  public async findExpense(id: number): Promise<ExpenseEntity> {
    // const findExpense: ExpenseEntity = await ExpenseEntity.findOne({ where: { id: id } });
    const findExpense: ExpenseEntity = await ExpenseEntity.getRepository()
      .createQueryBuilder('expense_entity')
      .leftJoinAndSelect('expense_entity.toGroup', 'toGroup')
      .leftJoinAndSelect('expense_entity.paidBy', 'paidBy')
      .leftJoinAndSelect('expense_entity.participants', 'participants')
      .leftJoinAndSelect('expense_entity.createdBy', 'createdBy')
      .where('expense_entity.id = :id', { id: id })
      // .select([
      //     "expense_entity.id",
      //     "expense_entity.name",
      //     "expense_entity.description",
      //     "expense_entity.amount",
      //     "expense_entity.createdAt",
      //     "expense_entity.updatedAt",
      //     "expense_entity.imageURL",
      //     "toGroup.id",
      //     "toGroup.name",
      //     // "paidBy.id",
      //     // "paidBy.name",
      //     // "paidBy.imageURL",
      //     "participants.id",
      //     "participants.email",
      //     // "participants.imageURL",
      //     // "createdBy.id",
      //     // "createdBy.name",
      //     // "createdBy.imageURL",
      // ])
      .getOne();
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
  ): Promise<ExpenseEntity> {
    const findGroup: GroupEntity = await GroupEntity.findOne(groupId);
    if (!findGroup) throw new HttpException(404, 'Group not found');
    const newParticipants: UserEntity[] = [];
    participants.forEach(async participant => {
      const findParticipant: UserEntity = await UserEntity.findOne(participant);
      if (!findParticipant) throw new HttpException(404, 'Participant number' + participant + ' not found');
      newParticipants.push(findParticipant);
    });
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
    await newExpense.save();
    return newExpense;
  }

  public async getExpensesByGroup(groupId: number): Promise<ExpenseEntity[]> {
    const findExpenses: ExpenseEntity[] = await ExpenseEntity.getRepository()
      .createQueryBuilder('expense_entity')
      .leftJoinAndSelect('expense_entity.paidBy', 'paidBy')
      .leftJoinAndSelect('expense_entity.participants', 'participants')
      .leftJoinAndSelect('expense_entity.createdBy', 'createdBy')
      .where('expense_entity.toGroup = :id', { id: 11 })
      .getMany();
    return findExpenses;
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
