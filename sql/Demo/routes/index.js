
/*
 * GET home page.
 */

var services = {};

module.exports = {
    index : _index,
    user : _user,
    editor : _editor,
    post : _post,
    use : function (svcName,svcObj) {
        services[svcName] = svcObj;
    }
};

function _index(req, res) {
    res.render('index', { title : 'SQL : From High Orbit'});
}

function _editor(req, res) {
    res.render('editor', { title : 'Online Editor' });
}

function _post(req, res) {

    // Query the db
    services.dbContext.query(

        // The sql from the editor
        req.body.sql,

        // On success
        function (rows,fields,close) {
            var results = Array();
            for(var i = 0; i < rows.length; i++) {
                var result = {};
                for(var f in fields) {
                    var fieldName = fields[f].name;
                    result[fieldName] = rows[i][fieldName];
                }
                results.push(result);
            }
            res.send(results);
            close();
        },

        // On Error
        function (err){
            console.log(err.code);
            res.send(err.code,  500);
        }
    );
}

function _user(req,res) {

    var user = req.body.user;
    var pass = req.body.pass;
    var query = "SELECT DisplayName FROM Users WHERE Username = '" + user + "' AND Password = '" + pass + "';";

    services.dbContext.query(
        query,

        // On Success
        function (rows, fields, close) {
            console.log(fields);

            if(rows.length > 0)
                res.render("user", { user : rows[0].DisplayName, title : "Welcome Back!" });
            else
                res.send('You are not authorized!', 401);
            close();
        },

        // On Error
        function (err) {
            res.send(err.code, 500);
        }
    );
}