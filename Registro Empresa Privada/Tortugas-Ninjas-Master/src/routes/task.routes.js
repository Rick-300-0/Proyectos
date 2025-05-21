const { Router } = require("express");  
const { getAllTask, getTask, createTask, updateTask, deleteTask} = require("../controllers/task.controllers.js")

const router = Router();

router.get("/tasks", getAllTask)

router.get("/tasks/:id", getTask)

router.post("/tasks", createTask)

router.put("/tasks/:id", updateTask)

router.delete("/tasks/:id", deleteTask)

module.exports = router;






