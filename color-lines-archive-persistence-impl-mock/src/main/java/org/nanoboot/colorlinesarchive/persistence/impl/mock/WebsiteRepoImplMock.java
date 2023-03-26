/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.nanoboot.colorlinesarchive.persistence.impl.mock;

import java.util.ArrayList;
import java.util.List;
import org.nanoboot.colorlinesarchive.entity.Website;
import org.nanoboot.colorlinesarchive.persistence.api.WebsiteRepo;

/**
 *
 * @author robertvokac
 */
public class WebsiteRepoImplMock implements WebsiteRepo {

    private final List<Website> internalList = new ArrayList<>();

    @Override
    public List<Website> list(int pageNumber, int pageSize) {
        if (internalList.isEmpty()) {
            internalList.add(
                    new Website(
                            1, 
                            "http://colorshapes.nanoboot.org", 
                            "abc", 
                            "en", 
                            true, 
                            true, 
                            true,
                            null));
        }
        return internalList;
    }

    @Override
    public void create(Website website) {
        internalList.add(website);
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
        if(websiteToBeDeleted == null) {
            //nothing to do
            return;
        }
        internalList.remove(websiteToBeDeleted);
    }

}
