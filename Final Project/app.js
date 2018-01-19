var express = require(`express`);
var app = express();
var bodyParser = require('body-parser');
var mysql = require('./dbcon.js');


// APP CONFIG
//app.set('port', 3000);
app.set('view engine', 'ejs');
app.use(express.static("public"));
app.use(bodyParser.urlencoded({extended: true}));
app.set('port', process.argv[2]);

// HOME
app.get('/', function(req, res, next){
	mysql.pool.query("SELECT * FROM game", function(err, rows, fields){
		if(err) throw err;
		res.render('home', {context: rows});
	});
});


// SEARCH
app.get('/search', function(req, res){
	var context = {};
	mysql.pool.query('SELECT * FROM game WHERE name LIKE "%'+req.query.search+'%"', function(err, rows, fields){
		if(err) throw err;
		var data = [];
		for(var i=0; i<rows.length;i++){
			data.push(rows[i].name);
		}
		console.log(req.query.search);
		res.render('search', {context: rows});
	});
});


//=========================GAME==================================//
app.get('/game', function(req, res){
// 		mysql.pool.query("SELECT g.name, g.releasedate, p.name AS pubName, r.score, ge.type, pl.name AS platName FROM game g INNER JOIN publisher p ON p.publisherID = g.publisherID INNER JOIN review r ON r.gameID = g.gameID INNER JOIN game_genre gg ON gg.gameID = g.gameID INNER JOIN genre ge ON ge.genreID = gg.genreID INNER JOIN game_platform gp ON gp.gameID = g.gameID INNER JOIN platform pl ON pl.platformID = gp.platformID ", function(err, rows, fields){
// 			if(err) throw err;
// 			res.render('game', {context: rows});
// 	});
// });
	  mysql.pool.query("SELECT * FROM game", function(err, rows, fields){
	 		if(err) throw err;
	 	mysql.pool.query("SELECT * FROM game g INNER JOIN publisher p ON p.publisherID = g.publisherID", 
	 		function(err, pub, fields){
	 		if(err) throw err;
	 	mysql.pool.query("SELECT * FROM review r INNER JOIN game g ON g.gameID = r.gameID", 
	 		function(err, scor, fields){
	 		if(err) throw err;
	 	mysql.pool.query("SELECT type FROM genre g INNER JOIN game_genre gg ON gg.genreID = g.genreID ORDER BY gameID ASC",
	 		function(err, genr, fields){
	 		if(err) throw err;
	 	mysql.pool.query("SELECT name FROM platform p INNER JOIN game_platform gp ON gp.platformID = p.platformID ORDER BY gameID ASC",
	 		function(err, plat, fields){
			if(err) throw err;
			res.render('game', {context: rows, publisher: pub, gscore: scor, genre: genr, platform: plat});
	 		});
	 		});
	 		});
	 	});
	});
});

// ADD GAME
app.post('/addGame', function(req, res, next){
	mysql.pool.query("SET FOREIGN_KEY_CHECKS=0", function(err, result){
			if(err) throw err;
	mysql.pool.query("INSERT INTO game (`name`, `releasedate`, `publisherID`) VALUES (?, ?, ?)", 
		[req.body.name, req.body.releasedate, req.body.publisherID], function(err, result){
			if(err) throw err;
    mysql.pool.query("INSERT INTO game_genre (`genreID`, `gameID`) VALUES (?, ?)", 
				[req.body.genreID, req.body.gameID], function(err, result){
			if(err) throw err;
	mysql.pool.query("INSERT INTO game_platform (`platformID`, `gameID`) VALUES (?, ?)", 
				[req.body.platformID, req.body.gameID], function(err, result){
			if(err) throw err;
			return res.redirect('/game');
			});
			});
		});
	});
});

// NEW GAME
app.get('/newGame', function(req, res, next){
	mysql.pool.query("SELECT gameID FROM game", function(err, rows, fields){
		if(err) throw err;
	mysql.pool.query("SELECT * FROM publisher",	function(err, pub, fields){
			if(err) throw err;
	mysql.pool.query("SELECT * FROM genre", function(err, genr, fields){
			if(err) throw err;
	mysql.pool.query("SELECT * FROM platform", function(err, plat, fields){
			if(err) throw err;
	mysql.pool.query("SELECT `AUTO_INCREMENT` FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'cs340_phankhoa' AND TABLE_NAME = 'game'", function(err, lgID, fields){
			if(err) throw err;
			res.render('newGame', {context: rows, publisher: pub, genre: genr, gID: lgID, platform: plat});
			});
			});
			});
		});
	});
});

// EDIT GAME
app.get('/editGame/:gameID', function(req, res, next){
	mysql.pool.query("SELECT * FROM game WHERE gameID = ' "+req.params.gameID+"'", function(err, rows, fields){
		if(err) throw err;
		mysql.pool.query("SELECT * FROM publisher ", 
			function(err, pub, fields){
			if(err) throw err;
		mysql.pool.query("SELECT type FROM genre ", 
			function(err, genr, fields){
			if(err) throw err;
		mysql.pool.query("SELECT name FROM platform ", 
			function(err, plat, fields){
			if(err) throw err;
			res.render('editGame', {context: rows, publisher: pub, genre: genr, platform: plat});
		});
		});
	});
	});
});


// UPDATE GAME 

app.post('/updateGame/:gameID', function(req, res, next){
	mysql.pool.query("UPDATE game SET name=?, releasedate=?, publisherID=? WHERE gameID=' "+req.params.gameID+" '", 
	[req.body.name, req.body.releasedate, req.body.publisherID], function(err, results){
		if(err) throw err;
			return res.redirect('/game');
	});
});

// DELETE GAME
app.get('/deleteGame/:gameID', function(req, res, next){
		mysql.pool.query("SET FOREIGN_KEY_CHECKS = '0'")
    	mysql.pool.query("DELETE FROM game_genre WHERE gameID=' "+req.params.gameID+" ' AND genreID ", [req.query.deleteID], function(err, results){
		if(err) throw err;
		mysql.pool.query("DELETE FROM game_platform WHERE gameID=' "+req.params.gameID+" ' AND platformID", [req.query.deleteID], function(err, results){
		if(err) throw err;
		mysql.pool.query("DELETE FROM game WHERE gameID=' "+req.params.gameID+" '", [req.query.deleteID], function(err, results){
		if(err) throw err;
		mysql.pool.query("DELETE FROM review WHERE gameID=' "+req.params.gameID+" '", [req.query.deleteID], function(err, results){
		if(err) throw err;
		return res.redirect('/game');
		});
		});
	});
	});
});

//=========================GAME==================================//



//=========================GENRE==================================//
app.get('/genre', function(req, res, next){
	mysql.pool.query("SELECT * FROM genre", function(err, rows, fields){
		if(err) throw err;
		res.render('genre', {context: rows});
	});
});

// ADD GENRE
app.post('/addGenre', function(req, res, next){
	mysql.pool.query("INSERT INTO genre (`type`, `description`) VALUES (?, ?)", 
		[req.body.type, req.body.description], function(err, result){
			if(err) throw err;
		return res.redirect('/genre');
	});
});

// NEW GENRE
app.get('/newGenre', function(req, res, next){
	mysql.pool.query("SELECT * FROM genre", function(err, rows, fields){
		if(err) throw err;
		res.render('newGenre', {context: rows});
	});
});

// EDIT GENRE
app.get('/editGenre/:genreID', function(req, res, next){
	mysql.pool.query("SELECT * FROM genre WHERE genreID = ' "+req.params.genreID+"'", function(err, rows, fields){
		if(err) throw err;
		res.render('editGenre', {context: rows});
	});
});


// UPDATE GENRE 

app.post('/updateGenre/:genreID', function(req, res, next){
	mysql.pool.query("UPDATE genre SET type=?, description=? WHERE genreID=' "+req.params.genreID+" '", 
	[req.body.type, req.body.description], function(err, results){
		if(err) throw err;
			return res.redirect('/genre');
	});
});

// DELETE GENRE
app.get('/deleteGenre/:genreID', function(req, res, next){
	mysql.pool.query("DELETE FROM genre WHERE genreID=' "+req.params.genreID+" '", [req.query.deleteID], function(err, results){
		if(err) throw err;
		return res.redirect('/genre');
	});
});


//=========================GENRE==================================//



//=========================REVIEWS==================================//
app.get('/review', function(req, res, next){
	mysql.pool.query("SELECT * FROM review", function(err, rows, fields){
		if(err) throw err;
		mysql.pool.query("SELECT name FROM review r INNER JOIN game g ON g.gameID = r.gameID", 
			function(err, gam, fields){
			if(err) throw err;
			res.render('review', {context: rows, gameList: gam});
		});
	});
});

// ADD REVIEW
app.post('/addReview', function(req, res, next){
	mysql.pool.query("INSERT INTO review (`gameID`, `score`, `description`) VALUES (?, ?, ?)", 
		[req.body.gameID, req.body.score, req.body.description], function(err, result){
			if(err) throw err;
    		return res.redirect('/review');
	});
});

// NEW REVIEW
app.get('/newReview', function(req, res, next){
	mysql.pool.query("SELECT * FROM review", function(err, rows, fields){
		if(err) throw err;
		mysql.pool.query("SELECT * FROM game", 
			function(err, gam, fields){
			if(err) throw err;
			res.render('newReview', {context: rows, gameList: gam});
		});
	});
});

// EDIT REVIEW
app.get('/editReview/:reviewID', function(req, res, next){
	mysql.pool.query("SELECT * FROM review WHERE reviewID = ' "+req.params.reviewID+"'", function(err, rows, fields){
		if(err) throw err;
		mysql.pool.query("SELECT * FROM game g INNER JOIN review r ON r.gameID = g.gameID WHERE r.gameID = g.gameID", function(err, gam, fields){
		if(err) throw err;
		res.render('editReview', { context: rows, game: gam });
		});
	});
});


// UPDATE REVIEW 
app.post('/updateReview/:reviewID', function(req, res, next){
	mysql.pool.query("UPDATE review SET score=?, description=? WHERE reviewID=' "+req.params.reviewID+" '", 
	[req.body.score, req.body.description], function(err, results){
		if(err) throw err;
		return res.redirect('/review');
	});
});


// DELETE REVIEW
app.get('/deleteReview/:reviewID', function(req, res, next){
	mysql.pool.query("DELETE FROM review WHERE reviewID=' "+req.params.reviewID+" '", [req.query.deleteID], function(err, results){
		if(err) throw err;

		return res.redirect('/review');
	});
});


//=========================REVIEWS==================================//



//========================PUBLISHERS==================================//
app.get('/publisher', function(req, res, next){
	mysql.pool.query("SELECT * FROM publisher", function(err, rows, fields){
		if(err) throw err;
		res.render('publisher', {context: rows});
	});
});
// ADD PUBLISHER
app.post('/addPublisher', function(req, res, next){
	mysql.pool.query("INSERT INTO publisher (`name`, `location`, `yearEstab`) VALUES (?, ?, ?)", 
		[req.body.name, req.body.location, req.body.yearEstab], function(err, result){
		if(err) throw err;
		return res.redirect('/publisher');
	});
});

// NEW PUBLISHER
app.get('/newPublisher', function(req, res, next){
	mysql.pool.query("SELECT * FROM publisher", function(err, rows, fields){
		if(err) throw err;
		context.results = JSON.stringify(rows);
		res.render('newPublisher', {context: rows});
	});
});

// EDIT PUBLISHER
app.get('/editPublisher/:publisherID', function(req, res, next){
	mysql.pool.query("SELECT * FROM publisher WHERE publisherID = ' "+req.params.publisherID+"'", function(err, rows, fields){
		if(err) throw err;
		res.render('editPublisher', {context: rows});
	});
});


// UPDATE PUBLISHER 
app.post('/updatePublisher/:publisherID', function(req, res, next){
	mysql.pool.query("UPDATE publisher SET name=?, location=?, yearEstab=? WHERE publisherID=' "+req.params.publisherID+" '", 
	[req.body.name, req.body.location, req.body.yearEstab], function(err, results){
		if(err) throw err;
		return res.redirect('/publisher');
	});
});

// DELETE PUBLISHER
app.get('/deletePublisher/:publisherID', function(req, res, next){
	mysql.pool.query("DELETE FROM publisher WHERE publisherID=' "+req.params.publisherID+" '", [req.query.deleteID], function(err, results){
		if(err) throw err;
		return res.redirect('/publisher');
	});
});

//========================PUBLISHERS==============================



//========================PLATFORMS==================================//
app.get('/platform', function(req, res, next){
	mysql.pool.query("SELECT * FROM platform", function(err, rows, fields){
		if(err) throw err;
		res.render('platform', {context: rows});
	});
});

// ADD PLATFORMS
app.post('/addPlatform', function(req, res, next){
	mysql.pool.query("INSERT INTO platform (`make`, `name`, `year`) VALUES (?, ?, ?)", 
		[req.body.make, req.body.name, req.body.year], function(err, result){
		if(err) throw err;
		return res.redirect('/platform');
	});
});

// NEW PLATFORMS
app.get('/newPlatform', function(req, res, next){
	mysql.pool.query("SELECT * FROM platform", function(err, rows, fields){
		if(err) throw err;
		res.render('newPlatform', {context: rows});
	});
});

// EDIT PLATFORMS
app.get('/editPlatform/:platformID', function(req, res, next){
	mysql.pool.query("SELECT * FROM platform WHERE platformID = ' "+req.params.platformID+"'", function(err, rows, fields){
		if(err) throw err;
		res.render('editPlatform', {context: rows});
	});
});


// UPDATE PLATFORMS /

app.post('/updatePlatform/:platformID', function(req, res, next){
	mysql.pool.query("UPDATE platform SET make=?, name=?, year=? WHERE platformID=' "+req.params.platformID+" '", 
	[req.body.make, req.body.name, req.body.year], function(err, results){
		if(err) throw err;
		return res.redirect('/platform');
	});
});

// DELETE PLATFORMS
app.get('/deletePlatform/:platformID', function(req, res, next){
	mysql.pool.query("DELETE FROM platform WHERE platformID=' "+req.params.platformID+" '", [req.query.deleteID], function(err, results){
		if(err) throw err;
		return res.redirect('/platform');
	});
});

//========================PLATFORMS==================================//

app.use(function(err, req, res, next){
  console.error(err.stack);
  res.status(500);
  res.render('500');
});

app.listen(app.get('port'), function(){
  console.log('Express started on flip3.engr.oregonstate.edu:' + app.get('port') + '; press Ctrl-C to terminate.');
});