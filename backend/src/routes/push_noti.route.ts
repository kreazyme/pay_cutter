import { PushNotiController } from "@/controllers/push_noti.controller";
import { Routes } from "@/interfaces/routes.interface";
import { Router } from "express";

export class FirebasePushRoute implements Routes{
    public router = Router();
    public path = '/push';
    public notification = new PushNotiController();

    constructor(){
        this.initRoutes();
    }

    private initRoutes(){
        this.router.post(`${this.path}`, this.notification.pushNotibyListId);
    }
}