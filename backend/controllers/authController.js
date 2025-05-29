const AuthService = require("../services/authService");

class AuthController {
  async register(req, res) {
    try {
      const { email, password } = req.body;
      const token = await AuthService.register(email, password);
      res.status(201).json({ token });
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  }

  async login(req, res) {
    try {
      const { email, password } = req.body;
      const token = await AuthService.login(email, password);
      res.json({ token });
    } catch (error) {
      res.status(401).json({ error: error.message });
    }
  }
}

module.exports = new AuthController();
