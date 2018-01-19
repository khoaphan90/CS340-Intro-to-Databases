var mysql = require('mysql');
var pool = mysql.createPool({
	connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_phankhoa',
  password        : '6251',
  database        : 'cs340_phankhoa'
});
module.exports.pool = pool;
