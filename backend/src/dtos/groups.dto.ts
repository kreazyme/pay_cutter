import { IsEmpty, IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreateGroupDTO {
  @IsString()
  @IsNotEmpty()
  public name: string;

  @IsString()
  @IsNotEmpty()
  public userID: number;
}

export class ShareGroupDTO {
  @IsNumber()
  @IsNotEmpty()
  public id: number;
}

export class JoinGroupDTO {
  @IsString()
  @IsNotEmpty()
  public joinCode: string;
}

export class LeaveGroupDTO {
  @IsNumber()
  @IsNotEmpty()
  public id: number;
}
