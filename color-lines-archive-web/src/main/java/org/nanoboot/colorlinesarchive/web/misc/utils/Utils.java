///////////////////////////////////////////////////////////////////////////////////////////////
// Color Lines Archive.
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
package org.nanoboot.colorlinesarchive.web.misc.utils;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author <a href="mailto:robertvokac@nanoboot.org">Robert Vokac</a>
 * @since 0.0.0
 */
public class Utils {

    public static String getBaseUrl(HttpServletRequest request) {
        return request.getServerName() + ':' + request.getServerPort() + request.getContextPath() + '/';
    }

    public static String formatToHtmlWithoutEmptyWord(Object o) {
        return formatToHtml(o, false);
    }

    public static String formatToHtml(Object o) {
        return formatToHtml(o, true);
    }

    public static String formatToHtml(Object o, boolean withEmptyWord) {
        if (o == null) {
            return withEmptyWord ? "[empty]" : "";
        }
        if (o instanceof String && (((String) o)).isEmpty()) {
            return withEmptyWord ? "[empty]" : "";
        }
        if (o instanceof Boolean) {
            Boolean b = (Boolean) o;
            return b.booleanValue() ? "YES" : "NO";
        }
        return o.toString();
    }
}
