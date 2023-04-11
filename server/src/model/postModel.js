const mongoose = require('mongoose')

const postSchema = new mongoose.Schema({
    content: {
        type: String,
        required: true,
    },
    user: {
        user_id: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User',
            required: true,
        },
        username: {
            type: String,
            required: true,
        },
        name: {
            type: String,
            required: true,
        },
    },
    comments: [{
        user: {
            user_id: {
                type: mongoose.Schema.Types.ObjectId,
                ref: 'User',
                required: true,
            },
            username: {
                type: String,
                required: true,
            },
            name: {
                type: String,
                required: true,
            },
        },
        content: {
            type: String,
            required: true,
        },
        createdAt: {
            type: Date,
            required: true,
            default: Date.now,
        }
    }],
}, {
    timestamps: true
})

module.exports = mongoose.model("Post", postSchema)