import { Group } from "@/interfaces/group.interface";
import { IsNotEmpty } from "class-validator";
import { BaseEntity, Column, CreateDateColumn, Entity, JoinTable, ManyToMany, PrimaryGeneratedColumn, UpdateDateColumn,  } from "typeorm";
import { UserEntity } from "./users.entity";

@Entity()
export class GroupEntity extends BaseEntity implements Group{
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    @IsNotEmpty()
    name: string;

    @Column({
        nullable: true,
    })
    description?: string;

    @Column({
        nullable: true,
        
    })
    joinCode?: string;

    @Column({
        nullable: true,
    })
    joinCodeExpires?: Date;

    @Column()
    @CreateDateColumn()
    createdAt?: Date;

    @Column()
    @UpdateDateColumn()
    updatedAt?: Date;

    @ManyToMany(() => UserEntity)
    @JoinTable()
    participants: UserEntity[];
}