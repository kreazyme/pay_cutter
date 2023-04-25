import { NextFunction, Request, Response } from 'express';
import { Container } from 'typedi';
import { RequestWithUser } from '@interfaces/auth.interface';
import { ExpenseService } from '@/services/expense.service';
import { ExpenseEntity } from '@/entities/expense.entity';


export class ExpenseController {
    public expense = Container.get(ExpenseService)

    public createExpense = async (
        req: RequestWithUser,
        res: Response,
        next: NextFunction,
    ): Promise<void> => {
        try {
            const userID :number = req.user.id;
            const findExpense: ExpenseEntity = await this.expense.createExpense(
                req.body.name,
                req.body.description,
                req.body.amount,
                req.body.paidBy,
                req.body.groupId,
                req.body.participants,
                userID,
                req.body.imageURL,
            );
            res.status(201).json({ data: findExpense, message: "created" });
        }
        catch (error) {
            next(error);
        }
    }

    public findExpense = async (
        req: RequestWithUser,
        res: Response,
        next: NextFunction,
    ): Promise<void> => {
        try {
            const expenseID: number = Number(req.params.id);
            const findExpense: ExpenseEntity = await this.expense.findExpense(expenseID);
            res.status(200).json({ data: findExpense, message: "ok" });
        }
        catch (error) {
            next(error);
        }
    }

    public getExpensesByGroup = async (
        req: RequestWithUser,
        res: Response,
        next: NextFunction,
    ): Promise<void> => {
        try {
            const groupID: number = Number(req.params.id);
            const findExpenses: ExpenseEntity[] = await this.expense.getExpensesByGroup(groupID);
            res.status(200).json({ data: findExpenses, message: "ok" });
        }
        catch (error) {
            next(error);
        }
    }

    public updateExpense = async (
        req: RequestWithUser,
        res: Response,
        next: NextFunction,
    ): Promise<void> => {
        try {
            console.log('updateExpense')
            const expenseID: number = Number(req.params.id);
            const findExpense: ExpenseEntity = await this.expense.updateExpense(
                expenseID,
                req.body.name,
                req.body.description,
                req.body.amount,
                req.body.paidBy,
                req.body.groupId,
                req.body.participants,
                req.body.createdBy,
                req.body.imageURL,
            );
            res.status(200).json({ data: findExpense, message: "updated" });
        }
        catch (error) {
            next(error);
        }
    }
}