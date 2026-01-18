"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getProfile = exports.logout = exports.login = exports.register = void 0;
const auth_1 = require("../utils/auth");
const db_1 = require("../utils/db");
const register = async (req, res) => {
    const user = (0, auth_1.getUser)(req, res);
    if (user) {
        res.status(401).send("Questa operazione richiede il logout.");
        return;
    }
    const { username, password } = req.body;
    db_1.connection.query("SELECT username FROM utenti WHERE username=?", [username], async (err, users) => {
        if (err) {
            res.status(500).send("Errore database");
            return;
        }
        if (users.length > 0) {
            res.status(400).send("Username già in uso.");
            return;
        }
        const passwordHash = await (0, auth_1.hashPassword)(password);
        db_1.connection.query("INSERT INTO utenti (username, password, role) VALUES (?, ?, ?)", [username, passwordHash, "user"], (err) => {
            if (err) {
                res.status(500).send("Errore database");
                return;
            }
            db_1.connection.query("SELECT id, username, role FROM utenti WHERE username=?", [username], (err, results) => {
                if (err) {
                    res.status(500).send("Errore database");
                    return;
                }
                const newUser = results[0];
                (0, auth_1.setUser)(req, res, newUser);
                res.json({ message: "Registrazione effettuata con successo" });
            });
        });
    });
};
exports.register = register;
const login = async (req, res) => {
    const user = (0, auth_1.getUser)(req, res);
    if (user) {
        res.status(401).send("Questa operazione richiede il logout.");
        return;
    }
    const { username, password } = req.body;
    db_1.connection.query("SELECT id, username, password, role FROM utenti WHERE username=?", [username], async (err, results) => {
        if (err) {
            res.status(500).send("Errore database");
            return;
        }
        if (!results || results.length === 0) {
            res.status(400).send("Credenziali errate.");
            return;
        }
        const userData = results[0];
        const correctPassword = await (0, auth_1.comparePassword)(password, userData.password);
        if (!correctPassword) {
            res.status(400).send("Credenziali errate.");
            return;
        }
        delete userData.password;
        (0, auth_1.setUser)(req, res, userData);
        res.json({ message: "Login effettuato con successo" });
    });
};
exports.login = login;
const logout = async (req, res) => {
    (0, auth_1.unsetUser)(req, res);
    res.json({ message: "Logout effettuato con successo" });
};
exports.logout = logout;
const getProfile = async (req, res) => {
    const user = (0, auth_1.getUser)(req, res);
    res.json(user);
};
exports.getProfile = getProfile;
