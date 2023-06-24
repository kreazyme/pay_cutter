import { PushNotiService } from "@/services/push_noti.service";
import { NextFunction, Request, Response } from "express";
import Container from "typedi";

export class PushNotiController {
    public pushNoti = Container.get(PushNotiService);

    public pushNotibyListId = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
        try{
            const ids = req.body.ids;
            const isAnonymous = req.body.is_anonymous;
            const sender = req.body.sender;
            const groupName = req.body.group_name;

            await this.pushNoti.pushNotibyListId(
                ids,
                isAnonymous,
                sender,
                groupName,
            );
            res.status(200).json({message: 'push noti success'});
        }
        catch(err){
            next(err);
        }
    }   
}