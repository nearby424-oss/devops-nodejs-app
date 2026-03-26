const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send("🚀 DevOps Node.js App Running Successfully!");
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: "UP" });
});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});