Progetto Ingegneria dei Sistemi Web 2026
-

**Introduzione**

Gamenest Shop è un applicativo che consente di acquistare e visualizzare videogiochi per
diverse console, tra cui pc, Playstation, Xbox e Nintendo. Una volta registrati si viene
indirizzati alla Homepage che mostra tutti i giochi in Tendenza. Navigando nel menù sotto si
possono visualizzare i giochi specifici di ogni Console, per una ricerca più veloce del gioco
desiderato. Nella sezione “Prossime uscite” si possono invece visualizzare i giochi non ancora
disponibili, ma che usciranno a breve.
Cliccando su ogni gioco si possono vedere le specifiche, tra cui Descrizione, Sviluppatore, Data
di rilascio, Genere e Installazione, e in fondo le recensioni.
Da qui si possono aggiungere i giochi al Carrello.
Dalla navbar si può accedere alla pagina del Carrello per vedere il riepilogo e fare il
pagamento.
Una volta completato il pagamento il gioco sarà visibile nella libreria. Se il gioco è per Console,
si può visualizzare anche il codice da inserire nei vari Store.
Features per Utenti
- Si può esplorare il sito, acquistare e visualizzare i giochi acquistati.
- Si possono scrivere recensioni per ogni videogioco.
- E’ possibile vedere il proprio profilo in alto (nome utente).
- Responsive design
Features per Amministratori
- Si può accedere con username : admin
-
password : admin
- Il colore del nome utente sarà diverso e fa capire che abbiamo fatto l’accesso come
amministratori.
- Possibilità di cancellare le recensioni di tutti gli utenti.
Tecnologie utilizzate
- Backend
• Node.js
• npm
• Express.js
• Typescript
• bcrypt (hash delle password)
• jsonwebtoken (creazione del token JWT)
• cookie-parser (legge i cookie dalle richieste)
• XAMP (per avviare MySQL)
- Frontend
• Vue.js
• Vite
• Axios
• Vue Router
Installazione
- Clona il Repository nella cartella di tuo interesse: git clone https://github.com/
gianninimatteo/Ingegneria-dei-Sistemi-Web.git
- Installare le dipendenze sia in backend che in frontend con il comando npm i
- Aprire XAMP e creare il db con le varie tabelle (contenuto in backend>sql).
- Eseguire l’applicazione con il comando npm run dev sia in frontend che in backend.
- Visitare il link dal frontend.
API Endpoints
- GET
• /api/auth/profile
• /api/tendenze
• /api/prossimeUscite
• /api/giochi/:id
• /api/carrello
• /api/acquisti/verifica/:giocoId
• /api/libreria
• /api/recensioni/:gioco_id
- POST
• /api/auth/register
• /api/auth/login
• /api/auth/logout
• /api/carrello
• /api/acquisti
• /api/recensioni
- DELETE
• /api/carrello/:giocoId
• /api/recensioni/:id
