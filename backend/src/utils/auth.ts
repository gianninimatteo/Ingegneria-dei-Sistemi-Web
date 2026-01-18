import { Request, Response } from "express"
import jwt from "jsonwebtoken"
import bcrypt from "bcrypt"

//campi da inserire nell'access token
export interface User {
  id: number
  username: string
  role: "admin" | "user"
}

const JWT_SECRET = "gamenest-secret-key"
const COOKIE_NAME = "gamenest-access-token"


 //Codifica l'utente in un access token e lo imposta come cookie. Usato in fase di registrazione e login.
 
export const setUser = (req: Request, res: Response, user: User) => {
  const accessToken = jwt.sign(user, JWT_SECRET, { expiresIn: "1 day" })
  res.cookie(COOKIE_NAME, accessToken, {
    maxAge: 86400000, // 1 giorno in millisecondi
    httpOnly: true,
    sameSite: 'lax',
  })
}


 //Decodifica e verifica l'access token, restituendo l'utente.
export const getUser = (req: Request, res: Response) => {
  const accessToken = req.cookies[COOKIE_NAME]
  if (!accessToken) return null
  try {
    const user = jwt.verify(accessToken, JWT_SECRET) as User
    return user
  } catch {
    return null
  }
}


//Cancella il cookie contenente l'access token. Usato per effettuare il Logout.
export const unsetUser = (req: Request, res: Response) => {
  res.clearCookie(COOKIE_NAME)
}


//hash della password
export const hashPassword = async (password: string): Promise<string> => {
  return await bcrypt.hash(password, 10)
}


//Confronta password con hash
export const comparePassword = async (password: string, hash: string): Promise<boolean> => {
  return await bcrypt.compare(password, hash)
}
