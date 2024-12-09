const mongoose = require("mongoose");

const expensesSchema = new mongoose.Schema({
    userId: String,
    title: String,
    amount: Number,
    date: Date
});

module.exports = mongoose.model("Expenses", expensesSchema);