const mongoose = require('mongoose')
const chatSchema = new mongoose.Schema({
    sender: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "User"
    },
    receiver: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "Group"
    },
    message: {
        type: String,
        required: true,
    },
}, {
    timestamps: true
})

module.exports = mongoose.model("Chat", chatSchema)