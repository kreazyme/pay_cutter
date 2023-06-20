import { CategoryController } from "@/controllers/category.controller";
import { Routes } from "@/interfaces/routes.interface";
import { AuthMiddleware } from "@/middlewares/auth.middleware";
import { Router } from "express";

export class CategoryRoute implements Routes{
    public router = Router();
    public path = '/categories';
    public category = new CategoryController();

    constructor(){
        this.initRoutes();
    }

    private initRoutes(){
        this.router.get(
            `${this.path}/:id(\\d+)`, 
            AuthMiddleware,
            this.category.getCategoryByGroupId
        );
    this.router.post(
        `${this.path}/:id(\\d+)`,
        AuthMiddleware,
        this.category.createCategory
    )
    }

}