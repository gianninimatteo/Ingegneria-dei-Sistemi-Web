import { Request, Response } from "express"
import { getUser } from "../utils/auth"
import { connection } from "../utils/db"

//genera il codice di attivazione randomico
function generaCodice(): string {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  let codice = ''
  for (let i = 0; i < 4; i++) {
    for (let j = 0; j < 5; j++) {
      codice += chars.charAt(Math.floor(Math.random() * chars.length))
    }
    if (i < 3) codice += '-'
  }
  return codice
}

//processa acquisto (pagamento fake)
export function processaAcquisto(req: Request, res: Response) {
  const user = getUser(req, res)
  if (!user) {
    res.status(401).send("Autenticazione richiesta")
    return
  }

  //ottieni Carrello utente con info giochi
  connection.query(
    `SELECT c.gioco_id, g.piattaforma
     FROM carrello c
     JOIN giochi g ON c.gioco_id = g.id
     WHERE c.utente_id = ?`,
    [user.id],
    (err, carrello: any) => {
      if (err) {
        res.status(500).json({ error: err.message })
        return
      }

      if (carrello.length === 0) {
        res.status(400).send("Carrello vuoto")
        return
      }

      //inserisci acquisti e genera codici solo per le console
      let completati = 0

      carrello.forEach((item: any) => {
        //genera codice solo per giochi console, NULL per PC
        const isConsole = ['PlayStation', 'Xbox', 'Nintendo'].includes(item.piattaforma)
        const codice = isConsole ? generaCodice() : null

        connection.query(
          'INSERT INTO acquisti (utente_id, gioco_id, codice_attivazione) VALUES (?, ?, ?)',
          [user.id, item.gioco_id, codice],
          (err) => {
            if (err) {
              console.error(err)
              return
            }
            completati++

            //una volta che tutti gli inserimenti sono completati svuota il carrello
            if (completati === carrello.length) {
              connection.query(
                'DELETE FROM carrello WHERE utente_id = ?',
                [user.id],
                (err) => {
                  if (err) {
                    res.status(500).json({ error: err.message })
                    return
                  }
                  res.json({ message: "Acquisto completato" })
                }
              )
            }
          }
        )
      })
    }
  )
}

//verifica se il gioco è già stato acquistato
export function verificaAcquisto(req: Request, res: Response) {
  const user = getUser(req, res)
  if (!user) {
    res.status(401).send("Autenticazione richiesta")
    return
  }

  connection.query(
    'SELECT COUNT(*) as count FROM acquisti WHERE utente_id = ? AND gioco_id = ?',
    [user.id, req.params.giocoId],
    (err, results: any) => {
      if (err) {
        res.status(500).json({ error: err.message })
        return
      }
      res.json({ acquistato: results[0].count > 0 })
    }
  )
}

//visualizza libreria
export function getLibreria(req: Request, res: Response) {
  const user = getUser(req, res)
  if (!user) {
    res.status(401).send("Autenticazione richiesta")
    return
  }

  connection.query(
    `SELECT a.id, a.codice_attivazione, a.data_acquisto,
            g.id as gioco_id, g.titolo, g.piattaforma, g.immagine_url, g.descrizione,
            g.prezzo, g.sviluppatore, g.data_rilascio, g.genere, g.installazione
     FROM acquisti a
     JOIN giochi g ON a.gioco_id = g.id
     WHERE a.utente_id = ?
     ORDER BY a.data_acquisto DESC`,
    [user.id],
    (err, results: any) => {
      if (err) {
        res.status(500).json({ error: err.message })
        return
      }

      //Ristruttura i dati della join separando i campi di Acquisto dai campi di Gioco e nel frontend usare acquisto.gioco.titolo 
      const acquisti = results.map((row: any) => ({
        id: row.id,
        codice_attivazione: row.codice_attivazione,
        data_acquisto: row.data_acquisto,
        gioco: {
          id: row.gioco_id,
          titolo: row.titolo,
          piattaforma: row.piattaforma,
          immagine_url: row.immagine_url,
          descrizione: row.descrizione,
          prezzo: parseFloat(row.prezzo),
          sviluppatore: row.sviluppatore,
          data_rilascio: row.data_rilascio,
          genere: row.genere,
          installazione: row.installazione
        }
      }))

      res.json(acquisti)
    }
  )
}
