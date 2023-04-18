import { GroupController } from "@/controllers/group.controller";
import { Routes } from "@/interfaces/routes.interface";
import { Router } from "express";
import { AuthMiddleware } from "@/middlewares/auth.middleware";
import { ValidationMiddleware } from "@/middlewares/validation.middleware";
import { CreateGroupDTO, JoinGroupDTO, LeaveGroupDTO, ShareGroupDTO } from "@/dtos/groups.dto";

export class GroupRoute implements Routes {
    public path = '/groups';
    public router = Router();
    public group = new GroupController();

    constructor() {
        this.initRoutes();
    }

    private initRoutes() {
        this.router.get(`${this.path}`, AuthMiddleware, this.group.getMyGroups);
        this.router.get(`${this.path}/:id(\\d+)`, AuthMiddleware, this.group.getGroupById);
        this.router.post(
            `${this.path}`,
            ValidationMiddleware(CreateGroupDTO),
            AuthMiddleware,
            this.group.createGroup,
        );
        this.router.delete(
            `${this.path}/join`,
            ValidationMiddleware(LeaveGroupDTO),
            AuthMiddleware, 
            this.group.leaveGroup,
            );
        this.router.put(
            `${this.path}/join`,
            ValidationMiddleware(JoinGroupDTO),
            AuthMiddleware,
            this.group.joinGroup,
        );
        this.router.post(
            `${this.path}/join`,
            ValidationMiddleware(ShareGroupDTO),
            AuthMiddleware,
            this.group.shareGroup,
        );
    }
}