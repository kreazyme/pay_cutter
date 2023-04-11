const router = require('express').Router()
const {
    getMessage,
    createNewChat,
} = require('../controller/chatController')
const auth = require('../middleware/auth')

router.post('/', auth, createNewChat)
router.get('/', auth, getMessage)


module.exports = router