import {Router} from "express"

import * as giochiController from "../controllers/giochi-controller"

const router: Router = Router();
   
router.get('/api/tendenze', giochiController.tendenze);
router.get('/api/prossimeUscite', giochiController.prossimeUscite);
router.get('/api/console/:console', giochiController.consoleSpecifica);
router.get('/api/giochi/:id', giochiController.dettaglioGioco);

export default router