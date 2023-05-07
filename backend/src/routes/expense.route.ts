import { Router } from 'express';
import { Routes } from '@interfaces/routes.interface';
import { AuthMiddleware } from '@middlewares/auth.middleware';
import { ValidationMiddleware } from '@middlewares/validation.middleware';
import { ExpenseController } from '@/controllers/expense.controller';
import { ExpenseDTO, FindExpenseDTO } from '@/dtos/expense.dto';

export class ExpenseRoute implements Routes {
  public router = Router();
  public path = '/expenses';
  public expense = new ExpenseController();

  constructor() {
    this.initRoutes();
  }

  private initRoutes() {
    this.router.post(`${this.path}`, AuthMiddleware, ValidationMiddleware(ExpenseDTO), this.expense.createExpense);

    this.router.get(`${this.path}/:id(\\d+)`, AuthMiddleware, this.expense.findExpense);

    this.router.get(`${this.path}/group/:id(\\d+)`, AuthMiddleware, this.expense.getExpensesByGroup);

    this.router.put(`${this.path}/:id(\\d+)`, AuthMiddleware, ValidationMiddleware(ExpenseDTO), this.expense.updateExpense);
  }
}
