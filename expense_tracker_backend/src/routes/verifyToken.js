const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
    const token = req.header('auth-token');
    if (!token) return res.status(401).send('Access Denied..!');
    try {
        const verifyToken = jwt.verify(token, process.env.TOKEN_SECRET);
        req.user = verifyToken;
        next();
    } catch (error) {
        console.log(error);
        return res.status(400).send('Invalid Token..!');
    }
} 