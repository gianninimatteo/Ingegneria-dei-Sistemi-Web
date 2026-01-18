export interface Gioco {
  id: number
  titolo: string
  descrizione: string
  prezzo: number
  sviluppatore: string
  data_rilascio: string
  genere: string
  piattaforma: string
  immagine_url: string
  installazione: string
  prossima_uscita?: number
}

export interface User {
  id: number
  username: string
  role: 'admin' | 'user'
}

export interface Recensione {
  id: number
  contenuto: string
  username: string
  utente_id: number
  created_at: string
}

export interface Acquisto {
  id: number
  gioco: Gioco
  codice_attivazione: string | null
  data_acquisto: string
}

export interface CarrelloItem {
  id: number
  gioco_id: number
  titolo: string
  prezzo: number
  immagine_url: string
  piattaforma: string
}
