const mongoose = require('mongoose')
const groupSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    users: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User"
        }
    ],
    lastestMessage: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Message"
    },
    avatarUrl: {
        type: String,
        default: "https://res.cloudinary.com/d"
    },

}, {
    timestamps: true
})

module.exports = mongoose.model("Group", groupSchema)