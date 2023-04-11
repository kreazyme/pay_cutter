const router = require('express').Router()
const {
    createGroup,
    getMyGroups,
} = require('../controller/groupController')
const auth = require('../middleware/auth')

router.post('/', auth, createGroup)
router.get('/', auth, getMyGroups)


module.exports = router