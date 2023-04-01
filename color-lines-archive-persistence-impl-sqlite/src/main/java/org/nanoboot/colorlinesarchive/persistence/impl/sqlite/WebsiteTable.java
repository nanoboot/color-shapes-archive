/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.nanoboot.colorlinesarchive.persistence.impl.sqlite;

/**
 *
 * @author robertvokac
 */
public class WebsiteTable {
    public static final String TABLE_NAME = "WEBSITE";
    
    public static final String NUMBER = "NUMBER";
    public static final String URL = "URL";
    public static final String WEB_ARCHIVE_SNAPSHOT = "WEB_ARCHIVE_SNAPSHOT";
    public static final String LANGUAGE = "LANGUAGE";
    public static final String DOWNLOADED = "DOWNLOADED";
    public static final String FORMATTED = "FORMATTED";
    public static final String VERIFIED = "VERIFIED";
    public static final String VARIANT_NUMBER = "VARIANT_NUMBER";
    
    
    private WebsiteTable() {
        //Not meant to be instantiated.
    }
    
}
