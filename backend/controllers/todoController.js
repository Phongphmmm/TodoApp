const TodoService = require("../services/todoService");

class TodoController {
  async getAllTodos(req, res) {
    try {
      const todos = await TodoService.getAllTodos(req.user.id);
      res.json(todos);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  async getTodoById(req, res) {
    try {
      const todo = await TodoService.getTodoById(req.params.id, req.user.id);
      if (!todo) return res.status(404).json({ error: "Todo not found" });
      res.json(todo);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  async createTodo(req, res) {
    try {
      const todo = await TodoService.createTodo(req.body, req.user.id);
      res.status(201).json(todo);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  }

  async updateTodo(req, res) {
    try {
      const todo = await TodoService.updateTodo(
        req.params.id,
        req.body,
        req.user.id
      );
      if (!todo) return res.status(404).json({ error: "Todo not found" });
      res.json(todo);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  }

  async deleteTodo(req, res) {
    try {
      const todo = await TodoService.deleteTodo(req.params.id, req.user.id);
      if (!todo) return res.status(404).json({ error: "Todo not found" });
      res.json({ message: "Todo deleted" });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
}

module.exports = new TodoController();
