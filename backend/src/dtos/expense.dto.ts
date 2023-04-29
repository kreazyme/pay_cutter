import { IsArray, IsNotEmpty, IsNumber, IsString } from "class-validator";
import { Column } from "typeorm";

export class ExpenseDTO {

    @IsString()
    @IsNotEmpty()
    public name: string;

    @IsString()
    public description: string;

    @IsNumber()
    @IsNotEmpty()
    public amount: number;

    @IsNumber()
    @IsNotEmpty()
    public paidBy: number;

    @IsNumber()
    @IsNotEmpty()
    public groupId: number;

    @IsArray()
    @IsNotEmpty()
    public participants: number[];

    @IsString()
    @Column({
        nullable:true
    })
    public imageURL: string;

}

export class FindExpenseDTO {
    @IsNumber()
    @IsNotEmpty()
    public id: number;
}