/**, * Module dependencies., */
var express = require('express'),
    routes = require('./routes'),
    http = require('http'),
    path = require('path'),
    _db = require('./dbContext');

var app = express();

// all environments,app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));

// Setup database connection.
//routes.use('dbContext', _db('localhost', 'webEditor', 'iue0W377frjxj9o7IqdtEypI7gzNZ2kx'));

routes.use('dbContext', _db({
    host: 'localhost',
    user: 'webEditor',
    password: 'iue0W377frjxj9o7IqdtEypI7gzNZ2kx',
    database: 'sgctf_sqldemo'
}));

// development only
if ('development' == app.get('env')) {
    app.use(express.errorHandler());
}

app.get('/', routes.index);
app.post('/user', routes.user);
app.get('/editor', routes.editor);
app.post('/editor', routes.post);

http.createServer(app).listen(3000, function(){
    console.log('Express server listening on port ' + 3000);
});
