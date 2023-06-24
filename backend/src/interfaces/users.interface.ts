import { GroupEntity } from '@/entities/group.entity';
import { Group } from './group.interface';

export interface User {
  id?: number;
  email: string;
  name: string;
  photoUrl?: string;
  groups?: GroupEntity[];
  googleToken?: string;
  fcmToken?: string;
}
