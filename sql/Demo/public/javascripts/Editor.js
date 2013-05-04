/**
 * Created with JetBrains WebStorm.
 * User: en0
 * Date: 4/20/13
 * Time: 8:59 AM
 * To change this template use File | Settings | File Templates.
 */

var editor;

$(document).ready(function () {
    editor = ace.edit("editor");
    editor.setTheme("ace/theme/monokai");
    editor.getSession().setMode("ace/mode/sql");

    $('a[data-load]').click(function () {
        setStatus('Loading...','working');
        $.ajax({
            url: $(this).attr('data-load'),
            type: 'GET',
            success: function (data) {
                editor.setValue(data);
                $('#result').html('');
                setStatus('Ready','ready');
            },
            error: function (obj,status,errorMessage) {
                setStatus(errorMessage, 'error');
            }
        })
    });

    $('#aExec').click(execSql);

    $('#editor').bind('keyup', function(e) {
        if(e.which == 88 && e.ctrlKey)
            execSql();
    });

    $('#result').dblclick(function () {
        $(this).toggleClass('full');
    })

    setStatus('Ready', 'ready');
});

function execSql() {
    $.ajax({
        url: '/editor',
        type: 'POST',
        data: { sql : editor.getValue()},
        error: function (jx,statusText, error) {
            setStatus('Failed!','error');
            $('#result').html($('<p>' + error + '</p>'));
        },
        success: function (data) {
            setStatus('Complete','ready');
            render(data);
        }
    });
}

function setStatus(msg, cls) {
    var status = $('#status');
    status.removeClass();
    status.addClass(cls);
    status.text('Status: ' + msg);
}

function render(data) {
    var results = $('#result');
    var table = $('<table></table>');

    var headerRow = $('<tr></tr>');
    for(var f in data[0]) {
        headerRow.append('<th>' + f + '</th>');
    }

    table.append(headerRow);

    $.each(data, function (i, row) {
        var tableRow = $("<tr></tr>");
        for(var f in row){
            tableRow.append('<td>' + row[f] + '</td>');
        }
        if( (i%2) != 0) {
            tableRow.addClass('alt');
        }

        table.append(tableRow);
    });

    results.html(table);
}
