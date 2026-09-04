package com.museum.module.artifact.dto;

import lombok.Data;

@Data
public class ArtifactQueryDTO {

    private Integer page = 1;
    private Integer pageSize = 20;

    /** Category slug filter */
    private String category;

    /** Era filter: 1990s, 2000s, 2010s, 2020s */
    private String era;

    /** Artifact status filter: 1=active, 2=ghost */
    private Integer status;

    /** Full-text search keyword */
    private String q;
}
