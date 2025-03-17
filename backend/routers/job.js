const router = require('express').Router();
const jobController = require('../controllers/jobController');

router.post('/', jobController.createJob);

router.get('/:id', jobController.getJob);

router.put('/:id', jobController.updateJob);

router.delete('/:id', jobController.deleteJob);

router.get('/', jobController.getAllJobs);

module.exports = router;