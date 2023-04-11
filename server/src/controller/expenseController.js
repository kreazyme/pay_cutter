const User = require('../model/userModel')
const Group = require('../model/groupModel')
const Chat = require('../model/chatModel')
const Expense = require('../model/expenseModel')
const authMe = require('../middleware/authMe')
const asyncHandler = require('express-async-handler')

const createExpense = asyncHandler(async (req, res) => {
    try {
        if (!req.body.paid_by || !req.body.to_group || !req.body.amount || !req.body.description || !req.body.receiver) {
            return res.status(400).send({ message: "to_group, amount, description, receiver and message are required!" });
        }
        var to_group = req.body.to_group;
        var amount = req.body.amount;
        var description = req.body.description;
        var receiver = req.body.receiver;
        var paid_by = req.body.paid_by;
        var userId = await authMe(req)
        var group = Group.findById(to_group);
        if (!group) {
            return res.status(400).send({ message: "Group not found!" });
        }
        var isInGroup = group.members.includes(userId);
        if (!isInGroup) {
            return res.status(400).send({ message: "You are not in this group!" });
        }
        var newExpense = {
            paid_by: paid_by,
            toGroup: to_group,
            receiver: receiver,
            amount: amount,
            description: description,
        };
        var expense = await Chat.create(newExpense);
        // var group = await Group.findByIdAndUpdate(group_id, { lastestMessage: chat._id });
        res.status(200).json(expense);
    }
    catch (e) {
        res.status(400).send({ message: "Error in creating new chat" });
    }
})

module.exports = {
    getMessage,
    createNewChat,
}