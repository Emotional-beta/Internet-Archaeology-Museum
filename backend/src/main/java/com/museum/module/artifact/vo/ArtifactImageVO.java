package com.museum.module.artifact.vo;

import lombok.Data;

@Data
public class ArtifactImageVO {
    private Long id;
    private String url;
    private String caption;
    private String captionZh;
    private Short year;
}
