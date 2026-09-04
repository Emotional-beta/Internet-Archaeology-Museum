package com.museum.module.artifact.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class TagVO {
    private Long id;
    private String name;
    private String nameZh;
    private String slug;
}
