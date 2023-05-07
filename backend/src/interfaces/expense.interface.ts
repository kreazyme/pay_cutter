import { GroupEntity } from '@/entities/group.entity';
import { UserEntity } from '@/entities/users.entity';

export interface Expense {
  id?: number;
  name: string;
  description?: string;
  amount: number;
  createdAt?: Date;
  updatedAt?: Date;
  paidBy: UserEntity;
  toGroup: GroupEntity;
  participants: UserEntity[];
  createdBy: UserEntity;
  imageURL?: string;
}
