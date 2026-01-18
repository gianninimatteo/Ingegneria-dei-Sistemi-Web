"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.tendenze = tendenze;
exports.prossimeUscite = prossimeUscite;
exports.consoleSpecifica = consoleSpecifica;
exports.dettaglioGioco = dettaglioGioco;
const db_1 = require("../utils/db");
//Giochi in tendenza
async function tendenze(req, res) {
    db_1.connection.execute('SELECT id, titolo, descrizione, prezzo, sviluppatore, data_rilascio, genere, piattaforma, immagine_url, in_tendenza, prossima_uscita, installazione FROM giochi WHERE in_tendenza = 1', [], function (err, results, fields) {
        res.json(results);
    });
}
;
//Giochi 'prossime uscite'
async function prossimeUscite(req, res) {
    db_1.connection.execute('SELECT id, titolo, descrizione, prezzo, sviluppatore, data_rilascio, genere, piattaforma, immagine_url, in_tendenza, prossima_uscita, installazione FROM giochi WHERE prossima_uscita = 1 ORDER BY data_rilascio ASC', [], function (err, results, fields) {
        res.json(results);
    });
}
;
//giochi divisi per console
async function consoleSpecifica(req, res) {
    db_1.connection.execute(`SELECT *
     FROM giochi
     WHERE piattaforma = ? AND prossima_uscita = 0
     ORDER BY in_tendenza DESC, titolo ASC`, [req.params.console], function (err, results, fields) {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json(results);
    });
}
//Dettaglio gioco
async function dettaglioGioco(req, res) {
    db_1.connection.execute('SELECT id, titolo, descrizione, prezzo, sviluppatore, data_rilascio, genere, piattaforma, immagine_url, in_tendenza, prossima_uscita, installazione FROM giochi WHERE id = ?', [req.params.id], function (err, results, fields) {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json(results);
    });
}
;
