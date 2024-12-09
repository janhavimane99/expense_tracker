const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  username: String,
  password: String,
  emailId: String
});

module.exports = mongoose.model("User", userSchema);
