import { App } from '@/app';
import { AuthRoute } from '@routes/auth.route';
import { UserRoute } from '@routes/users.route';
import { ValidateEnv } from '@utils/validateEnv';
import { GroupRoute } from './routes/group.route';
import { ExpenseRoute } from '@routes/expense.route';
import { DB_PASSWORD } from './config';

// ValidateEnv();

// const app = new App([new AuthRoute(), new UserRoute(), new GroupRoute(), new ExpenseRoute()]);

// console.log('start app _____________');
// console.log(DB_PASSWORD);

// app.listen();
const express = require('express')
const app = express()

app.get('/', (req, res) => {
    res.send('hello world')
})

console.log('start app _____________');

app.listen(3003)
