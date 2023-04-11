const User = require('../model/userModel')
const Post = require('../model/postModel');
const authMe = require('../middleware/authMe');

const postController = {
    createPost: async (req, res) => {
        try {
            const { content } = req.body;
            console.log(content)
            if (!content) {
                res.status(400).send('Content is missing')
                return;
            }
            const userID = await authMe(req)
            const user = await User.findById(userID)
            if (!user) {
                res.status(404).send('User not found')
                return;
            }
            else {
                const newPost = new Post({
                    content,
                    user: {
                        user_id: user._id,
                        username: user.username,
                        name: user.name,
                    },
                })
                await newPost.save()
                res.send(newPost)
            }
        }
        catch (err) {
            console.log(err)
            res.status(500).send({ message: "Internal Server" })
        }
    },
    getPosts: async (req, res) => {
        const PERPAGE = 20
        try {
            const { page } = req.query
            if (!page) {
                res.status(400).send('Page is missing')
                return;
            }
            const count = await Post.countDocuments()
            const posts = await Post.find().sort({ createdAt: -1 }).limit(PERPAGE).slice('comments', 2).skip((page - 1) * PERPAGE)
            res.send({
                data: posts,
                totalPage: Math.ceil(count / PERPAGE),
            })
        }
        catch (err) {
            console.log(err)
            res.status(500).send({ message: "Internal Server" })
        }
    },
    createComment: async (req, res) => {
        try {
            const { content, post_id } = req.body
            if (!content || !post_id) {
                res.status(400).send('content or post_id is missing')
                return;
            }
            const userID = await authMe(req)
            const user = await User.findById(userID)
            if (!user) {
                res.status(404).send('User not found')
                return;
            }
            else {
                const post = await Post.findById(post_id)
                if (!post) {
                    res.status(404).send('Post not found')
                    return;
                }
                else {
                    const newComment = {
                        content,
                        user: {
                            user_id: user._id,
                            username: user.username,
                            name: user.name,
                        },
                    }
                    post.comments.push(newComment)
                    await post.save()
                    res.send(post)
                }
            }
        }
        catch (err) {
            console.log(err)
            res.status(500).send({ message: "Internal Server" })
        }
    },
    getComments: async (req, res) => {
        const PERPAGE = 20
        try {
            const { post_id, page } = req.query
            if (!post_id || !page) {
                res.status(400).send('post_id or page is missing')
                return;
            }
            const post = await Post.findById(post_id)
            if (!post) {
                res.status(404).send('Post not found')
                return;
            }
            else {
                const count = post.comments.length
                const comments = post.comments.slice(PERPAGE * (page - 1), PERPAGE * (page - 1) + PERPAGE)
                res.send({
                    data: comments,
                    totalPage: Math.ceil(count / PERPAGE)
                })
            }
        }
        catch (err) {
            console.log(err)
            res.status(500).send({ message: "Internal Server" })
        }
    }
}

module.exports = postController