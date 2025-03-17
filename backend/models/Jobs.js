const mongoose = require('mongoose');

const JobSchema = new mongoose.Schema({
    title: {type: String, required: true},
    location: {type: String, required: true},
    description: {type: String, required: true},
    agentName: {type: String, required: true},
    salary: {type: String, required: true},
    period: {type: String, required: true},
    contract: {type: String, required: true},
    hiring: {type: Boolean, required: true, default: true},
    requirement: {type: Array, required: true},
    imageUrl: {type: String, required: true},
    agentId: {type: String, required: true},
}, {timestamps: true});

module.exports = mongoose.model('Job', JobSchema);