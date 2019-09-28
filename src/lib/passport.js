const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const pool = require('../database');
const helpers = require('../lib/helpers');

passport.use('local.signin',new LocalStrategy({
    usernameField:'username',
    passwordField: 'password',
    passReqToCallback: true
}, async (req, username, password, done) =>{
    console.log(req.body);
    const rows = await pool.query('SELECT * FROM usuario WHERE username = ?', [username]);
    if(rows.length > 0){
        const user = rows[0];
        const validPassword = await helpers.matchPassword(password, user.password);
        if(validPassword)
        {
            done(null, user,req.flash('success','Welcome ' + user.username));
        } else{
            done(null, false, req.flash('message','Error Password'));
        }
    } else{
        return done(null, false, req.flash('message','The Username does not exist'));
    }

}));

passport.use('local.signup', new LocalStrategy({
    usernameField:'username',
    passwordField: 'password',
    passReqToCallback: true
}, async (req,username,password,done)=>{
    const  { email } = req.body;
    const  { fullname } = req.body;
    const  { phone } = req.body;
    const newUser = {
        username,
        fullname,
        password,
        phone,
        email
    }
    newUser.password = await helpers.encryptPassword(password);
    const compara = await pool.query('select * from usuario where username = ?', [username]);
    if(compara.length == 0){
        const result = await pool.query('INSERT INTO usuario SET ?', [newUser]);
        newUser.id_usuario = result.insertId;
        return done(null,newUser);
    }
    else{
        console.log(compara);
        return done(null, false, req.flash('message','El nombre del usuario ya existe.'));
    }

}));

passport.serializeUser((user,done)=>{
     done(null,user.id_usuario)
});
passport.deserializeUser(async(id_usuario, done) =>{
    const rows = await pool.query('SELECT * FROM usuario WHERE id_usuario = ?', [id_usuario]);
    done(null, rows[0]);
});