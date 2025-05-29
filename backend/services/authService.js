const jwt = require("jsonwebtoken");
const User = require("../models/userModel");

class AuthService {
  async register(email, password) {
    const existingUser = await User.findOne({ email });
    if (existingUser) throw new Error("Email already exists");
    const user = new User({ email, password });
    await user.save();
    return this.generateToken(user);
  }

  async login(email, password) {
    const user = await User.findOne({ email });
    if (!user) throw new Error("Invalid credentials");
    const isMatch = await user.comparePassword(password);
    if (!isMatch) throw new Error("Invalid credentials");
    return this.generateToken(user);
  }

  generateToken(user) {
    return jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
      expiresIn: "1h",
    });
  }
}

module.exports = new AuthService();
