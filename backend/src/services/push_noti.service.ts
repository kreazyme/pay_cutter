import { CategoryEntity } from "@/entities/category.entity";
import { UserEntity } from "@/entities/users.entity";
import { Service } from "typedi";
import { EntityRepository, Repository } from "typeorm";
import * as admin from 'firebase-admin';
import { HttpException } from "@/exceptions/HttpException";

@Service()
@EntityRepository()
export class PushNotiService extends Repository<UserEntity>{
    public async pushNotibyListId(
        ids: number[],
        isAnonymous: boolean,
        sender: string,
        groupName: string,
    ): Promise<void> {
        try {
            if (ids == null) {
                throw new HttpException(400, 'List id is null');
            };
            // find list token by list user id
            const listUser: UserEntity[] = await UserEntity.findByIds(ids);
            var listToken: string[] = listUser.map((user: UserEntity) => user.fcmToken);
            // remove null token
            listToken = listToken.filter((token: string) => token != null);
            console.log(listToken);
            var message: admin.messaging.MulticastMessage;
            if (!isAnonymous) {
                message = {
                    notification: {
                        title: `Remind to pay for ${sender}`,
                        body: `Maybe you forgot to pay for ${sender} in ${groupName}!. Check your debit list now!`,
                    },
                    tokens: listToken,
                }
            }
            else {
                message = {
                    notification: {
                        title: 'Someone want you to pay for him',
                        body: 'Please check your list',
                    },
                    tokens: listToken,
                };
            }
            const response = await admin.messaging().sendMulticast(message);
            console.log(response.successCount + ' messages were sent successfully');
        }
        catch (err) {
            console.log(err);
        }
    };

    public async pushNotiWithMessage(
        tokens: string[],
        body: string,
        title: string,
    ): Promise<void> {
        try {
            console.log(tokens);
            const message = {
                notification: {
                    title: title,
                    body: body,
                },
                tokens: tokens,
            };
            const response = await admin.messaging().sendMulticast(message);
            console.log(response.successCount + ' messages were sent successfully');
        }
        catch (err) {
            console.log(err);
        }

    }
}