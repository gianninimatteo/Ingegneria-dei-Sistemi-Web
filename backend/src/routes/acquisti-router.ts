import { Router } from 'express'
import * as acquistiController from '../controllers/acquisti-controller'

const router: Router = Router()

router.post('/api/acquisti', acquistiController.processaAcquisto)
router.get('/api/libreria', acquistiController.getLibreria)
router.get('/api/acquisti/verifica/:giocoId', acquistiController.verificaAcquisto)

export default router
