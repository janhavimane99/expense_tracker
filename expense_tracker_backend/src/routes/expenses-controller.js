const expensesRoute = require("express").Router();
const Expenses = require("../modal/expenses-pojo");
const User = require("../modal/user-pojo");
const verify = require("../routes/verifyToken");

//adding expenses for perticular user
expensesRoute.post("/addExpenses/:userId", verify, async (req, res) => {
    const dataList = []; // Initialize dataList

    // Getting userId from request
    const userId = req.params.userId;

    // Getting body from request
    const bd = req.body.dataToAdd;

    try {
        // Check if the body is an array
        if (!Array.isArray(bd) || bd.length === 0) {
            return res.status(400).json({ message: "Invalid input data. Expected an array of expenses." });
        }

        for (const element of bd) {
            // Validate each element before processing
            if (!element.title || typeof element.amount !== 'number' || !element.date) {
                return res.status(400).json({ message: "Invalid expense data provided." });
            }

            if (element.amount <= 0) {
                return res.status(400).json({ message: "Amount must be a positive number." });
            }

            const expenseDate = new Date(element.date);
            if (isNaN(expenseDate.getTime())) {
                return res.status(400).json({ message: "Invalid date format provided." });
            }

            const expense = new Expenses({
                userId: userId,
                title: element.title,
                amount: element.amount,
                date: expenseDate,
            });

            // Save the expense and push to dataList
            try {
                const saveListing = await expense.save();
                dataList.push(saveListing);
            } catch (saveError) {
                console.error("Error saving expense:", saveError);
                // Optionally, continue saving other expenses or return an error
            }
        }

        // Send response with both lists
        res.status(200).json({ data: dataList, message: "All expenses added successfully!" });

    } catch (error) {
        console.error("Error adding expenses:", error); // Log error for debugging
        res.status(500).json({ message: "Server error. Unable to add expenses.", error: error.message });
    }
});



//get all expense list for the user
expensesRoute.post("/expenseList/:userId", verify, async (req, res) => {

    // Getting userId from request
    const userId = req.params.userId;

    // Getting body from request
    const bd = req.body;

    console.log(bd);

    try {
        let expenseList = [];

        // Check if request body exists and has values
        if (bd && Object.keys(bd).length > 0) {
            console.log('Body received:', bd);
            const { toDate, fromDate } = bd;

            // Validate that fromDate is not later than toDate
            if (new Date(fromDate) > new Date(toDate)) {
                return res.status(400).json({ message: "'fromDate' cannot be later than 'toDate'." });
            }

            // Querying expenses by date range for the user
            expenseList = await Expenses.find({
                userId: userId,
                date: {
                    $gte: new Date(fromDate),  // fromDate should be the earlier date
                    $lte: new Date(toDate)     // toDate should be the later date
                }
            });
        } else {
            console.log('No body received or body is empty');
            // If no body, fetch all expenses for the user
            expenseList = await Expenses.find({ userId: userId });
        }

        // Check if any expenses were found
        if (expenseList.length > 0) {
            console.log("Expenses found");
            return res.status(200).json({
                message: 'data found',
                data: expenseList
            });
        } else {
            console.log("No expenses found for this user.");
            return res.status(200).json({
                message: 'data not found',
                data: []
            });
        }

    } catch (error) {
        console.error("Error fetching expenses:", error);
        return res.status(500).json({
            message: "Server error. Unable to fetch expenses.",
            error: error.message
        });
    }
});

//delete the expense with expenseId
expensesRoute.delete("/deleteExpense/:expenseId", verify, async (req, res) => {

    // Access the expenseId from the route parameters
    const expenseId = req.params.expenseId;

    console.log("Expense ID for removal:", expenseId);

    try {
        // Check if expenseId is provided
        if (!expenseId) {
            return res.status(400).json({ message: "Expense ID is required" });
        }

        // Attempt to find and delete the expense
        const expense = await Expenses.findById(expenseId);

        const title = expense?.title;

        // Attempt to find and delete the expense
        const deletedExpense = await Expenses.findByIdAndDelete(expenseId);

        // Check if the expense was found and deleted
        if (!deletedExpense) {
            return res.status(404).json({ message: `Expense with title ${title} not found` });
        }

        // Send a success response
        res.status(200).json({
            message: `Expense with title ${title} was successfully deleted!`,
            data: deletedExpense
        });

    } catch (error) {
        console.error("Error deleting expense:", error);
        return res.status(500).json({
            message: "Server error. Unable to delete expense.",
            error: error.message
        });
    }
});




module.exports = expensesRoute;