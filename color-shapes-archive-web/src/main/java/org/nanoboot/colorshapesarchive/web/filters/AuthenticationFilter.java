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

package org.nanoboot.colorshapesarchive.web.filters;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.Properties;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.nanoboot.colorshapesarchive.web.misc.utils.Utils;

public class AuthenticationFilter implements Filter {

    private ServletContext context;

    public void init(FilterConfig fConfig) throws ServletException {
        this.context = fConfig.getServletContext();
        this.context.log("AuthenticationFilter started");
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

//        HttpServletRequest req = (HttpServletRequest) request;
//        HttpServletResponse res = (HttpServletResponse) response;
//
//        HttpSession session = req.getSession(false);
//        boolean sessionExists = session != null;
//
//        boolean anonymous = false;
//           
//        String octConfpath = System.getProperty("oct.datapath");
//        if (octConfpath == null || octConfpath.isEmpty()) {
//            String msg = "Octagon configuration is broken : " + "oct.datapath + oct.datapath=" + octConfpath;
//            throw new RuntimeException(msg);
//        }
//        File octagonProperties = new File(octConfpath + "/octagon.properties");
//        try ( InputStream input = new FileInputStream(octagonProperties.getAbsolutePath())) {
//
//            Properties properties = new Properties();
//            properties.load(input);
//            anonymous = properties.getProperty("authentication").equals("anonymous");
//
//        } catch (IOException ex) {
//            ex.printStackTrace();
//            throw new RuntimeException("Loading octagon.properties failed.");
//        }
//
//        
//        if (!sessionExists) {
//            String sendRedirect = "";
//            if (request instanceof HttpServletRequest) {
//                String url = ((HttpServletRequest) request).getRequestURL().toString();
//                String queryString = ((HttpServletRequest) request).getQueryString();
//                sendRedirect = url + (queryString == null ? "" : ("?" + queryString));
//                if (!sendRedirect.contains("/ui") || sendRedirect.endsWith(".js") || sendRedirect.isEmpty()) {
//                    sendRedirect = "";
//                }
//                final String[] split = sendRedirect.split(Utils.getBaseUrl(req));
//                sendRedirect = split.length > 1 ? split[1] : "";
//                sendRedirect =  Base64.getEncoder().encodeToString(sendRedirect.getBytes());
//            }
//
//            if(anonymous) {
//                chain.doFilter(request, response);
//            } else {
//                res.sendRedirect(req.getContextPath() + "/loginPage.html" + (sendRedirect.isEmpty() ? "" : "?sendRedirect=" + sendRedirect));
//                this.context.log("Access is not authorized.");
//            }
//            
//        } else {
//            this.context.log("Access is authorized.");
            chain.doFilter(request, response);
//        }
    }

    public void destroy() {
        //close any resources here
    }
}
