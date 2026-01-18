import {connection} from "../utils/db"
import {Request, Response} from "express"

//Giochi in tendenza
export async function tendenze(req: Request, res: Response){
    connection.execute(
        'SELECT id, titolo, descrizione, prezzo, sviluppatore, data_rilascio, genere, piattaforma, immagine_url, in_tendenza, prossima_uscita, installazione FROM giochi WHERE in_tendenza = 1',
        [],
        function(err, results, fields) {
            res.json(results);
        }
    );
};

//Giochi 'prossime uscite'
export async function prossimeUscite(req: Request, res: Response){
    connection.execute(
        'SELECT id, titolo, descrizione, prezzo, sviluppatore, data_rilascio, genere, piattaforma, immagine_url, in_tendenza, prossima_uscita, installazione FROM giochi WHERE prossima_uscita = 1 ORDER BY data_rilascio ASC',
        [],
        function(err, results, fields) {
            res.json(results);
        }
    );
};

//giochi divisi per console
export async function consoleSpecifica(req: Request, res: Response) {
  connection.execute(
    `SELECT *
     FROM giochi
     WHERE piattaforma = ? AND prossima_uscita = 0
     ORDER BY in_tendenza DESC, titolo ASC`,
    [req.params.console],
    function(err, results, fields) {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      res.json(results);
    }
  );
}

//Dettaglio gioco
export async function dettaglioGioco(req: Request, res: Response){
    connection.execute(
        'SELECT id, titolo, descrizione, prezzo, sviluppatore, data_rilascio, genere, piattaforma, immagine_url, in_tendenza, prossima_uscita, installazione FROM giochi WHERE id = ?',
        [req.params.id],
        function(err, results, fields) {
            if (err) {
                res.status(500).json({ error: err.message });
                return;
            }
            res.json(results);
        }
    );
};

