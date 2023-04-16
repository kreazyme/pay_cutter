import { Group } from "@/interfaces/group.interface";
import { IsNotEmpty } from "class-validator";
import { BaseEntity, Column, CreateDateColumn, Entity, ManyToMany, PrimaryGeneratedColumn, UpdateDateColumn,  } from "typeorm";
import { UserEntity } from "./users.entity";

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
    joinCode?: string;

    @Column()
    joinCodeExpires?: Date;

    @Column()
    @CreateDateColumn()
    createdAt?: Date;

    @Column()
    updatedAt?: Date;

    @Column()
    @ManyToMany(() => UserEntity, (user) => user.groups)
    participants: UserEntity[];
}