import { GroupEntity } from "@/entities/group.entity";
import { Group } from "./group.interface";

export interface User {
  id?: number;
  email: string;
  password: string;
  groups?: GroupEntity[];
}
