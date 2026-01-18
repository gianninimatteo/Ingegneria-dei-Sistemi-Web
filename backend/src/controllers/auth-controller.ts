import { Request, Response } from "express"
import { getUser, setUser, unsetUser, hashPassword, comparePassword, User } from "../utils/auth"
import { connection } from "../utils/db"

export const register = async (req: Request, res: Response) => {
  const user = getUser(req, res)
  if (user) {
    res.status(401).send("Questa operazione richiede il logout.")
    return
  }

  const { username, password } = req.body

  connection.query("SELECT username FROM utenti WHERE username=?", [username], async (err, users: any) => {
    if (err) {
      res.status(500).send("Errore database")
      return
    }

    if (users.length > 0) {
      res.status(400).send("Username già in uso.")
      return
    }

    const passwordHash = await hashPassword(password)

    connection.query("INSERT INTO utenti (username, password, role) VALUES (?, ?, ?)", 
      [username, passwordHash, "user"], 
      (err) => {
        if (err) {
          res.status(500).send("Errore database")
          return
        }

        connection.query("SELECT id, username, role FROM utenti WHERE username=?", 
          [username], 
          (err, results: any) => {
            if (err) {
              res.status(500).send("Errore database")
              return
            }

            const newUser = results[0] as User
            setUser(req, res, newUser)
            res.json({ message: "Registrazione effettuata con successo" })
          }
        )
      }
    )
  })
}

export const login = async (req: Request, res: Response) => {
  const user = getUser(req, res)
  if (user) {
    res.status(401).send("Questa operazione richiede il logout.")
    return
  }

  const { username, password } = req.body

  connection.query("SELECT id, username, password, role FROM utenti WHERE username=?", 
    [username], 
    async (err, results: any) => {
      if (err) {
        res.status(500).send("Errore database")
        return
      }

      if (!results || results.length === 0) {
        res.status(400).send("Credenziali errate.")
        return
      }

      const userData = results[0]
      const correctPassword = await comparePassword(password, userData.password)

      if (!correctPassword) {
        res.status(400).send("Credenziali errate.")
        return
      }

      delete userData.password
      setUser(req, res, userData)
      res.json({ message: "Login effettuato con successo" })
    }
  )
}

export const logout = async (req: Request, res: Response) => {
  unsetUser(req, res)
  res.json({ message: "Logout effettuato con successo" })
}

export const getProfile = async (req: Request, res: Response) => {
  const user = getUser(req, res)
  res.json(user)
}
