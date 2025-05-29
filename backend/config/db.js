const mongoose = require("mongoose");

const MONGODB_URI = "mongodb://localhost:27017/todoapp";

const connectDB = async () => {
  try {
    await mongoose.connect(MONGODB_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log("Connected to MongoDB successfully");
  } catch (err) {
    console.error("Error while connecting to MongoDB:", err);
    process.exit(1);
  }
};

module.exports = connectDB;
