package com.museum.module.artifact.vo;

import lombok.Data;

@Data
public class ArtifactSourceVO {
    private Long id;
    private String title;
    private String url;
    private Integer type;
    private Short year;
}
