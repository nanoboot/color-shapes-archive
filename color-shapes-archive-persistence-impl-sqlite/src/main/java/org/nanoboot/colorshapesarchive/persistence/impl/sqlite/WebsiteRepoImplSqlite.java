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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
        {
            List<Website> result = new ArrayList<>();
            String sql = "SELECT * FROM " + WebsiteTable.TABLE_NAME + " WHERE " + WebsiteTable.NUMBER + " BETWEEN "  + numberStart + " AND " + numberEnd;
            try ( Connection connection = sqliteConnectionFactory.createConnection();  Statement stmt = connection.createStatement();  ResultSet rs = stmt.executeQuery(sql)) {

                while (rs.next()) {
                    result.add(extractWebsiteFromResultSet(rs));
                }
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(WebsiteRepoImplSqlite.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (true) {
                return result;
            }
        }

        if (internalList.isEmpty()) {
            for (int i = 0; i < 50; i++) {
                internalList.add(
                        new Website(
                                nextNumber++,
                                "http://colorshapes.nanoboot.org",
                                "abc",
                                "en",
                                true,
                                true,
                                true,
                                null));
            }
        }
        List<Website> finalList = new ArrayList<>();
        for (Website w : internalList) {
            if (w.getNumber() < numberStart || w.getNumber() > numberEnd) {
                continue;
            }

            if (number != null) {
                if (w.getNumber().intValue() == number.intValue()) {
                    finalList.add(w);
                    break;
                } else {
                    continue;
                }
            }
            if (url != null) {
                if (w.getUrl().contains(url)) {
                    finalList.add(w);
                    continue;
                } else {
                    continue;
                }
            }

            if (downloaded != null) {
                if (w.getDownloaded().booleanValue() && !downloaded) {
                    continue;
                }

                if (!w.getDownloaded().booleanValue() && downloaded) {
                    continue;
                }
            }

            if (formatted != null) {
                if (w.getFormatted().booleanValue() && !formatted) {
                    continue;
                }

                if (!w.getFormatted().booleanValue() && formatted) {
                    continue;
                }
            }

            if (verified != null) {
                if (w.getVerified().booleanValue() && !verified) {
                    continue;
                }

                if (!w.getVerified().booleanValue() && verified) {
                    continue;
                }
            }
            finalList.add(w);

        }
        return finalList;
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
