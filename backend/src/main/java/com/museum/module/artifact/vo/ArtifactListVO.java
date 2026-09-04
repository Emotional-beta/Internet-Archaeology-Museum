package com.museum.module.artifact.vo;

import lombok.Data;

@Data
public class ArtifactListVO {
    private Long id;
    private String slug;
    private String name;
    private String nameZh;
    private CategoryVO category;
    private Integer status;
    private Short foundedYear;
    private Short closedYear;
    private String country;
    private String coverImageUrl;
    private Integer memoryCount;
    private Integer viewCount;
}
