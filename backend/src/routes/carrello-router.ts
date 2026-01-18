import { Router } from 'express'
import * as carrelloController from '../controllers/carrello-controller'

const router: Router = Router()

router.post('/api/carrello', carrelloController.addToCarrello)
router.get('/api/carrello', carrelloController.getCarrello)
router.delete('/api/carrello/:gioco_id', carrelloController.removeFromCarrello)

export default router
