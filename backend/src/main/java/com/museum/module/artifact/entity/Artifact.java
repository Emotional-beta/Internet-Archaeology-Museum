package com.museum.module.artifact.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("artifact")
public class Artifact {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String slug;
    private String name;
    private String nameZh;
    private Long categoryId;

    /** 1=active  2=ghost  3=draft */
    private Integer status;

    private Short foundedYear;
    private Short closedYear;
    private LocalDate foundedDate;
    private LocalDate closedDate;
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

    @TableField(fill = FieldFill.INSERT)
    private Integer viewCount;

    @TableField(fill = FieldFill.INSERT)
    private Integer memoryCount;

    private Long createdBy;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedAt;

    @TableLogic
    private LocalDateTime deletedAt;
}
