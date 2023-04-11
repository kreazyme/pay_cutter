const express = require('express')
const dotenv = require('dotenv').config()
const mongoose = require('mongoose')
const cookieParser = require('cookie-parser')

const app = express()
var cors = require('cors')

const port = process.env.PORT || 3000
const url = process.env.MONGODB_URL

mongoose.connect(url, {
}, err => {
  if (err) throw err;
  console.log('Connected to MongoDB')
})
mongoose.set('strictQuery', false)

app.use(cors())
app.use(express.json())
app.use(cookieParser())

app.use("/api/user", require("./src/router/userRouter"))
app.use("/api/post", require("./src/router/postRouter"))
app.use("/api/group", require("./src/router/groupRouter"))
app.use("/api/chat", require("./src/router/chatRouter"))

app.get('/', (req, res) => {
  res.send('Hello There!')
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})