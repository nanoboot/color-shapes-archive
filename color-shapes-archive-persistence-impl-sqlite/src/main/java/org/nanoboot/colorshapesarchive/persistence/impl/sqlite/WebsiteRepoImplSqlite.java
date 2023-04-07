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
package org.nanoboot.colorshapesarchive.persistence.impl.sqlite;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import lombok.Setter;
import org.nanoboot.colorshapesarchive.entity.Website;
import org.nanoboot.colorshapesarchive.persistence.api.WebsiteRepo;

/**
 *
 * @author robertvokac
 */
public class WebsiteRepoImplSqlite implements WebsiteRepo {

    private final List<Website> internalList = new ArrayList<>();

    @Setter
    private SqliteConnectionFactory sqliteConnectionFactory;
    private int nextNumber = 1;

    @Override
    public List<Website> list(int pageNumber, int pageSize, Boolean downloaded, Boolean formatted, Boolean verified, Integer number, String url) {
        int numberEnd = pageSize * pageNumber;
        int numberStart = numberEnd - pageSize + 1;

        List<Website> result = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        sb
                .append("SELECT * FROM ")
                .append(WebsiteTable.TABLE_NAME)
                .append(" WHERE ");
        boolean pagingIsEnabled = downloaded == null && formatted == null && verified == null && number == null && url == null;
              
        
        if(pagingIsEnabled) {
            sb.append(WebsiteTable.NUMBER)
                .append(" BETWEEN ? AND ? ");
        } else{
        sb.append("1=1");
    }
        if (downloaded != null) {
            sb.append(" AND ").append(WebsiteTable.DOWNLOADED)
                    .append("=?");
        }
        if (formatted != null) {
            sb.append(" AND ").append(WebsiteTable.FORMATTED)
                    .append("=?");
        }
        if (verified != null) {
            sb.append(WebsiteTable.VERIFIED)
                    .append("=?");
        }
        if (number != null) {
            sb.append(" AND ").append(WebsiteTable.NUMBER)
                    .append("=?");
        }
        if (url != null) {
            sb.append(" AND ").append(WebsiteTable.URL)
                    .append(" LIKE '%' || ? || '%'");
        }
        String sql = sb.toString();
        System.err.println(sql);
        int i = 0;
        ResultSet rs = null;
        try (
                 Connection connection = sqliteConnectionFactory.createConnection();  PreparedStatement stmt = connection.prepareStatement(sql);) {
            if(pagingIsEnabled) {
            stmt.setInt(++i, numberStart);
            stmt.setInt(++i, numberEnd);
            }
            
            //Boolean downloaded, Boolean formatted, Boolean verified, Integer number, String url
            if(downloaded != null)       {
                stmt.setInt(++i, downloaded ? 1 : 0);
            }
            if(formatted != null)       {
                stmt.setInt(++i, formatted ? 1 : 0);
            }
            if(verified != null)       {
                stmt.setInt(++i, verified ? 1 : 0);
            }
            if(number != null)       {
                stmt.setInt(++i, number);
            }
            if(url != null)       {
                stmt.setString(++i, url);
            }
            System.err.println(stmt.toString());
            rs = stmt.executeQuery();

            while (rs.next()) {
                result.add(extractWebsiteFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(WebsiteRepoImplSqlite.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(WebsiteRepoImplSqlite.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return result;
    }

    private static Website extractWebsiteFromResultSet(final ResultSet rs) throws SQLException {
        return new Website(
                rs.getInt(WebsiteTable.NUMBER),
                rs.getString(WebsiteTable.URL),
                rs.getString(WebsiteTable.WEB_ARCHIVE_SNAPSHOT),
                rs.getString(WebsiteTable.LANGUAGE),
                rs.getInt(WebsiteTable.DOWNLOADED) != 0,
                rs.getInt(WebsiteTable.FORMATTED) != 0,
                rs.getInt(WebsiteTable.VERIFIED) != 0,
                rs.getInt(WebsiteTable.VARIANT_NUMBER)
        );
    }

    @Override
    public int create(Website website) {
        website.setNumber(nextNumber++);
        internalList.add(website);
        return website.getNumber();
    }

    @Override
    public Website read(Integer number) {
        for (Website w : internalList) {
            if (w.getNumber().intValue() == number.intValue()) {
                return w;
            }
        }
        return null;
    }

    @Override
    public void update(Website website) {
        Website websiteToBeDeleted = null;
        for (Website w : internalList) {
            if (w.getNumber().intValue() == website.getNumber().intValue()) {
                websiteToBeDeleted = w;
                break;
            }
        }
        if (websiteToBeDeleted == null) {
            //nothing to do
            return;
        }
        internalList.remove(websiteToBeDeleted);
        internalList.add(website);

    }

}
