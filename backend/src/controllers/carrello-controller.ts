import { Request, Response } from "express"
import { getUser } from "../utils/auth"
import { connection } from "../utils/db"

//aggiungi al carrello
export function addToCarrello(req: Request, res: Response) {
  const user = getUser(req, res)
  if (!user) {
    res.status(401).send("Autenticazione richiesta")
    return
  }

  const { gioco_id } = req.body

  if (!gioco_id) {
    res.status(400).send("ID gioco mancante")
    return
  }

  //verifica se un gioco è già nel carrello
  connection.query(
    'SELECT * FROM carrello WHERE utente_id = ? AND gioco_id = ?',
    [user.id, gioco_id],
    (err, results: any) => {
      if (err) {
        res.status(500).json({ error: err.message })
        return
      }

      if (results.length > 0) {
        res.status(400).send("Gioco già nel carrello")
        return
      }

      connection.query(
        'INSERT INTO carrello (utente_id, gioco_id) VALUES (?, ?)',
        [user.id, gioco_id],
        (err) => {
          if (err) {
            res.status(500).json({ error: err.message })
            return
          }
          res.json({ message: "Gioco aggiunto al carrello" })
        }
      )
    }
  )
}

//visualizza il carrello
export function getCarrello(req: Request, res: Response) {
  const user = getUser(req, res)
  if (!user) {
    res.status(401).send("Autenticazione richiesta")
    return
  }

  connection.query(
    `SELECT c.id, g.id as gioco_id, g.titolo, g.prezzo, g.immagine_url, g.piattaforma
     FROM carrello c
     JOIN giochi g ON c.gioco_id = g.id
     WHERE c.utente_id = ?`,
    [user.id],
    (err, results: any) => {
      if (err) {
        res.status(500).json({ error: err.message })
        return
      }
      //converte il prezzo da stringa a Numero
      const carrelloItems = results.map((item: any) => ({
        ...item,
        prezzo: parseFloat(item.prezzo)
      }))
      res.json(carrelloItems)
    }
  )
}

//rimuove dal carrello i giochi
export function removeFromCarrello(req: Request, res: Response) {
  const user = getUser(req, res)
  if (!user) {
    res.status(401).send("Autenticazione richiesta")
    return
  }

  const { gioco_id } = req.params

  connection.query(
    'DELETE FROM carrello WHERE utente_id = ? AND gioco_id = ?',
    [user.id, gioco_id],
    (err) => {
      if (err) {
        res.status(500).json({ error: err.message })
        return
      }
      res.json({ message: "Gioco rimosso dal carrello" })
    }
  )
}
