import { join } from 'path';
import { ConnectionOptions } from 'typeorm';
import { DB_USER, DB_PASSWORD, DB_HOST, DB_PORT, DB_DATABASE } from '@config';
import * as PostgressConnectionStringParser from "pg-connection-string";

const connectionOptions = PostgressConnectionStringParser.parse("postgres://pay_cutter:dHzGvGRlGdwTej3@pay-cutter-db.flycast:5432/pay_cutter?sslmode=disable");

export const dbConnection: ConnectionOptions = {
  type: 'postgres',
  username: connectionOptions.user,
  password: connectionOptions.password,
  host: "149.248.207.40",
  port: Number(connectionOptions.port),
  database: connectionOptions.database,
  synchronize: true,
  logging: false,
  entities: [join(__dirname, '../**/*.entity{.ts,.js}')],
  migrations: [join(__dirname, '../**/*.migration{.ts,.js}')],
  subscribers: [join(__dirname, '../**/*.subscriber{.ts,.js}')],
  cli: {
    entitiesDir: 'src/entities',
    migrationsDir: 'src/migration',
    subscribersDir: 'src/subscriber',
  },
};

