import { GroupController } from "@/controllers/group.controller";
import { Routes } from "@/interfaces/routes.interface";
import { Router } from "express";
import {AuthMiddleware} from "@/middlewares/auth.middleware";

export class GroupRoute implements Routes{
    public path = '/groups';
    public router = Router();
    public group = new GroupController();
    
    constructor(){
        this.initRoutes();
    }

    private initRoutes(){
        this.router.get(`${this.path}`, AuthMiddleware, this.group.getMyGroups);
        this.router.get(`${this.path}/:id(\\d+)`, AuthMiddleware, this.group.getGroupById);
    }
}