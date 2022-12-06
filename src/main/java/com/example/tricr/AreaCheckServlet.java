package com.example.tricr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "areaCheckServlet", value = "/area-check")
public class AreaCheckServlet extends HttpServlet {
    public boolean inCircle(double x, double y, double r) {
        return x <= 0 && y >= 0 && Math.pow(x, 2) + Math.pow(y, 2) <= Math.pow(r, 2) / 4;
    }

    public boolean inTriangle(double x, double y, double r) {
        return x >= 0 && y >= 0 && y == r - x;
    }

    public boolean inRectangle(double x, double y, double r) {
        return x >= 0 && y <= 0 && y > - r / 2 && x <= r;
    }

    public boolean checkArea(String x, String y, String r) {
        double ix = Double.parseDouble(x);
        double iy = Double.parseDouble(y);
        double ir = Double.parseDouble(r);
        return inCircle(ix, iy, ir) || inRectangle(ix, iy, ir) || inTriangle(ix, iy, ir);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        long startTime = System.nanoTime();
        String x = request.getParameter("x");
        String y = request.getParameter("y");
        String r = request.getParameter("r");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        boolean inn = checkArea(x, y , r);
        double runtime = (((double) System.nanoTime() - startTime) / Math.pow(10, 6));
        String time = LocalDateTime.now().toLocalTime().format(formatter);
        HttpSession session = request.getSession();
        String json = "{" +
                "\"x\":" + x +
                ", \"y\":" + y +
                ", \"r\":" + r +
                ", \"inn\":" + inn +
                ", \"time\":\"" + time + '\"' +
                ", \"runtime\":" + runtime  +
                '}';
        session.setAttribute(time, new Row(x, y, r, inn, time, runtime + "ms"));

        PrintWriter out = response.getWriter();
        out.println(json);
    }
}
