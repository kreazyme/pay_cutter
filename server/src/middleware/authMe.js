const User = require('../model/userModel')
const jwt = require('jsonwebtoken')

const authMe = async (req) => {
    try {
        const token = req.header("Authorization")
        if (!token) {
            return false
        }
        else {
            const verified = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET)
            if (!verified) {
                return false
            }
            else {
                const username = jwt.decode(token)
                const user = await User.findOne({ username: username })
                if (!user) {
                    return false
                }
                else {
                    return user._id
                }
            }
        }
    }
    catch (err) {
        console.log(err)
    }
};

module.exports = authMe