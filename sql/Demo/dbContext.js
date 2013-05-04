/**
 * Created with JetBrains WebStorm.
 * User: en0
 * Date: 4/20/13
 * Time: 4:54 PM
 * To change this template use File | Settings | File Templates.
 */
var mysql = require('mysql');

var connectionDetails;

module.exports = function (details) {
    connectionDetails = details;
    return { query: _query };
}

function _query(cmd, onComplete, onError) {
    var connection = mysql.createConnection(connectionDetails);
    connection.query(cmd, function(err, rows, fields) {
        if(err) {
            onError(err);
            connection.end();
        } else {
            console.log('Connetion Open');
            onComplete(rows, fields, function() {
                console.log('Connection Closed');
                connection.end();
            });
        }
    });
}