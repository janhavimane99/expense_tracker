const userRoute = require("express").Router();
const User = require("../modal/user-pojo");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");


userRoute.post("/signup", async (req, res) => {
  //getting bosy from request
  const bd = req.body;

  //checking user email is already exist or not
  const userExist = await User.findOne({
    $or: [
      { emailId: bd.emailId },
      { username: bd.username }
    ]
  });

  //if emailId exist will retrun bad request or will proceed as new user resistration
  if (userExist) {
    return res.status(400).send({ message: "Email Id/Username is already exists..!" });
  }

  // hash/encrypt the  password
  // const saltRounds = 10;
  // const salt = await bcrypt.genSalt(saltRounds);
  // const hashedPassword = await bcrypt.hash(bd.password, salt);

  const newUser = new User({
    username: bd.username,
    password: bd.password,
    emailId: bd.emailId
  });

  try {
    if (newUser) {
      const addedUser = await newUser.save();
      const resUser = {
        username: addedUser.username,
        _id: addedUser._id,
      }
      res.json({
        message: "New user added.",
        user: resUser,
      });
    } else {
      res.json({
        message: "New user not added.",
        user: undefined,
      });
    }
  } catch (error) {
    res.status(500).json({ message: "Internal server error", error: error.message });
  }
});

userRoute.post("/login", async (req, res) => {
  try {
    // recieved user data from request.body
    const bd = req.body;

    // searched for the user in db
    const getUser = await User.findOne({
      username: bd.username,
    });

    // checked if user is found or not
    if (!getUser) return res.status(404).send("User not found..!");

    // if user is present then here password will be checked
    const isMatch = await bd.password === getUser.password /* bcrypt.compare(bd.password, getUser.password) */;

    // if password does not matches, this will retrun error
    if (!isMatch) return res.status(401).json({ message: "Invalid password" });

    // else will return user details with success message
    //generate jwt token
    const token = jwt.sign({ username: getUser.username }, process.env.TOKEN_SECRET);

    res.header("auth-token", token).send({
      message: getUser.username + " logged in successfully..!",
      username: getUser.username,
      _id: getUser._id,
      token: token
    });

  } catch (error) {
    // if there is issue, this will capture it then print it
    console.error("Error logging in user:", error);
    // return error as response
    res.status(500).json({ message: "Internal server error" });
  }
});

module.exports = userRoute;
