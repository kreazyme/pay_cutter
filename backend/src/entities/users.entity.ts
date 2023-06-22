import { IsEmpty, IsNotEmpty } from 'class-validator';
import { BaseEntity, Entity, PrimaryGeneratedColumn, Column, Unique, CreateDateColumn, UpdateDateColumn, ManyToMany } from 'typeorm';
import { User } from '@interfaces/users.interface';
import { GroupEntity } from './group.entity';

@Entity({
  name: 'user_entity',
})
export class UserEntity extends BaseEntity implements User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  @IsNotEmpty()
  @Unique(['email'])
  email: string;

  @Column({
    name:'fcm_token',
    nullable:true,
  })
  fcmToken?: string;

  @Column()
  @IsNotEmpty()
  name: string;

  @Column()
  @IsEmpty()
  photoUrl?: string;

  @Column()
  @CreateDateColumn()
  createdAt: Date;

  @Column()
  @UpdateDateColumn()
  updatedAt: Date;

}
