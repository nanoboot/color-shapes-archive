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
import org.nanoboot.colorshapesarchive.entity.Variant;
import org.nanoboot.colorshapesarchive.persistence.api.VariantRepo;
import org.nanoboot.powerframework.time.moment.LocalDate;

/**
 *
 * @author robertvokac
 */
public class VariantRepoImplSqlite implements VariantRepo {

    @Setter
    private SqliteConnectionFactory sqliteConnectionFactory;

    @Override
    public List<Variant> list(int pageNumber,int pageSize, Integer number) {
        int numberEnd = pageSize * pageNumber;
        int numberStart = numberEnd - pageSize + 1;

        List<Variant> result = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        sb
                .append("SELECT * FROM ")
                .append(VariantTable.TABLE_NAME)
                .append(" WHERE ");
        boolean pagingIsEnabled = number == null;

        if (pagingIsEnabled) {
            sb.append(VariantTable.NUMBER)
                    .append(" BETWEEN ? AND ? ");
        } else {
            sb.append("1=1");
        }
       
        if (number != null) {
            sb.append(" AND ").append(WebsiteTable.NUMBER)
                    .append("=?");
        }
      
        String sql = sb.toString();
        System.err.println(sql);
        int i = 0;
        ResultSet rs = null;
        try (
                 Connection connection = sqliteConnectionFactory.createConnection();  PreparedStatement stmt = connection.prepareStatement(sql);) {
            if (pagingIsEnabled) {
                stmt.setInt(++i, numberStart);
                stmt.setInt(++i, numberEnd);
            }
         
            if (number != null) {
                stmt.setInt(++i, number);
            }
            System.err.println(stmt.toString());
            rs = stmt.executeQuery();

            while (rs.next()) {
                result.add(extractVariantFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(VariantRepoImplSqlite.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(VariantRepoImplSqlite.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return result;
    }

    private static Variant extractVariantFromResultSet(final ResultSet rs) throws SQLException {
        String lastUpdateTmp = rs.getString(VariantTable.LAST_UPDATE);
        return new Variant(
                rs.getInt(VariantTable.NUMBER),
                rs.getString(VariantTable.NAME),
                rs.getString(VariantTable.NOTE),
                rs.getString(VariantTable.STATUS),
                rs.getString(VariantTable.AUTHOR),
                //
                rs.getString(VariantTable.LICENCE),
                rs.getInt(VariantTable.OPEN_SOURCE) != 0,
                rs.getString(VariantTable.USER_INTERFACE),
                rs.getString(VariantTable.PROGRAMMING_LANGUAGE),
                rs.getInt(VariantTable.BINARIES) != 0,
                
                //
                
                lastUpdateTmp == null ? null : new LocalDate(lastUpdateTmp), 
                rs.getString(VariantTable.LAST_VERSION)
        );
    }

    @Override
    public int create(Variant variant) {
//        StringBuilder sb = new StringBuilder();
//        sb
//                .append("INSERT INTO ")
//                .append(WebsiteTable.TABLE_NAME)
//                .append("(")
//                .append(WebsiteTable.URL).append(",")
//                .append(WebsiteTable.WEB_ARCHIVE_SNAPSHOT).append(",")
//                .append(WebsiteTable.LANGUAGE).append(",")
//                //
//                .append(WebsiteTable.DOWNLOADED).append(",")
//                .append(WebsiteTable.FORMATTED).append(",")
//                .append(WebsiteTable.VERIFIED);
//        if (variant.getVariantNumber() != null) {
//            sb.append(",").append(WebsiteTable.VARIANT_NUMBER);
//        }
//        sb.append(")")
//                .append(" VALUES (?,?,?,  ?,?,?");
//        if (variant.getVariantNumber() != null) {
//            sb.append(",?");
//        }
//        sb.append(")");
//
//        String sql = sb.toString();
//        System.err.println(sql);
//        try (
//                 Connection connection = sqliteConnectionFactory.createConnection();  PreparedStatement stmt = connection.prepareStatement(sql);) {
//            int i = 0;
//            stmt.setString(++i, variant.getUrl());
//            stmt.setString(++i, variant.getWebArchiveSnapshot());
//            stmt.setString(++i, variant.getLanguage());
//            //
//            stmt.setInt(++i, variant.getDownloaded() ? 1 : 0);
//            stmt.setInt(++i, variant.getFormatted() ? 1 : 0);
//            stmt.setInt(++i, variant.getVerified() ? 1 : 0);
//            if (variant.getVariantNumber() != null) {
//                stmt.setInt(++i, variant.getVariantNumber());
//            }
//            //
//
//            stmt.execute();
//            System.out.println(stmt.toString());
//            ResultSet rs = connection.createStatement().executeQuery("select last_insert_rowid() as last");
//            while (rs.next()) {
//                int numberOfNewWebsite = rs.getInt("last");
//                System.out.println("numberOfNewWebsite=" + numberOfNewWebsite);
//                return numberOfNewWebsite;
//            }
//
//        } catch (SQLException e) {
//            System.out.println(e.getMessage());
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(VariantRepoImplSqlite.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        System.err.println("Error.");
        return 0;
    }

    @Override
    public Variant read(Integer number) {

        if (number == null) {
            throw new RuntimeException("number is null");
        }
        StringBuilder sb = new StringBuilder();
        sb
                .append("SELECT * FROM ")
                .append(VariantTable.TABLE_NAME)
                .append(" WHERE ")
                .append(VariantTable.NUMBER)
                .append("=?");

        String sql = sb.toString();
        int i = 0;
        ResultSet rs = null;
        try (
                 Connection connection = sqliteConnectionFactory.createConnection();  PreparedStatement stmt = connection.prepareStatement(sql);) {

            stmt.setInt(++i, number);

            rs = stmt.executeQuery();

            while (rs.next()) {
                return extractVariantFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(VariantRepoImplSqlite.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(VariantRepoImplSqlite.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    @Override
    public void update(Variant variant) {
//        StringBuilder sb = new StringBuilder();
//        sb
//                .append("UPDATE ")
//                .append(WebsiteTable.TABLE_NAME)
//                .append(" SET ")
//                .append(WebsiteTable.URL).append("=?, ")
//                .append(WebsiteTable.WEB_ARCHIVE_SNAPSHOT).append("=?, ")
//                .append(WebsiteTable.LANGUAGE).append("=?, ")
//                //
//                .append(WebsiteTable.DOWNLOADED).append("=?, ")
//                .append(WebsiteTable.FORMATTED).append("=?, ")
//                .append(WebsiteTable.VERIFIED).append("=?, ")
//                .append(WebsiteTable.VARIANT_NUMBER).append("=? ")
//                .append(" WHERE ").append(WebsiteTable.NUMBER).append("=?");
//
//        String sql = sb.toString();
//        System.err.println(sql);
//        try (
//                 Connection connection = sqliteConnectionFactory.createConnection();  PreparedStatement stmt = connection.prepareStatement(sql);) {
//            int i = 0;
//            stmt.setString(++i, website.getUrl());
//            stmt.setString(++i, website.getWebArchiveSnapshot());
//            stmt.setString(++i, website.getLanguage());
//            //
//            stmt.setInt(++i, website.getDownloaded() ? 1 : 0);
//            stmt.setInt(++i, website.getFormatted() ? 1 : 0);
//            stmt.setInt(++i, website.getVerified() ? 1 : 0);
//            stmt.setInt(++i, website.getVariantNumber());
//            //
//            stmt.setInt(++i, website.getNumber());
//
//            int numberOfUpdatedRows = stmt.executeUpdate();
//            System.out.println("numberOfUpdatedRows=" + numberOfUpdatedRows);
//        } catch (SQLException e) {
//            System.out.println(e.getMessage());
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(VariantRepoImplSqlite.class.getName()).log(Level.SEVERE, null, ex);
//        }
    }

}
