import express from "express";
import path from "path";
import livereload from "livereload";
import connectLivereload from "connect-livereload";

const app = express();
const port = 3030;

const liveReloadServer = livereload.createServer();
liveReloadServer.watch(path.join(__dirname, "views"));

liveReloadServer.server.once("connection", () => {
  setTimeout(() => {
    liveReloadServer.refresh("/");
  }, 100);
});

app.use(connectLivereload());

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "pug");

app.get("/", (req, res) => {
  res.render("index", {
    name : "CHAIN"
  });
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
