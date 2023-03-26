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

package org.nanoboot.colorlinesarchive.entity;

import lombok.Data;

import java.util.UUID;
/**
 *
 * @author <a href="mailto:robertvokac@nanoboot.org">Robert Vokac</a>
 * @since 0.0.0
 */
import org.nanoboot.powerframework.time.moment.LocalDate;
@Data
public class Variant {
    /**
     * UUID identification of this entity.
     */
    private UUID id;
    //
    private String name;
    private String image;
    private String status;
    private String author;
    //
    private String licence;
    private Boolean openSource;
    private String userInterface;
    private String programmingLanguage;
    
    private Boolean binariesAvailable;
    private LocalDate lastUpdate;
    private String lastVersion;
    

 
}
