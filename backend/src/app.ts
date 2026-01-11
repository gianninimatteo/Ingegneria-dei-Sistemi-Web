import express from "express"
import type { Express } from "express"
import { connection } from "./utils/db.js";

const app: Express = express();
const port: number = 3000;

app.use(express.static("public"));

app.use(function(req, res, next) {
  res.setHeader("Content-Type", "text/plain")
  res.status(404).send("Ops... Pagina non trovata")
})

app.listen(port, function() {
  console.log(`Listening on http://localhost:${port}`)
})