const { format } = require('timeago.js');

const helpers = {};

helpers.timeago = (timeagotamp)=>{
    return format(timeagotamp);
};

module.exports = helpers;