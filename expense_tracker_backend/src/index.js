const express = require("express");
const app = express();
const dotenv = require("dotenv");
const mongoose = require("mongoose");
const cors = require("cors");
const userRoute = require("./routes/user-controller");
const expensesRoute = require("./routes/expenses-controller");

dotenv.config();

//db connecting
mongoose
  .connect(process.env.DB_CONNECT)
  .then(() => {
    console.log("MongoDB connected successfully");
  })
  .catch((err) => {
    console.error("MongoDB connection error:", err);
  });

//middlewares
// Parse JSON request bodies middleware
app.use(cors());
app.use(express.json());

//routes middleware
app.use("/api/user", userRoute);
app.use("/api/expenses", expensesRoute);

app.listen(process.env.PORT, () => {
  console.log(`app started listning at port ${process.env.PORT}.`);
});
