const router = require('express').Router()
const postController = require('../controller/postController')
const auth = require('../middleware/auth')

router.post('/create', auth, postController.createPost)
router.get('/get', postController.getPosts)
router.post('/comment', auth, postController.createComment)
router.get('/comment', postController.getComments)

module.exports = router