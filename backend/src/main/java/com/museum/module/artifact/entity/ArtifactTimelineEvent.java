package com.museum.module.artifact.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("artifact_timeline_event")
public class ArtifactTimelineEvent {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long artifactId;
    private LocalDate eventDate;
    private Short eventYear;
    private Byte eventMonth;
    private String title;
    private String titleZh;
    private String description;
    private String descriptionZh;

    /** 1=launch  2=milestone  3=decline  4=closure */
    private Integer type;

    private Short sortOrder;
    private LocalDateTime createdAt;
}
