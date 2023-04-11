const User = require('../model/userModel')
const Group = require('../model/groupModel')
const Chat = require('../model/chatModel')
const authMe = require('../middleware/authMe')
const asyncHandler = require('express-async-handler')

const getMessage = asyncHandler(async (req, res) => {
    try {
        var group_id = req.body.group_id;
        if (group_id == null) {
            return res.status(400).send({ message: "group_id is required!" });
        }
        var userId = await authMe(req)
        var group = await Group.findById(group_id)
        if (!group) {
            return res.status(400).send({ message: "Group not found" });
        }
        var isMember = group.users.indexOf(userId) > -1;
        if (!isMember) {
            return res.status(400).send({ message: "You are not a member of this group" });
        }
        console.log(group_id)
        var chats = await Chat.find({ receiver: group_id }, { __v: 0 })
            .sort({ createdAt: 1 })
            .populate("sender", "-password -email -createdAt -updatedAt -__v");
        res.status(200).json(chats);
    }
    catch (e) {
        res.status(400).send({ message: "Error in getting messages" });
    }
});

const createNewChat = asyncHandler(async (req, res) => {
    try {
        if (!req.body.group_id || !req.body.message) {
            return res.status(400).send({ message: "group_id and message are required!" });
        }
        var group_id = req.body.group_id;
        var message = req.body.message;
        var userId = await authMe(req)
        var newChat = {
            sender: userId,
            message: message,
            receiver: group_id,
        };
        var chat = await Chat.create(newChat);
        var group = await Group.findByIdAndUpdate(group_id, { lastestMessage: chat._id });
        res.status(200).json(group);
    }
    catch (e) {
        res.status(400).send({ message: "Error in creating new chat" });
    }
})

module.exports = {
    getMessage,
    createNewChat,
}