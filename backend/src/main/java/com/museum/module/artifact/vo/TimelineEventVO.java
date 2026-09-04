package com.museum.module.artifact.vo;

import lombok.Data;

import java.time.LocalDate;

@Data
public class TimelineEventVO {
    private Long id;
    private LocalDate eventDate;
    private Short eventYear;
    private Byte eventMonth;
    private String title;
    private String titleZh;
    private String description;
    private String descriptionZh;
    private Integer type;
}
