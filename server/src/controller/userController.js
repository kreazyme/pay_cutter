const User = require('../model/userModel')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken');

const userController = {
    register: async (req, res) => {
        try {
            const { username, password, full_name, avatarUrl, email } = req.body;
            if (!username || !password || !full_name || !avatarUrl || !email) {
                res.status(400).send({ message: 'Missing information. Require username, password, full_name, avatarUrl, email', },)
                return;
            }
            else {
                const user = await User.findOne({ username: username })
                if (user) {
                    res.status(400).send('Username already exists')
                    return;
                }
                else {
                    const passwordHash = await bcrypt.hash(password, 10);
                    const newUser = new User({
                        username,
                        full_name,
                        password: passwordHash,
                        avatarUrl,
                        email
                    });
                    await newUser.save()
                    const token = jwt.sign(username, process.env.ACCESS_TOKEN_SECRET);
                    res.send({ token: token })
                }
            }
        }
        catch (err) {
            console.log(err)
            res.status(500).send({ message: "Internal Server" })
        }
    },
    login: async (req, res) => {
        const { username, password } = req.body;
        if (!username || !password) {
            res.status(400).send('Username or password is missing')
            return;
        }
        const user = await User.findOne({ username: username })
        if (!user) {
            res.status(404).send('User not found')
            return;
        }
        else {
            let isCorret = await bcrypt.compare(password, user.password)
            if (!isCorret) {
                res.status(400).send('Incorrect password')
                return;
            }
            const token = jwt.sign(username, process.env.ACCESS_TOKEN_SECRET);
            res.send({ token: token })
        }
    },
}
module.exports = userController