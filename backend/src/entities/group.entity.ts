import { Group } from "@/interfaces/group.interface";
import { IsNotEmpty } from "class-validator";
import { BaseEntity, Column, CreateDateColumn, Entity, PrimaryGeneratedColumn, UpdateDateColumn,  } from "typeorm";

@Entity()
export class GroupEntity extends BaseEntity implements Group{
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    @IsNotEmpty()
    name: string;

    @Column()
    description: string;

    @Column()
    createdAt?: Date;

    @Column()
    @IsNotEmpty()
    @CreateDateColumn()
    updatedAt?: Date;

    @Column()
    @UpdateDateColumn()
    participants?: number;
}