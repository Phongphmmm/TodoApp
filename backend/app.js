const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const connectDB = require("./config/db");
const todoRoutes = require("./routes/todo.routes");
const authRoutes = require("./routes/auth.routes");

dotenv.config();
const app = express();

connectDB();

app.use(cors());
app.use(express.json());

app.use("/api/todos", todoRoutes);
app.use("/api/auth", authRoutes);

module.exports = app;
