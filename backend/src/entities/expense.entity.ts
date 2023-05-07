import { Expense } from '@/interfaces/expense.interface';
import { IsNotEmpty, IsNumber } from 'class-validator';
import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
  OneToMany,
  OneToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { UserEntity } from './users.entity';
import { GroupEntity } from './group.entity';

@Entity({
  name: 'expense_entity',
})
export class ExpenseEntity extends BaseEntity implements Expense {
  @PrimaryGeneratedColumn()
  id?: number;

  @Column()
  @IsNotEmpty()
  name: string;

  @Column({
    nullable: true,
  })
  description?: string;

  @IsNumber()
  @IsNotEmpty()
  @Column()
  amount: number;

  @Column()
  @CreateDateColumn()
  createdAt?: Date;

  @Column()
  @UpdateDateColumn()
  updatedAt?: Date;

  @IsNotEmpty()
  @ManyToOne(() => UserEntity, user => user.id)
  createdBy: UserEntity;

  @IsNotEmpty()
  @ManyToOne(() => UserEntity, user => user.id)
  @JoinColumn({
    name: 'paidBy',
    referencedColumnName: 'id',
  })
  paidBy: UserEntity;

  @IsNotEmpty()
  @ManyToOne(() => GroupEntity, group => group.id)
  @JoinColumn({
    name: 'toGroup',
    referencedColumnName: 'id',
  })
  toGroup: GroupEntity;

  @ManyToMany(() => UserEntity, user => user.id)
  @IsNotEmpty()
  @JoinTable({
    name: 'expense_participants',
    joinColumn: {
      name: 'expense_id',
      referencedColumnName: 'id',
    },
  })
  participants: UserEntity[];

  @Column({
    nullable: true,
  })
  @Column()
  imageURL?: string;
}
