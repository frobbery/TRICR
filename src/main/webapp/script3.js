$(function () {

    var x, y, r, scrolled, pointStorage;

    $(window).scroll(function() {
        scrolled = $(window).scrollTop();
    });

    function isNumber(n) {
        return !isNaN(parseFloat(n)) && isFinite(n);
    }

    function inRange(n, l, r) {
        return isNumber(n) && parseFloat(n) >= parseFloat(l) && parseFloat(n) <= parseFloat(r);
    }

    function checkX() {
        x = $('input[name="x"]:checked').val();
        return isNumber(x);
    }

    function checkY() {
        y = $('input[name="y"]').val();
        return inRange(y, -5, 3);
    }

    function checkR() {
        r = $('input[name="r"]').val();
        return inRange(r, 1, 4);
    }

    function checkArguments() {
        return checkX() && checkY() && checkR();
    }

    function printError(string) {
        $("#error").html('<b>' + string + '</b>');
        document.getElementById('error').style.display = 'table-row';
    }

    $("#check").on('submit', function(e) {
        e.preventDefault();
        if (checkArguments()) {
            sendAjax();
        }
        else {
            $('#check').trigger('reset');
            printError("Поля заполнены некорректно");
        }
    });

    $("#check_click").on('click', function(e) {
        if (checkR()) {
            let border = this.getBoundingClientRect();
            let x0 = border.right - border.width / 2;
            let y0 = border.top + border.height / 2;
            let scale = 150 / r;
            x = (e.clientX - x0) / scale;
            y = (y0 - e.clientY) / scale;
            sendAjax();
        }
        else {
            printError("Введите радиус");
        }
    });

    function sendAjax() {
        $.ajax(
            {type:"POST", url:"controller", data: {"x": x, "y": y, "r": r},
                success: function(data) {
                    printError("");
                    //sessionStorage.setItem(sessionStorage.length, data);
                    result(data);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    alert(thrownError);
                    see()
                },
                datatype:"json"}
        );
    }

    function see() {
        printError(x + ' ' + y + ' ' + r);
    }
    function result(data) {
        let d = JSON.parse(data);
        drawPoint(d.x, d.y, d.r);
        let newRow = '<tr>';
        newRow += '</tr><td style="border: 1px solid darkblue;">' + d.x + '</td>';
        newRow += '<td style="text-align:center;border: 1px solid darkblue;">' + d.y + '</td>';
        newRow += '<td style="text-align:center;border: 1px solid darkblue;">' + d.r + '</td>';
        newRow += '<td style="text-align:center;border: 1px solid darkblue;">' + (d.inn ? "Да" : "Нет") + '</td>';
        newRow += '<td style="text-align:center;border: 1px solid darkblue;">' + d.time + '</td>';
        newRow += '<td style="text-align:center;border: 1px solid darkblue;">' + d.runtime + 'ms</td>';
        $('#result tbody').prepend(newRow);
    }

    function drawPoint(x, y, r) {
        let border = document.getElementById("check_click").getBoundingClientRect();
        let x0 = border.right - border.width / 2;
        let y0 = border.top + border.height / 2;
        if (scrolled) {
            y0 += scrolled;
        }
        let scale = 150 / r;
        let pixelX = x * scale + x0
        let pixelY = -y * scale + y0;

        if (pixelX > border.right || pixelX < border.left
        || pixelY > border.bottom + scrolled || pixelY < border.top + scrolled) {
            printError(pixelY + " " + border.bottom + " " + scrolled);
            return;
        }
        let circle = '<div class="circle" style="position: absolute;top:' + pixelY
            + 'px;left:' + pixelX + 'px;height:5px;width:5px;background-color:blue;border-radius:50%;"></div>'

        $('#circle').after(circle);
    }

    function drawResults() {
        for (let i = 0; i < sessionStorage.length; i++) {
            let s = "" + i;
            result(sessionStorage.getItem(s));
        }
    }

    //drawResults();
});