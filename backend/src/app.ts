import express from "express"
import type { Express } from "express"
import { connection } from "./utils/db.js";
import cookieParser from 'cookie-parser';
import cors from 'cors';
import path from 'path';
import history from 'connect-history-api-fallback';

import giochiRouter from "./routes/giochi-router"
import authRouter from "./routes/auth-router"
import recensioniRouter from "./routes/recensioni-router"
import carrelloRouter from "./routes/carrello-router"
import acquistiRouter from "./routes/acquisti-router"

const app: Express = express();
const port: number = 3000;

app.use(history({
  rewrites: [
    { from: /^\/api\/.*$/, to: context => context.parsedUrl.pathname || '' } //per far funzionare le route di Vue
  ]
}));
app.use(cors({ origin: 'http://localhost:5173', credentials: true })); //per frontend
app.use(express.json()); //per leggere req.body
app.use(cookieParser()); //Per leggere cookies
app.use(express.static("public"));
app.use(express.static("dist-frontend")); //serve i file del frontend compilato

app.use(giochiRouter);
app.use(authRouter);
app.use(recensioniRouter);
app.use(carrelloRouter);
app.use(acquistiRouter);

app.listen(port, function() {
  console.log(`Listening on http://localhost:${port}`)
})
