<%@ page import="java.util.Enumeration" %>
<%@ page import="com.example.tricr.Row" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset=utf-8">
    <title>Lab 1</title>
    <style>
        body {
            background-image: linear-gradient(to right, lightblue 40%, white 30%, lightblue 100%);
            font-family: 'Times New Roman', sans-serif;
        }
        #circle {
            height: 1px;
            width: 1px;
            background-color: blue;
            border-color: blue;
            border-radius: 50%;
        }
        #result {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid darkblue;
        }
        #result > tr > td, th {
            border: 1px solid darkblue;
        }
        table, tr, th, td {
            text-align: center;
            margin: auto;
        }
        ::placeholder {
            color: lightgray;
        }
        td > h2, h3, h1 {
            color: darkblue;
            line-height: 0.25;
            margin-bottom: -3px;
        }
        .last {
            margin-bottom:1px;
        }
        #error {
            width: 100%;
        }
        #check_click {
            background-size: 400px 400px;
            width: 400px;
            height: 400px;
            border: 2px solid lightgray;
            border-radius: 10px;
            margin-left: auto;
            margin-right: auto;
            background-color: white;
        }
        #button_submit {
            display: inline-block;
            color: white;
            padding: 15px 15px;
            border: 0px;
            border-radius: 10px;
            letter-spacing: 2px;
            background-image: linear-gradient(to right, blue 0%, darkblue 51%, blue 100%);
            background-size: 200% auto;
        }
        table.header_table {
            border: 5px lightblue;
            border-style: dashed double none;
            width: 100%;
            background-image: linear-gradient(to right, lightblue 0%, white 51%, lightblue 100%)
        }
    </style>
</head>
<body>
<table class="header_table">
    <tr>
        <td><h1>Лабораторная работа №2</h1></td>
    </tr>
    <tr>
        <td><h2>Вариант №7169</h2></td>
    </tr>
    <tr>
        <td><h3>Пузина Юлия Павловна</h3></td>
    </tr>
    <tr>
        <td><h3 class="last">Группа З3202</h3></td>
    </tr>
</table>
<table width="100%">
    <tr>
        <td width="500" valign="top">
            <div id="check_click">
                <svg width="400" height="400" viewBox="0 0 400 400" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <polygon points="200,200 200,50 350,200" fill="#1E90FF"></polygon>
                    <polygon points="200,200 200,275 350,275 350,200" fill="#1E90FF"></polygon>
                    <mask id="quarter" maskUnits="userSpaceOnUse">
                        <circle cx="200" cy="200" r="75" fill="#FFFFFF"></circle>
                    </mask>
                    <g mask="url(#quarter)">
                        <rect x="0" y="0" width="200" height="200" fill="#1E90FF"></rect>
                    </g>

                    <line x1="200" y1="15" x2="200" y2="385" stroke-width=1 stroke="black"></line>
                    <line x1="200" y1="15" x2="197" y2="18" stroke-width=1 stroke="black"></line>
                    <line x1="200" y1="15" x2="203" y2="18" stroke-width=1 stroke="black"></line>

                    <line x1="15" y1="200" x2="385" y2="200" stroke-width=1 stroke="black"></line>
                    <line x1="385" y1="200" x2="382" y2="197" stroke-width=1 stroke="black"></line>
                    <line x1="385" y1="200" x2="382" y2="203" stroke-width=1 stroke="black"></line>

                    <line x1="275" y1="195" x2="275" y2="205" stroke-width=1 stroke="black"></line>
                    <line x1="350" y1="195" x2="350" y2="205" stroke-width=1 stroke="black"></line>
                    <line x1="125" y1="195" x2="125" y2="205" stroke-width=1 stroke="black"></line>
                    <line x1="50" y1="195" x2="50" y2="205" stroke-width=1 stroke="black"></line>

                    <line x1="195" y1="50" x2="205" y2="50" stroke-width=1 stroke="black"></line>
                    <line x1="195" y1="125" x2="205" y2="125" stroke-width=1 stroke="black"></line>
                    <line x1="195" y1="275" x2="205" y2="275" stroke-width=1 stroke="black"></line>
                    <line x1="195" y1="350" x2="205" y2="350" stroke-width=1 stroke="black"></line>

                    <text x="383" y="195" font-size="15" fill="black">x</text>
                    <text x="205" y="20" font-size="15" fill="black">y</text>

                    <text x="205" y="53" font-size="15" fill="black">R</text>
                    <text x="205" y="128" font-size="15" fill="black">R/2</text>
                    <text x="205" y="278" font-size="15" fill="black">-R/2</text>
                    <text x="205" y="358" font-size="15" fill="black">-R</text>

                    <text x="46" y="195" font-size="15" fill="black">-R</text>
                    <text x="118" y="195" font-size="15" fill="black">-R/2</text>
                    <text x="268" y="195" font-size="15" fill="black">R/2</text>
                    <text x="346" y="195" font-size="15" fill="black">R</text>
                </svg>
                <div id="circle"></div>
            </div>
            <form action="/controller" method="post" id="check">
                <table>
                    <tr>
                        <td>ВЫБЕРИТЕ X:</td>
                        <td>
                            <label><input type="radio" name="x" value="-4">-4</label>
                            <label><input type="radio" name="x" value="-3">-3</label>
                            <label><input type="radio" name="x" value="-2">-2</label>
                            <label><input type="radio" name="x" value="-1">-1</label>
                            <label><input type="radio" name="x" value="0">0</label>
                            <label><input type="radio" name="x" value="1">1</label>
                            <label><input type="radio" name="x" value="2">2</label>
                            <label><input type="radio" name="x" value="3">3</label>
                            <label><input type="radio" name="x" value="4">4</label>
                        </td>
                    </tr>
                    <tr>
                        <td>ВЫБЕРИТЕ Y:</td>
                        <td><input type="text" name="y" placeholder="-5..3"></td>
                    </tr>
                    <tr>
                        <td>ВЫБЕРИТЕ R:</td>
                        <td><input type="text" name="r" placeholder="1..4"></td>
                    </tr>
                </table>
                <table id="button_table">
                    <tr>
                        <td><input type="submit" id="button_submit" name="submit" value="ПРОВЕРИТЬ"></td>
                    </tr>
                </table>
                <table>
                    <tr id="error"></tr>
                </table>
            </form>
        </td>
        <td valign="top">
            <table id="result">
                <thead>
                <tr>
                    <th>X</th>
                    <th>Y</th>
                    <th>R</th>
                    <th>РЕЗУЛЬТАТ</th>
                    <th>ТЕКУЩЕЕ ВРЕМЯ</th>
                    <th>ВРЕМЯ ИСПОЛНЕНИЯ</th>
                </tr>
                </thead>
                <tbody>
                <%
                    Enumeration<String> attrs = session.getAttributeNames();
                    List<String> times = new ArrayList<>();
                    while (attrs.hasMoreElements()) {
                        times.add(attrs.nextElement());
                    }
                    Collections.sort(times);
                    for (int i = times.size() - 1; i >= 0; i--) {
                        Row row = (Row) session.getAttribute(times.get(i));
                %>
                <tr>
                    <td style="border: 1px solid darkblue;"><%= row.x %></td>
                    <td style="border: 1px solid darkblue;"><%= row.y %></td>
                    <td style="border: 1px solid darkblue;"><%= row.r %></td>
                    <td style="border: 1px solid darkblue;"><%= row.inn ? "Да" : "Нет" %></td>
                    <td style="border: 1px solid darkblue;"><%= row.time %></td>
                    <td style="border: 1px solid darkblue;"><%= row.runtime %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </td>
    </tr>
</table>
</body>
<script src="jquery-3.6.0.min.js"></script>
<script src="script3.js"></script>
</html>