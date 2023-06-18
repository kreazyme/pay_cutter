import { CategoryEntity } from "@/entities/category.entity";
import { RequestWithUser } from "@/interfaces/auth.interface";
import { CategoryService } from "@/services/category.service";
import { NextFunction, Response } from "express";
import Container from "typedi";

export class CategoryController{
    public category = Container.get(CategoryService)

    public getCategoryByGroupId = async(
        req: RequestWithUser,
        res: Response,
        next: NextFunction
    ) :Promise<void> => {
        try{
            const groupID = Number(req.params.id);
            const findCategoryById: CategoryEntity[] = await this.category.findCategoryByGroupId(groupID);
        res.status(200).json({
            data: findCategoryById,
            message: 'findAll'
        })
        }
        catch(e){
            next(e)
        }
    }

    public createCategory = async(
        req: RequestWithUser,
        res: Response,
        next: NextFunction
    ) :Promise<void> => {
        try{
            const name = req.body.name;
            const description  = req.body.description;
            const groupID = Number(req.body.group_id);
            const createCategoryData = await this.category.createCategory(
                name,
                groupID,
                description,
            );
            res.status(200).json({
                data: createCategoryData,
                message: 'created'
            })
        }
        catch(e){
            next(e)
        }
    }
}