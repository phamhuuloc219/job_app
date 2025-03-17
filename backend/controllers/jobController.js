const Job = require('../models/Jobs');

module.exports = {
    createJob: async(req, res) => {
        const newJob = new Job(req.body);
        try {
            await newJob.save();
            res.status(201).json({status: true, message:"Job created successfully"});
        }
        catch (error) {
            res.status(500).json({ message: error.message });
        }
    },
    updateJob: async (req, res) => {
        const jobId = req.params.id;
        const updated = req.body;
        try {
            const updatedJob = await Job.findByIdAndUpdate(jobId, updated, { new: true });
            if (!updatedJob) {
                return res.status(404).json({status:false, message: "Job not found" });
            }

            res.status(200).json({ status: true, message: "Job updated successfully", updatedJob });
        }
        catch (error) {
            res.status(500).json({ message: error.message });
        }
    },

    deleteJob: async (req, res) => {
        const jobId = req.params.id;
        try {
            const deletedJob = await Job.findByIdAndDelete(jobId);
            if (!deletedJob) {
                return res.status(404).json({status: false, message: "Job not found" });
            }

            res.status(200).json({ status: true, message: "Job deleted successfully" });
        }
        catch (error) {
            res.status(500).json({ message: error.message });
        }
    },

    getJob: async (req, res) => {
        const jobId = req.params.id;
        try {
            const job = await Job.findById({_id: jobId}, {createdAt: 0, updatedAt: 0, __V: 0});
            if (!job) {
                return res.status(404).json({status: false, message: "Job not found" });
            }

            res.status(200).json(job);
        }
        catch (error) {
            res.status(500).json({ message: error.message });
        }
    },

    getAllJobs: async (req, res) => {
        const recent = req.query.new;

        try {
            let jobs;
            if (recent) {
                jobs = await Job.find({}, {createdAt: 0, updatedAt: 0, __V: 0}).sort({createdAt: -1}).limit(2);
            }else{
                jobs = await Job.find({}, {createdAt: 0, updatedAt: 0, __V: 0});
            }
            res.status(200).json(jobs);
        }
        catch (error) {
            res.status(500).json({ message: error.message });
        }
    },

    searchJobs: async (req, res) => {
        const searchQuery = req.query.search;
        try {
            const results = await Job.aggregate([
                {
                  $search: {
                    index: "jobsearch",
                    text: {
                      query: req.params.key,
                      path: {
                        wildcard: "*"
                      }
                    }
                  }
                }
              ])
              res.status(200).json(results);
        }
        catch (error) {
            res.status(500).json({ message: error.message });
        }
    },
}