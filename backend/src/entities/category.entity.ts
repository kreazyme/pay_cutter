import { BaseEntity, Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { ExpenseEntity } from "./expense.entity";
import { GroupEntity } from "./group.entity";
import { isEmpty } from "class-validator";

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
        name: 'name'
    })
    name: string;

    @Column({
        name: 'description'
    })
    description: string;

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
    @ManyToOne(() => GroupEntity, group => group.id)
    @JoinColumn({
        name: 'group_id', referencedColumnName: 'id'
    })
    group: GroupEntity;

    @Column({
        name: 'expense_id',
        nullable: true,
    })
    expense_id?: number;

    @OneToMany(() => ExpenseEntity, expense => expense.id)
    @JoinColumn({
        name: 'expense_id', referencedColumnName: 'id'
    })
    expenses?: ExpenseEntity[];
}