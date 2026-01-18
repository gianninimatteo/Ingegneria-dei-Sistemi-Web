"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.comparePassword = exports.hashPassword = exports.unsetUser = exports.getUser = exports.setUser = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const bcrypt_1 = __importDefault(require("bcrypt"));
const JWT_SECRET = "gamenest-secret-key";
const COOKIE_NAME = "gamenest-access-token";
//Codifica l'utente in un access token e lo imposta come cookie. Usato in fase di registrazione e login.
const setUser = (req, res, user) => {
    const accessToken = jsonwebtoken_1.default.sign(user, JWT_SECRET, { expiresIn: "1 day" });
    res.cookie(COOKIE_NAME, accessToken, {
        maxAge: 86400000, // 1 giorno in millisecondi
        httpOnly: true,
        sameSite: 'lax',
    });
};
exports.setUser = setUser;
//Decodifica e verifica l'access token, restituendo l'utente.
const getUser = (req, res) => {
    const accessToken = req.cookies[COOKIE_NAME];
    if (!accessToken)
        return null;
    try {
        const user = jsonwebtoken_1.default.verify(accessToken, JWT_SECRET);
        return user;
    }
    catch {
        return null;
    }
};
exports.getUser = getUser;
//Cancella il cookie contenente l'access token. Usato per effettuare il Logout.
const unsetUser = (req, res) => {
    res.clearCookie(COOKIE_NAME);
};
exports.unsetUser = unsetUser;
//hash della password
const hashPassword = async (password) => {
    return await bcrypt_1.default.hash(password, 10);
};
exports.hashPassword = hashPassword;
//Confronta password con hash
const comparePassword = async (password, hash) => {
    return await bcrypt_1.default.compare(password, hash);
};
exports.comparePassword = comparePassword;
