package com.museum.module.artifact.vo;

import lombok.Data;

import java.util.List;

@Data
public class ArtifactDetailVO {
    private Long id;
    private String slug;
    private String name;
    private String nameZh;
    private CategoryVO category;
    private List<TagVO> tags;
    private Integer status;
    private Short foundedYear;
    private Short closedYear;
    private String country;
    private String description;
    private String descriptionZh;
    private String significance;
    private String significanceZh;
    private String whatHappened;
    private String whatHappenedZh;
    private String coverImageUrl;
    private String websiteUrl;
    private String archiveUrl;
    private List<ArtifactImageVO> images;
    private List<ArtifactSourceVO> sources;
    private List<TimelineEventVO> timelineEvents;
    private Integer memoryCount;
    private Integer viewCount;
}
