-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Gen 18, 2026 alle 23:46
-- Versione del server: 10.4.28-MariaDB
-- Versione PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gamenest`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `acquisti`
--

CREATE TABLE `acquisti` (
  `id` int(11) NOT NULL,
  `utente_id` int(11) NOT NULL,
  `gioco_id` int(11) NOT NULL,
  `codice_attivazione` varchar(50) DEFAULT NULL,
  `data_acquisto` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `carrello`
--

CREATE TABLE `carrello` (
  `id` int(11) NOT NULL,
  `utente_id` int(11) NOT NULL,
  `gioco_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `giochi`
--

CREATE TABLE `giochi` (
  `id` int(11) NOT NULL,
  `titolo` varchar(255) NOT NULL,
  `descrizione` text DEFAULT NULL,
  `prezzo` decimal(10,2) NOT NULL,
  `sviluppatore` varchar(255) DEFAULT NULL,
  `data_rilascio` date DEFAULT NULL,
  `genere` varchar(100) DEFAULT NULL,
  `piattaforma` enum('PC','PlayStation','Xbox','Nintendo') NOT NULL,
  `immagine_url` varchar(500) DEFAULT NULL,
  `in_tendenza` tinyint(1) DEFAULT 0,
  `prossima_uscita` tinyint(1) DEFAULT 0,
  `installazione` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `giochi`
--

INSERT INTO `giochi` (`id`, `titolo`, `descrizione`, `prezzo`, `sviluppatore`, `data_rilascio`, `genere`, `piattaforma`, `immagine_url`, `in_tendenza`, `prossima_uscita`, `installazione`) VALUES
(1, 'EA Sports FC 26', 'EA Sports FC 26 è un gioco di calcio in cui puoi controllare squadre reali, giocare partite, tornei e modalità carriera, sia da solo che online con altri giocatori.', 49.99, 'EA Sports', '2025-09-26', 'Sport', 'PlayStation', 'fc-26.jpg', 1, 0, 'Seleziona l\'icona Playstation Store dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(2, 'Europa Universalis V', 'Quasi cinquecento anni di storia si sviluppano davanti ai tuoi occhi in Europa Universalis V, l\'ultima versione di uno dei più grandi giochi di strategia di tutti i tempi. Guida il destino di centinaia di nazioni e società in un mondo simulato di straordinaria profondità e complessità.\r\nEuropa Universalis V ha come base il concetto centrale del franchise: lo sviluppo e la progressione delle nazioni in un mondo storico ben studiato, con una diplomazia più dettagliata, un modello economico più sofisticato, un sistema militare rivisto e una maggiore profondità logistica che metterà alla prova anche i più esperti.', 64.80, 'Paradox Interactive', '2025-11-04', 'Strategia', 'PC', 'europa-universalis-v.jpg', 1, 0, 'Dopo l\'acquisto il gioco sarà disponibile direttamente nella libreria'),
(3, 'Split Fiction', 'Vivi momenti unici mentre ti immergi nei numerosi mondi di Split Fiction, l\'innovativo gioco d\'azione e avventura cooperativo creato dallo studio di It Takes Two, vincitore del premio Game of the Year 2021. Mio e Zoe sono scrittrici agli antipodi: una ama la fantascienza, l\'altra il fantasy. Dopo essere state collegate a un macchinario progettato per privarle delle loro idee creative, entrambe restano intrappolate nelle rispettive storie. Dovranno quindi fare affidamento l\'una sull\'altra per liberarsi senza perdere i propri ricordi, collaborando per apprendere nuove abilità e superare sfide sempre diverse mentre esplorano mondi immaginari in una sorprendente storia di amicizia.', 33.15, 'Hazelight Studios AB, Hazelight Studios', '2025-04-06', 'Avventura', 'Xbox', 'split-fiction.jpg', 1, 0, 'Seleziona l\'icona Microsoft Store dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(4, 'NORSE: Oath of Blood', 'Vesti i panni di Gunnar, un giovane guerriero costretto all’esilio dopo che il padre, Jarl Gripr, è stato ucciso dallo spietato Steinarr Far-Spear.Privato della casa distrutta e dei suoi compagni dispersi, guiderai Gunnar mentre ricostruisce il suo insediamento, stringe alleanze strategiche e guida il suo clan in una spietata ricerca di vendetta.Scendi in campo in epiche battaglie a turni, dove strategia, sinergie tra guerrieri e il dominio del territorio decidono il destino. ', 0.00, 'Arctic Hazard', '2026-03-03', 'RPG', 'PC', 'norse-oath-of-blood.jpg', 0, 1, 'Dopo l\'acquisto il gioco sarà disponibile direttamente nella libreria'),
(5, 'Nioh 3', 'Conquista il Crogiolo e diventa Shogun. \'Nioh 3\' è il nuovo gioco dell\'oscura serie Action-RPG a tema samurai. Un terreno aperto che metterà duramente alla prova le tue abilità. Il gioco presenta un terreno aperto carico di tutta la tensione tipica della serie \'Nioh\' in grado di far emergere le emozioni più recondite del tuo cuore. In questo tenebroso mondo dei samurai incontrerai formidabili yokai, esplorerai villaggi dall\'atmosfera sinistra ove alberga l\'oscurità e lotterai contro la nefasta presenza del \'Crogiolo\' ', 0.00, 'KOEI TECMO GAMES CO., LTD., Team NINJA', '2026-03-06', 'Azione', 'PlayStation', 'nioh-3.jpg', 0, 1, 'Seleziona l\'icona Playstation Store dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(6, 'Gear.Club Unlimited 3', 'Gear.Club Unlimited 3 è un gioco di corse automobilistiche in cui costruisci e guidi il tuo club di auto da sogno. Offre oltre 40 vetture ufficiali di marche prestigiose, più di 50 piste in ambientazioni ispirate alla Costa Mediterranea francese e al Giappone, e una modalità Storia immersiva incentrata sulla cultura automobilistica giapponese. Nel gioco puoi personalizzare dettagli estetici e prestazionali delle auto, affrontare gare classiche, sfidare il traffico in nuovi tracciati autostradali e sviluppare il tuo Gear.Club per dominare le competizioni.', 0.00, 'Eden Games', '2026-03-19', 'Racing', 'Nintendo', 'gear-club.jpg', 0, 1, 'Seleziona l\'icona Nintendo eShop dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(7, 'ELDEN RING NIGHTREIGN The Forsaken Hollows', 'Immergiti più a fondo nel mondo di ELDEN RING NIGHTREIGN con questa espansione. Il DLC The Forsaken Hollows include 2 Crepuscolari aggiuntivi, 2 boss per il Giorno 3, 1 Terra mutevole e tanto altro!ELDEN RING NIGHTREIGN The Forsaken Hollows include: Crepuscolari aggiuntivi, una Terra mutevole aggiuntiva, e tanto altro!', 11.69, 'FromSoftware, Inc', '2025-12-04', 'Azione', 'PC', 'elden-ring.jpg', 0, 0, 'Dopo l\'acquisto il gioco sarà disponibile nella libreria'),
(8, 'WWE 2K25', 'UN ROSTER STORICOWWE 2K25 ti offre una straordinaria selezione di Superstar, Leggende e Hall of Famer. Forte di 300 campioni di varie generazioni, il roster vanta Seth \"Freakin\" Rollins, The Undertaker, \"The American Nightmare\" Cody Rhodes, CM Punk, Jade Cargill e non solo. 2K SHOWCASE: LA DINASTIA DI THE BLOODLINELa nuova Showcase, presentata da “The Wiseman” Paul Heyman, rende omaggio a una delle più celebri dinastie del wrestling. Rivivi scontri leggendari o match da sogno tra The Bloodline e Superstar e Leggende del mondo WWE.', 35.32, 'Visual Concepts', '2025-07-23', 'Sport', 'Nintendo', 'wwe-2k25.jpg', 0, 0, 'Seleziona l\'icona Nintendo eShop dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(9, 'Super Mario Galaxy', 'Prossima fermata: il cosmo! Scopri la versione aggiornata di due intramontabili avventure galattiche con Super Mario Galaxy + Super Mario Galaxy 2 per Nintendo Switch! Avventurati nello spazio alla ricerca delle Superstelle, supera un universo di sfide e soprattutto... ferma Bowser! Lanciati nello spazio per un’avventura che sfida le leggi della gravità! Esplora una varietà di pianeti, recupera le Megastelle e viaggia per l’universo nell’Osservatorio Cometa in una missione per fermare Bowser prima che crei una galassia tutta sua.', 63.99, 'Nintendo', '2025-10-02', 'Avventura', 'Nintendo', 'super-mario-galaxy.jpg', 1, 0, 'Seleziona l\'icona Nintendo eShop dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(10, 'ARC Raiders', 'SACCHEGGIA, SOPRAVVIVI, PROSPERAARC Raiders si alterna tra la Superficie dominata da macchine letali e la vibrante società sotterranea di Speranza. Crea, ripara e potenzia il tuo equipaggiamento nella sicurezza della tua officina, prima di avventurarti in Superficie a saccheggiare i resti di un mondo devastato ma bellissimo. Gioca in solitaria o in squadre da un massimo di tre persone, affrontando la minaccia costante delle macchine ARC e le scelte imprevedibili degli altri sopravvissuti. Alla fine, solo tu decidi che tipo di Raider vuoi essere e fin dove sei disposto ad arrivare per prelevare.', 25.89, 'Embark Studios', '2025-10-30', 'Azione', 'PC', 'arc-raiders.jpg', 1, 0, 'SDopo l\'acquisto il gioco sarà disponibile direttamente nella libreria.'),
(11, 'Elden Ring', 'Shadow of the Erdtree è un\'espansione di ELDEN RING, il Gioco dell\'Anno 2022. Oscuro e intenso, garantisce ai giocatori la libertà di esplorare e vivere l\'avventura al loro ritmo.• Zone nuove e coinvolgenti, ricche di segreti Sin dalla sua creazione, il regno dell\'ombra è stato tenuto separato dall\'Interregno. Ora, alla ricerca di Miquella, i Senzaluce sono fra i primi a mettervi piede da tempo immemore. Attraversate nuove zone aperte per raggiungere nuovi dungeon del passato, pieni di pericoli e di misteri da scoprire.', 22.99, 'FromSoftware, Inc', '2024-06-21', 'Azione', 'PlayStation', 'elden-ring.jpg', 1, 0, 'Seleziona l\'icona Playstation Store dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(12, 'Animal Crossing', 'Animal Crossing: New Horizons per Nintendo Switch è un gioco di simulazione, principalmente single-player con alcuni elementi multi-player. È la quinta iterazione del gioco a presentare il volto familiare e amato di Tom Nook, questa volta su un’isola deserta. Come gli altri giochi di Animal Crossing, costruirai la tua casa, conoscerai e aiuterai i vicini dei tuoi amici animali a costruire una vera e propria comunità.', 10.23, 'Nintendo', '2026-01-15', 'Simulazione', 'Nintendo', 'animal-crossing.jpg', 1, 0, 'Seleziona l\'icona Nintendo eShop dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(13, 'F1 25', 'La storia è tua. Lascia il segno nel mondo delle corse in F1 25, il videogioco ufficiale del 2025 FIA Formula One World Championship. Carriera Scuderia 2.0: crea le tue storie in F1 prendendo le redini come Titolare di una scuderia di Formula 1. Grazie ai nuovi sistemi di gioco, puoi specializzarti nelle aree di gestione della scuderia che preferisci prima di metterti al volante con uno dei tuoi due piloti di F1 nei weekend di gara', 29.17, 'Codemasters', '2025-05-30', 'Sport', 'Xbox', 'f1-25.jpg', 1, 0, 'Seleziona l\'icona Microsoft Store dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(14, 'Invincible VS', 'Invincible VS è un brutale picchiaduro di supereroi 3 vs 3 ambientato nell\'universo di Invincible, in cui potrai combattere letali battaglie con una squadra di popolari personaggi in luoghi caratteristici. Sferra combo devastanti con rapidi attacchi e astute tattiche difensive per lasciare una scia di sangue e distruzione. Esegui spietate super mosse e mosse finali per ridurre gli avversari a un grumo di sangue. ', 0.00, 'Quarter Up', '2026-04-30', 'Azione, Avventura', 'Xbox', 'invincible-vs.jpg', 0, 1, 'Seleziona l\'icona Microsoft Store dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(15, 'Corsairs', 'Combatti per la supremazia sfoggiando i vessilli francesi, danesi, spagnoli, olandesi o inglesi. Pubblicato più di 20 anni fa, il primo Corsairs permetteva di giocare nei panni di un corsaro a servizio di Inghilterra, Francia o Paesi Bassi in cerca di fama e fortuna per la propria nazione.', 0.00, 'Fishing Cactus', '2026-05-18', 'Strategia', 'PC', 'corsairs.jpg', 0, 1, 'Dopo l\'acquisto il gioco sarà disponibile direttamente nella libreria.'),
(16, 'Masters of Albion', 'UN\'ESPERIENZA NARRATIVALa storia di Albion è contraddistinta da potere e conseguenze, una ricca e profonda narrativa ambientata in un mondo pieno di missioni e scelte morali. Fatti largo tra intrighi e complotti: re che vanno e vengono, lord che ti stringono la mano per poi pugnalarti alle spalle e abitanti che lavorano come cani e vengono trattati alla loro stregua. Grazie ai tuoi antichi poteri divini, dovrai affrontare un nemico che ormai non si vedeva da centinaia di anni. La magia sta tornando tra le colline e i saloni di Albion, minacciando di distruggere le fondamenta stesse della società. Svela il mistero dei maghi, sconfiggi il nemico che si nasconde nella notte e annulla un sortilegio che potrebbe ucciderci tutti.', 0.00, '22cans', '2026-04-22', 'Simulazione, Strategia', 'PC', 'masters-of-albion.jpg', 0, 1, 'Dopo l\'acquisto il gioco sarà disponibile direttamente nella libreria.'),
(17, 'LEGO Batman', 'LEGO Batman: L\'Eredità del Cavaliere Oscuro è un gioco di azione-avventura narrativo di TT Games, i creatori di LEGO Star Wars: la Saga di Skywalker. Vesti i panni di Bruce Wayne nel suo viaggio per diventare Batman, forgiando legami con alleati fidati mentre affronti i supercriminali DC più iconici e pericolosi di Gotham City.', 0.00, 'TT Games', '2026-05-29', 'Azione, Avventura', 'PC', 'lego-batman.jpg', 0, 1, 'Dopo l\'acquisto il gioco sarà disponibile direttamente nella libreria.'),
(18, 'Tides of Tomorrow', 'ElyndTi diamo il benvenuto su Elynd, un mondo che lotta per la sopravvivenza in seguito alla Grande inondazione. Preparati ad affrontare le numerose sfide di questo pianeta oceanico, mentre una plastificazione mortale minaccia tutti gli esseri viventi. Trova una cura, esplora piattaforme galleggianti oppure occupati delle minacce scoperte dalla comunità.', 0.00, 'Digixart', '2026-02-24', 'Avventura, Indies', 'PlayStation', 'tides-of-tomorrow.jpg', 0, 1, 'Seleziona l\'icona Playstation Store dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(19, 'THigh On Life 2', 'Ce l\'hai fatta. Hai eliminato un cartello intergalattico, salvato l\'umanità dall\'orlo dell\'estinzione e dato la caccia a pericolose taglie negli angoli più remoti della galassia, un\'attività che ti ha fruttato fortuna, fama e amore. Ma quando una misteriosa figura riemerge dal passato e mette una taglia sulla testa di tua sorella, la tua bella vita ricade nel caos. Hai le carte in regola per rischiare tutto e sventare una cospirazione intergalattica che minaccia ancora una volta la tua specie preferita (gli umani)?', 0.00, 'Squanch Games, Inc.', '2026-02-13', 'Azione, Avventura', 'Xbox', 'high-on-life-2.jpg', 0, 1, 'Seleziona l\'icona Microsoft Store dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(20, 'Resident Evil Requiem', 'Una nuova era del survival horror ha inizio con Resident Evil Requiem, il capitolo più recente e immersivo della leggendaria serie Resident Evil. Preparati a sfuggire alla morte in un\'esperienza terrificante con Grace Ashcroft, analista dell\'FBI, e tuffati nell’azione adrenalinica insieme al leggendario agente Leon S. Kennedy. Le loro strade e stili di gioco si intrecciano in un’esperienza emozionante e mozzafiato, che ti gelerà il sangue.', 0.00, 'CAPCOM Co., Ltd.', '2026-02-27', 'Azione, Avventura', 'Xbox', 'resident-evil-requiem.jpg', 0, 1, 'Seleziona l\'icona Microsoft Store dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(21, 'Monster Hunter Stories 3', 'Il terzo titolo della serie RPG Monster Hunter Stories è qui!\r\nRathalos gemelli, nati per un capriccio del destino. Monster Hunter Stories è una serie RPG ambientata nel mondo di Monster Hunter in cui puoi diventare un Rider, e allevare e stringere legami con i tuoi mostri preferiti. Azuria e Vermeil: due paesi su un sentiero di distruzione.\r\nQuando ogni speranza sembra perduta, viene ritrovato un uovo. Dentro c\'è un Rathalos, una specie ritenuta estinta. Dall\'uovo non nasce un unico Rathalos, ma due gemelli con il marchio Scaglieblu che richiama la disastrosa guerra civile di 200 anni prima.\r\n\r\nNumerose specie di mostri rischiano l\'estinzione, e il mondo naturale vacilla sull\'orlo della rovina. Nell\'oscurità di questi tempi bui, si riaccende la scintilla della guerra.\r\n\r\nDue paesi, due Rathalos.\r\n\r\nUn Rider e il suo fidato compagno Rathalos, sferzati dai venti del destino, in viaggio alla scoperta della verità.', 0.00, '	\r\nCAPCOM Co., Ltd.', '2026-03-13', 'Avventura, RPG', 'Nintendo', 'monster-hunter-stories-3.jpg', 0, 1, 'Seleziona l\'icona Nintendo eShop dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(22, '007 First Light', 'Dopo un gesto eroico, un giovane James Bond, membro dell\'aviazione della marina, riceve l\'offerta di unirsi al riformato Programma Doppio Zero. Ma quando la missione di arresto di un agente ribelle termina in tragedia, dovrà unire le forze con il suo riluttante mentore Greenway per portare a galla una grossa cospirazione e sventare un imminente colpo di stato. Scopri una nuova storia indipendente e reinventata sulle origini di James Bond e sugli eventi che hanno trasformato un audace giovane eroe nel miglior agente dell\'MI6. Cimentati in missioni in località mozzafiato, mettiti alla guida di veicoli iconici e lasciati travolgere da un\'avventura cinematografica a caccia di un agente ribelle che è sempre un passo avanti.', 0.00, 'Io-Interactive A/S, IO Interactive', '2026-05-27', 'Azione, Avventura', 'Nintendo', '007-first-light.jpg', 0, 1, 'Seleziona l\'icona Nintendo eShop dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(23, 'Minecraft', 'Crea, esplora, sopravvivi, ripeti. Minecraft: Java Edition e Bedrock Edition sono ora un unico pacchetto per Windows. Minecraft: Java & Bedrock Edition ti dà accesso a entrambi i giochi con un solo acquisto e un launcher unificato, semplificando al massimo il passaggio da un\'edizione all\'altra. Gioca in cross-play con qualsiasi giocatore di Minecraft semplicemente passando all\'edizione dei tuoi amici. Esplora mondi generati casualmente e realizza costruzioni di ogni tipo, dalla più semplice delle case al più maestoso dei castelli. Gioca in modalità Creativa con risorse illimitate o scava nelle profondità nel mondo in modalità Sopravvivenza, fabbricando armi e armature per respingere creature pericolose. Scala montagne scoscese, scopri caverne intricate e estrai grandi vene di minerali. Scopri biomi di caverne rigogliose e di pietra calcarea. Illumina il tuo mondo con le candele per mostrare l\'esperto speleologo e il maestro alpinista che sei!', 14.89, 'Mojang Studios ‪Double Eleven', '2011-11-19', 'Gestione, Multiplayer, RPG', 'PC', 'minecraft.jpg', 1, 0, 'Dopo l\'acquisto il gioco sarà disponibile direttamente nella libreria.'),
(24, 'Grand Theft Auto V', 'Ti diamo il benvenuto a Los Santos! Un giovane truffatore, un rapinatore di banche in pensione e uno spaventoso psicopatico si ritrovano nel mirino degli elementi più discutibili del mondo del crimine, del governo statunitense e dell\'industria dello spettacolo. Per sopravvivere dovranno mettere in atto una serie di audaci colpi in una città spietata dove non possono fidarsi di nessuno, men che meno gli uni degli altri.', 29.99, 'Rockstar Games', '2013-09-17', 'Azione, Avventura, Guida', 'PC', 'grand-theft-auto-v.jpg', 1, 0, 'Dopo l\'acquisto il gioco sarà disponibile direttamente nella libreria.'),
(25, 'Red Dead Redemption 2', 'America, 1899. Arthur Morgan e la banda di Van der Linde sono in fuga. Con gli agenti federali e i migliori cacciatori di teste del Paese alle calcagna, la banda deve attraversare il cuore dell\'America, rapinando, rubando e combattendo per sopravvivere. E quando dei confitti interni sempre più profondi minacciano di lacerare il gruppo, Arthur sarà costretto a scegliere tra seguire i propri ideali o restare fedele alla banda che l\'ha cresciuto. ', 15.99, 'Rockstar Games', '2018-10-26', 'Azione, Avventura', 'PC', 'red-dead-redemption-2.jpg', 1, 0, 'Dopo l\'acquisto il gioco sarà disponibile direttamente nella libreria.'),
(26, 'Fortnite', 'Fortnite è un videogioco online disponibile in tre modalità. inizialmente, la prima modalità di gioco (Fortnite: Save the World) è stata rilasciata e ha fatto pochi progressi. È stata rilasciata poi la modalità Battle Royale, facendo diventare Fortnite il gioco più popolare al mondo, vincendo premi ogni anno dalla sua uscita. In Battle Royale, puoi giocare da solo, in coppia o in una squadra di 3 o 4, e puoi anche vincere come squadra. Questa modalità di gioco è la più popolare. Le altre modalità sono Save the World e Creativa. In tutti i giochi, inizi da zero, senza nient\'altro che le basi assolute. Cerchi in giro e raccogli risorse dall\'aspetto probabile e ti imbatti in un piccone. Molto presto, usare il tuo piccone per puoi raccogliere legno, pietra e metallo, di solito abbattendo la struttura esistente che incontri, ma anche attaccando gli altri. Puoi quindi riutilizzare questi elementi per muri, pavimenti o scale, che risultano limitazioni, ma sono sufficienti per ottenere ciò di cui hai bisogno. Spesso, avrai solo bisogno di fare una serie di scale per accedere a una risorsa fuori mano, o un muro dietro cui nasconderti: non hai bisogno di costruire edifici enormi (ma puoi farlo se vuoi!)', 0.00, 'Epic Games', '2017-07-21', 'Azione', 'PlayStation', 'fortnite.jpg', 1, 0, 'Seleziona l\'icona Playstation Store dal menu principale e inserisci il codice ricevuto dopo l\'acquisto.'),
(27, 'Microsoft Flight Simulator', 'Esplora il mondo con la nostra più grande flotta aerea e porta la simulazione a nuove altezze mentre persegui la tua carriera nell\'aviazione in Microsoft Flight Simulator 2024. L\'edizione Standard include oltre 65 velivoli e 150 aeroporti realizzati appositamente. Inizia la tua Carriera nell\'aviazione ovunque vuoi nel mondo. Fai esperienza, crea una reputazione e ottieni qualifiche per ottenere l\'accesso ad autentiche attività nell\'aviazione, fra cui trasporto medico, trasporto merci per destinazioni remote, lotta agli incendi, ricerca perquisizione e soccorso e molte altre, fino a diventare un Pilota di aerei di linea. Parti per un\'avventura davvero globale con missioni praticamente illimitate in tutto il mondo.', 48.99, 'Asobo Studio', '2024-11-19', 'Simulazione', 'Xbox', 'microsoft-flight-simulator.jpg', 1, 0, 'Seleziona l\'icona Microsoft Store dal menu principale e inserisci il codice ricevuto dopo l\'acquisto. '),
(28, 'Leggende Pokémon', 'Il videogioco è ambientato a Luminopoli, nella regione di Kalos, che sta venendo ristrutturata dalla \"Q-asar Inc.\". Il giocatore si è appena trasferito e viene invitato da Ryon o Villy nel Team MZ per proteggere la città, facendosi strada nel torneo \"Royale Z-A\" e scoprire di più sul dispositivo che sta causando il fenomeno \"Ferox\" sui Pokémon selvaggi.', 23.99, 'Nintendo', '2025-10-16', 'Azione, Avventura, RPG', 'Nintendo', 'leggende-pokemon-z-a.jpg', 1, 0, 'Seleziona l\'icona Nintendo eShop dal menu principale e inserisci il codice ricevuto dopo l\'acquisto. '),
(29, 'Eastern Era', 'In questo gioco di simulazione manageriale a tema arti marziali, vesti i panni del leader di una setta. Come membro di una setta in declino, dovrai fuggire con i tuoi discepoli e sopravvivere in un mondo desolato, cercando di far rivivere la tua setta.\r\nAffronta le sfide poste dalla scarsità di cibo e dalle intemperie, dai la caccia a bestie pericolose, solleva lo spirito dei tuoi discepoli e costruisci manualmente tutte le strutture necessarie, mattone dopo mattone. Recluta talenti dalle terre selvagge o dalle città per farli diventare tuoi discepoli, allena le loro abilità marziali e ripristina gradualmente la forza della tua setta, ricostruendo il tuo esclusivo quartier generale.\r\nStringi alleanze o semina discordia tra altre sette, fomentando conflitti turbolenti in questo mondo dominato dalle arti marziali. Prendi il potere, sconfiggi formidabili sette secolari, conquista il JiangHu e diventa la nuova leggenda.', 0.00, 'FunYoo Games', '2026-03-28', 'Avventura, Indies, RPG, Simulazione, Strategia, RPG', 'PlayStation', 'eastern-era.jpg', 0, 1, 'Seleziona l\'icona Playstation Store dal menu principale e inserisci il codice ricevuto dopo l\'acquisto. ');

-- --------------------------------------------------------

--
-- Struttura della tabella `recensioni`
--

CREATE TABLE `recensioni` (
  `id` int(11) NOT NULL,
  `gioco_id` int(11) NOT NULL,
  `utente_id` int(11) NOT NULL,
  `contenuto` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`id`, `username`, `password`, `role`) VALUES
(7, 'admin', '$2b$10$xMmrKTnYyvLrbHdvfUMHN.Lv5Hxfk6AoO5AclSwEF4/PbpfBFQXL6', 'admin');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `acquisti`
--
ALTER TABLE `acquisti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `utente_id` (`utente_id`),
  ADD KEY `gioco_id` (`gioco_id`);

--
-- Indici per le tabelle `carrello`
--
ALTER TABLE `carrello`
  ADD PRIMARY KEY (`id`),
  ADD KEY `utente_id` (`utente_id`),
  ADD KEY `gioco_id` (`gioco_id`);

--
-- Indici per le tabelle `giochi`
--
ALTER TABLE `giochi`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `recensioni`
--
ALTER TABLE `recensioni`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gioco_id` (`gioco_id`),
  ADD KEY `utente_id` (`utente_id`);

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `acquisti`
--
ALTER TABLE `acquisti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT per la tabella `carrello`
--
ALTER TABLE `carrello`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT per la tabella `giochi`
--
ALTER TABLE `giochi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT per la tabella `recensioni`
--
ALTER TABLE `recensioni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT per la tabella `utenti`
--
ALTER TABLE `utenti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `acquisti`
--
ALTER TABLE `acquisti`
  ADD CONSTRAINT `acquisti_ibfk_1` FOREIGN KEY (`utente_id`) REFERENCES `utenti` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `acquisti_ibfk_2` FOREIGN KEY (`gioco_id`) REFERENCES `giochi` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `carrello`
--
ALTER TABLE `carrello`
  ADD CONSTRAINT `carrello_ibfk_1` FOREIGN KEY (`utente_id`) REFERENCES `utenti` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `carrello_ibfk_2` FOREIGN KEY (`gioco_id`) REFERENCES `giochi` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `recensioni`
--
ALTER TABLE `recensioni`
  ADD CONSTRAINT `recensioni_ibfk_1` FOREIGN KEY (`gioco_id`) REFERENCES `giochi` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `recensioni_ibfk_2` FOREIGN KEY (`utente_id`) REFERENCES `utenti` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
