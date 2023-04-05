///////////////////////////////////////////////////////////////////////////////////////////////
// Color Shapes Archive.
// Copyright (C) 2023-2023 the original author or authors.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; version 2
// of the License only.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
///////////////////////////////////////////////////////////////////////////////////////////////
package org.nanoboot.colorshapesarchive.web.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
        name = "FileServlet",
        urlPatterns = "/FileServlet/*"
)
public class FileServlet extends HttpServlet {

    private final int ARBITARY_SIZE = 1048;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        //resp.setContentType("text/plain");
        //resp.setHeader("Content-disposition", "attachment; filename=sample.txt");
        
        String requestUri = req.getRequestURI();
        String contextPath = req.getContextPath();
        requestUri = requestUri.replace(contextPath, "");
        requestUri = requestUri.replace("/FileServlet/", "");
        String[] requestUriArray = requestUri.split("/");
        if(requestUriArray.length != 2) {
            resp.getOutputStream().println("out.println(requestUriArray.length != 2)");
            return;
        }
        String website_number = requestUriArray[0];
        String file_name = requestUriArray[1];

        if (file_name == null || file_name.isEmpty()) {
            resp.getOutputStream().println("file_name is mandatory");
            return;
        }

        String filePath = System.getProperty("color-shapes-archive.confpath") + "/" + "websitesFormatted/" + website_number + "/";

        File file = new File(filePath + "/" + file_name);
        if (!file.exists()) {
            resp.getOutputStream().println("file " + file.getAbsolutePath() + " does not exist.");
            return;
        }

        if (file.isDirectory()) {
            resp.getOutputStream().println("file " + file.getAbsolutePath() + " is directory.");
            return;
        }
        try ( InputStream in = new FileInputStream(file);  OutputStream out = resp.getOutputStream()) {

            byte[] buffer = new byte[ARBITARY_SIZE];

            int numBytesRead;
            while ((numBytesRead = in.read(buffer)) > 0) {
                out.write(buffer, 0, numBytesRead);
            }
        }
    }
}
