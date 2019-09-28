const express = require('express');
const router = express.Router();

const pool = require('../database');

router.get('/', async (req,res)=>{
    const terminals = await pool.query("SELECT * FROM terminal");
    res.render('terminals/index',{terminals});
})

module.exports = router;