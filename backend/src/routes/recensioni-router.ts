import { Router } from 'express'
import * as recensioniController from '../controllers/recensioni-controller'

const router: Router = Router()

router.post('/api/recensioni', recensioniController.createRecensione)
router.get('/api/recensioni/:gioco_id', recensioniController.getRecensioniByGioco)
router.delete('/api/recensioni/:id', recensioniController.deleteRecensione)

export default router
