import { Request, Response } from "express"
import { getUser } from "../utils/auth"
import { connection } from "../utils/db"

// Crea recensione
export function createRecensione(req: Request, res: Response) {
  const user = getUser(req, res)
  if (!user) {
    res.status(401).send("Autenticazione richiesta")
    return
  }

  const { gioco_id, contenuto } = req.body

  if (!gioco_id || !contenuto) {
    res.status(400).send("Dati mancanti")
    return
  }

  connection.query(
    'INSERT INTO recensioni (gioco_id, utente_id, contenuto) VALUES (?, ?, ?)',
    [gioco_id, user.id, contenuto],
    (err) => {
      if (err) {
        res.status(500).json({ error: err.message })
        return
      }
      res.json({ message: "Recensione creata" })
    }
  )
}

//ottieni recensioni per gioco
export function getRecensioniByGioco(req: Request, res: Response) {
  const { gioco_id } = req.params

  connection.query(
    `SELECT r.id, r.contenuto, r.created_at, u.username, r.utente_id 
     FROM recensioni r 
     JOIN utenti u ON r.utente_id = u.id 
     WHERE r.gioco_id = ? 
     ORDER BY r.created_at DESC`,
    [gioco_id],
    (err, results) => {
      if (err) {
        res.status(500).json({ error: err.message })
        return
      }
      res.json(results)
    }
  )
}

//elimina una recensione
export function deleteRecensione(req: Request, res: Response) {
  const user = getUser(req, res)
  if (!user) {
    res.status(401).send("Autenticazione richiesta")
    return
  }

  const { id } = req.params

  //verifica proprietà recensione
  connection.query(
    'SELECT utente_id FROM recensioni WHERE id = ?',
    [id],
    (err, results: any) => {
      if (err) {
        res.status(500).json({ error: err.message })
        return
      }

      if (!results || results.length === 0) {
        res.status(404).send("Recensione non trovata")
        return
      }

      const recensione = results[0]

      //Solo il proprietario del messaggio o l'admin può eliminare la recensione
      if (recensione.utente_id !== user.id && user.role !== 'admin') {
        res.status(403).send("Non autorizzato")
        return
      }

      connection.query(
        'DELETE FROM recensioni WHERE id = ?',
        [id],
        (err) => {
          if (err) {
            res.status(500).json({ error: err.message })
            return
          }
          res.json({ message: "Recensione eliminata" })
        }
      )
    }
  )
}
