const mongoose = require('mongoose')
const expenseSchema = new mongoose.Schema({
    paidBy: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "User"
    },
    toGroup: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "Group"
    },
    receiver: [{
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "User"
    }],
    amount: {
        type: Number,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
}, {
    timestamps: true
})

module.exports = mongoose.model("Expense", expenseSchema)