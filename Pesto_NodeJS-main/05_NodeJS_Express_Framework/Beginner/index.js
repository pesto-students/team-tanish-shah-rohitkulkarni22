const express = require("express");
const bodyParser = require("body-parser");
const { Console } = require("console");
const logRequest = require("./middlewares/logger");


const app = express();
const PORT = 8777;

// initializing the Body Parser
app.use(bodyParser.json());

// logRequest Middleware
app.use(logRequest);

// Array to store the list of tasks
let tasks = [];

app.listen(PORT, () => console.log(`Listening to PORT: ${PORT}`));


// Routes

// Route for Displaying the list of tasks 
app.get("/tasks", (req, res) => {
    return res.json(tasks);
});

// Adding a New Task
app.post("/tasks", (req, res) => {
    const { title, description } = req.body;

    if (!title || !description) {
        return res.status(400).json({error: 'Title and Description is required!'});
    }

    const newTask = {
        id: tasks.length + 1,
        title: title, 
        description: description,
        completed: false,
    };

    tasks.push(newTask);
    // Returning the newly created task
    return res.status(201).json(newTask);
});


// View details of a specific task (GET /tasks/:id)

app.get("/tasks/:id", (req, res) => {
    const taskId = parseInt(req.params.id);
    const task = tasks.find(task => task.id === taskId);

    if (!task) {
        return res.status(404).json({ error: 'Task not found.' });
    }

    return res.json(task);
});


// Update a task's details
app.put('/tasks/:id', (req, res) => {
    const taskId = parseInt(req.params.id);
    const taskIndex = tasks.findIndex(task => task.id === taskId);
  
    if (taskIndex === -1) {
      return res.status(404).json({ error: 'Task not found.' });
    }
  
    const { title, description, completed } = req.body;
    tasks[taskIndex] = { ...tasks[taskIndex], title, description, completed };
  
    return res.json(tasks[taskIndex]);
});


// Delete a task
app.delete('/tasks/:id', (req, res) => {
    const taskId = parseInt(req.params.id);
    tasks = tasks.filter(task => task.id !== taskId);
      
    return res.json({ message: 'Task deleted successfully.' });
});
