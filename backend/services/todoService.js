const Todo = require("../models/todoModel");

class TodoService {
  async getAllTodos(userId) {
    return await Todo.find({ user: userId });
  }

  async getTodoById(id, userId) {
    return await Todo.findOne({ _id: id, user: userId });
  }

  async createTodo(data, userId) {
    const todo = new Todo({ ...data, user: userId });
    return await todo.save();
  }

  async updateTodo(id, data, userId) {
    return await Todo.findOneAndUpdate({ _id: id, user: userId }, data, {
      new: true,
    });
  }

  async deleteTodo(id, userId) {
    return await Todo.findOneAndDelete({ _id: id, user: userId });
  }
}

module.exports = new TodoService();
