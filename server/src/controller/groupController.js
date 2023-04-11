const User = require('../model/userModel')
const Group = require('../model/groupModel')
const authMe = require('../middleware/authMe')
const asyncHandler = require('express-async-handler')

const createGroup = asyncHandler(async (req, res) => {
    if (!req.body.users || !req.body.name) {
        return res.status(400).send({ message: "Please Fill all the feilds" });
    }

    var users = req.body.users;
    var avatarUrl = req.body.avatarUrl;

    if (users.length < 2) {
        return res
            .status(400)
            .send("More than 2 users are required to form a group chat");
    }
    try {
        users.map(async (user) => {
            User.findById(user._id).then((item) => {
                if (!item) {
                    return res.status(400).send({ message: "User not found" });
                }
                return item;
            })
        })
        console.log('____________________________________')
        console.log(users)
        const groupChat = await Group.create({
            name: req.body.name,
            users: users,
            avatarUrl: avatarUrl,
        });
        console.log(users)
        const fullGroupChat = await Group.findOne({ _id: groupChat._id })
            .populate("users", "-password")
        res.status(200).json(fullGroupChat);
    } catch (error) {
        res.status(400);
        console.log("Error in creating group chat");
    }
});

const getMyGroups = asyncHandler(async (req, res) => {
    var userId = await authMe(req)
    console.log(userId)
    var groups = await Group.find({ users: userId })
        .populate("users", "-password")
        .populate("lastestMessage")
    res.status(200).json(groups);
});
module.exports = {
    createGroup,
    getMyGroups,
}