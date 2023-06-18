import { BaseEntity, Column, Entity, JoinColumn, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { ExpenseEntity } from "./expense.entity";

export const LOCATION_TABLE = 'location_entity';
@Entity({
    name: LOCATION_TABLE
})
export class LocationEntity extends BaseEntity{
    @PrimaryGeneratedColumn({
        name:'id'
    })
    id: number;

    @Column({
        name:'lat'
    })
    lat: number;

    @Column({
        name:'lng'
    })
    lng: number;

}
