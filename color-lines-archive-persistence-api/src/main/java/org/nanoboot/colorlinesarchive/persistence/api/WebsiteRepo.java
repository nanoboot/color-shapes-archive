/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.nanoboot.colorlinesarchive.persistence.api;

import java.util.List;
import org.nanoboot.colorlinesarchive.entity.Website;

/**
 *
 * @author robertvokac
 */
public interface WebsiteRepo {
    List<Website> list(int pageNumber,int pageSize);
    int create(Website website);
    Website read(Integer number);
    void update(Website website);
    default void delete(Integer Number) {
        throw new UnsupportedOperationException();
    }
    
}
