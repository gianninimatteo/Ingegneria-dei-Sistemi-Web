"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const cookie_parser_1 = __importDefault(require("cookie-parser"));
const cors_1 = __importDefault(require("cors"));
const connect_history_api_fallback_1 = __importDefault(require("connect-history-api-fallback"));
const giochi_router_1 = __importDefault(require("./routes/giochi-router"));
const auth_router_1 = __importDefault(require("./routes/auth-router"));
const recensioni_router_1 = __importDefault(require("./routes/recensioni-router"));
const carrello_router_1 = __importDefault(require("./routes/carrello-router"));
const acquisti_router_1 = __importDefault(require("./routes/acquisti-router"));
const app = (0, express_1.default)();
const port = 3000;
app.use((0, connect_history_api_fallback_1.default)({
    rewrites: [
        { from: /^\/api\/.*$/, to: context => context.parsedUrl.pathname || '' } // Escludi /api/* dal fallback
    ]
})); // Fallback per SPA - deve essere PRIMA di tutto
app.use((0, cors_1.default)({ origin: 'http://localhost:5173', credentials: true })); //per frontend
app.use(express_1.default.json()); //per leggere req.body
app.use((0, cookie_parser_1.default)()); //Per leggere cookies
app.use(express_1.default.static("public"));
app.use(express_1.default.static("dist-frontend")); //serve i file del frontend compilato
app.use(giochi_router_1.default);
app.use(auth_router_1.default);
app.use(recensioni_router_1.default);
app.use(carrello_router_1.default);
app.use(acquisti_router_1.default);
app.listen(port, function () {
    console.log(`Listening on http://localhost:${port}`);
});
