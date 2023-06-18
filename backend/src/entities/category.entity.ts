import { BaseEntity, Column, CreateDateColumn, Entity, JoinColumn, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { ExpenseEntity } from "./expense.entity";
import { GroupEntity } from "./group.entity";

export const CATEGORY_TABLE = 'category_entity';
@Entity({
    name: CATEGORY_TABLE
})
export class CategoryEntity extends BaseEntity {
    @PrimaryGeneratedColumn({
        name: 'category_id'
    })
    id: number;

    @Column({
        name:'name'
    })
    name: string;

    @Column({
        name:'description'
    })
    description: string;

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
    @OneToMany(() => GroupEntity, expense => expense.id)
    @JoinColumn({
        name: 'group_id', referencedColumnName: 'id'
    })
    expense: GroupEntity;

    @Column({
        name:'expense_id',
    })
    expense_id: number;

    @OneToMany(() => ExpenseEntity, expense => expense.id)
    @JoinColumn({
        name: 'expense_id', referencedColumnName: 'id'
    })
    expenses: ExpenseEntity[];
}