import { App } from '@/app';
import { AuthRoute } from '@routes/auth.route';
import { UserRoute } from '@routes/users.route';
import { ValidateEnv } from '@utils/validateEnv';
import { GroupRoute } from './routes/group.route';

ValidateEnv();

const app = new App([
    new AuthRoute(), 
    new UserRoute(),
    new GroupRoute(),
]);

app.listen();
