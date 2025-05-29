const express = require("express");
const router = express.Router();
const todoController = require("../controllers/todoController");
const jwt = require("jsonwebtoken");
require("dotenv").config();

const authenticateToken = (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) {
    console.error("No token provided");
    return res.status(401).json({ error: "No token provided" });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    console.log("Decoded token:", decoded);
    if (!decoded.id) {
      console.error("Invalid token: No user ID found");
      return res.status(403).json({ error: "Invalid token: No user ID" });
    }
    req.user = decoded;
    console.log("Authenticated user:", req.user);
    next();
  } catch (err) {
    console.error("Token verification error:", err.message);
    return res.status(403).json({ error: "Invalid or expired token" });
  }
};

router.get("/", authenticateToken, todoController.getAllTodos);
router.get("/:id", authenticateToken, todoController.getTodoById);
router.post("/", authenticateToken, todoController.createTodo);
router.put("/:id", authenticateToken, todoController.updateTodo);
router.delete("/:id", authenticateToken, todoController.deleteTodo);

module.exports = router;
