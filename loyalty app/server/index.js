const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const path = require("path");
const { connectToDatabase } = require("./config/database");
const app = express();
const http = require("http");
const server = http.createServer(app);
// const friendsController = require("./controllers/friendsController");

require("dotenv").config();

const port = process.env.PORT;

app.use(cors());
app.use(express.static(path.join(__dirname, "static")));
app.use(bodyParser.json());

// Connect to the database before starting the server
const startServer = async () => {
  try {
    await connectToDatabase();

    // Set up static files and views
    app.use(express.static(path.join(__dirname, "public")));

    const authRoutes = require("./routes/authRoutes");
    const transactionRoutes = require("./routes/transactionRoutes");
    const loyalityRoutes = require("./routes/loyalityRoutes");
    // const ticketRoutes = require("./routes/ticketRoute");
    // const userRoutes = require("./routes/userRoute");

    // Use routes
    app.use("/api/auth", authRoutes);
    app.use("/api/transaction", transactionRoutes);
    app.use("/api/loyality", loyalityRoutes);
    // app.use("/api/user", userRoutes);
    // Set CORS for specific routes
    app.use(cors({ origin: "*" }));

    server.listen(port, () => {
      console.log("Server listening on port: " + port);
    });
  } catch (error) {
    console.error("Error starting server:", error);
  }
};

// Start the server
startServer();
