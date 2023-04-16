import { GroupEntity } from "@/entities/group.entity";
import { GroupService } from "@/services/group.service";
import { NextFunction, Request, Response } from "express";
import Container from "typedi";

export class GroupController{
    public group = Container.get(GroupService)

    public getMyGroups = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
        try{
            const userID = Number(req.params.id);
            const findMyGroups: GroupEntity[] = await this.group.findMyGroups(userID);
            res.status(200).json({data: findMyGroups, message: "findAll"});
        }catch(error){
            next(error);
        }
    }

    public getGroupById = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
        try{
            const groupID = Number(req.params.id);
            const userID = Number(req.params.id);
            const findGroupById: GroupEntity = await this.group.findGroupById(groupID, userID,);
            res.status(200).json({data: findGroupById, message: "findOne"});
        }catch(error){
            next(error);
        }
    }

    public createGroup = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
        try{
            const groupName = req.body.name;
            const userID = Number(req.params.id);
            const description = req.body.description;
            const newGroup: GroupEntity = await this.group.createGroup(groupName, userID, description);
            res.status(201).json({data: newGroup, message: "created"});
        }catch(error){
            next(error);
        }
    }

    public leaveGroup = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
        try{
            const groupID = Number(req.params.id);
            const userID = Number(req.params.id);
            const findGroup: GroupEntity = await this.group.leaveGroup(groupID, userID);
            res.status(200).json({data: findGroup, message: "left"});
        }catch(error){
            next(error);
        }
    }

    public joinGroup = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
        try{
            const code = req.body.code;
            const userID = Number(req.params.id);
            const findGroup: GroupEntity = await this.group.joinGroup(code, userID);
            res.status(200).json({data: findGroup, message: "joined"});
        }catch(error){
            next(error);
        }
    }

    public shareGroup = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
        try{
            const groupID = Number(req.params.id);
            const userID = Number(req.params.id);
            const findGroup: GroupEntity = await this.group.findGroupById(groupID, userID);
            res.status(200).json({data: findGroup, message: "shared"});
        }catch(error){
            next(error);
        }
    }
}