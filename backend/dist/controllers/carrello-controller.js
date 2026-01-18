"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.addToCarrello = addToCarrello;
exports.getCarrello = getCarrello;
exports.removeFromCarrello = removeFromCarrello;
const auth_1 = require("../utils/auth");
const db_1 = require("../utils/db");
//aggiungi al carrello
function addToCarrello(req, res) {
    const user = (0, auth_1.getUser)(req, res);
    if (!user) {
        res.status(401).send("Autenticazione richiesta");
        return;
    }
    const { gioco_id } = req.body;
    if (!gioco_id) {
        res.status(400).send("ID gioco mancante");
        return;
    }
    //verifica se un gioco è già nel carrello
    db_1.connection.query('SELECT * FROM carrello WHERE utente_id = ? AND gioco_id = ?', [user.id, gioco_id], (err, results) => {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        if (results.length > 0) {
            res.status(400).send("Gioco già nel carrello");
            return;
        }
        db_1.connection.query('INSERT INTO carrello (utente_id, gioco_id) VALUES (?, ?)', [user.id, gioco_id], (err) => {
            if (err) {
                res.status(500).json({ error: err.message });
                return;
            }
            res.json({ message: "Gioco aggiunto al carrello" });
        });
    });
}
//visualizza il carrello
function getCarrello(req, res) {
    const user = (0, auth_1.getUser)(req, res);
    if (!user) {
        res.status(401).send("Autenticazione richiesta");
        return;
    }
    db_1.connection.query(`SELECT c.id, g.id as gioco_id, g.titolo, g.prezzo, g.immagine_url, g.piattaforma
     FROM carrello c
     JOIN giochi g ON c.gioco_id = g.id
     WHERE c.utente_id = ?`, [user.id], (err, results) => {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        //converte il prezzo da stringa a Numero
        const carrelloItems = results.map((item) => ({
            ...item,
            prezzo: parseFloat(item.prezzo)
        }));
        res.json(carrelloItems);
    });
}
//rimuove dal carrello i giochi
function removeFromCarrello(req, res) {
    const user = (0, auth_1.getUser)(req, res);
    if (!user) {
        res.status(401).send("Autenticazione richiesta");
        return;
    }
    const { gioco_id } = req.params;
    db_1.connection.query('DELETE FROM carrello WHERE utente_id = ? AND gioco_id = ?', [user.id, gioco_id], (err) => {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json({ message: "Gioco rimosso dal carrello" });
    });
}
