import { UserEntity } from "@/entities/users.entity";

export interface Group {
    id?: number;
    name: string;
    description?: string;
    createdAt?: Date;
    updatedAt?: Date;
    participants?: UserEntity[];
    joinCode?: string;
    joinCodeExpires?: Date;
}