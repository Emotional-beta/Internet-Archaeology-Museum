package com.museum.module.artifact.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("artifact_source")
public class ArtifactSource {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long artifactId;
    private String title;
    private String url;

    /** 1=website  2=news  3=book  4=archive  5=interview */
    private Integer type;

    private Short year;
    private LocalDateTime createdAt;
}
