import { GroupEntity } from '@/entities/group.entity';
import { RequestWithUser } from '@/interfaces/auth.interface';
import { User } from '@/interfaces/users.interface';
import { GroupService } from '@/services/group.service';
import { NextFunction, Request, Response } from 'express';
import Container from 'typedi';

export class GroupController {
  public group = Container.get(GroupService);

  public getMyGroups = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userID = req.user.id;
      const findMyGroups: GroupEntity[] = await this.group.findMyGroups(userID);
      res.status(200).json({ data: findMyGroups, message: 'findAll' });
    } catch (error) {
      next(error);
    }
  };

  public getGroupById = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      const groupID = Number(req.params.id);
      const userID = req.user.id;
      const findGroupById: GroupEntity = await this.group.findGroupById(groupID, userID);
      res.status(200).json({ data: findGroupById, message: 'findOne' });
    } catch (error) {
      next(error);
    }
  };

  public createGroup = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      const name = req.body.name;
      const description = req.body.description;
      const user: User = req.user;
      const newGroup: GroupEntity = await this.group.createGroup(name, user, description);
      res.status(201).json({ data: newGroup, message: 'created' });
    } catch (error) {
      next(error);
    }
  };

  public leaveGroup = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      const groupID = Number(req.body.id);
      const userID = req.user.id;
      const findGroup: GroupEntity = await this.group.leaveGroup(groupID, userID);
      res.status(200).json({ data: findGroup, message: 'left' });
    } catch (error) {
      next(error);
    }
  };

  public joinGroup = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      const code = req.body.joinCode;
      const userID = req.user.id;
      const findGroup: GroupEntity = await this.group.joinGroup(code, userID);
      res.status(200).json({ data: findGroup, message: 'joined' });
    } catch (error) {
      next(error);
    }
  };

  public shareGroup = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      const groupID = Number(req.params.id);
      const userID = req.user.id;
      const joinCode: string = await this.group.shareGroup(groupID, userID);
      res.status(200).json({ data: joinCode, message: 'shared' });
    } catch (error) {
      next(error);
    }
  };
}
