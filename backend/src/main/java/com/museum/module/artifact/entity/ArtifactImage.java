package com.museum.module.artifact.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("artifact_image")
public class ArtifactImage {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long artifactId;
    private String url;
    private String caption;
    private String captionZh;
    private Short year;
    private Short sortOrder;
    private LocalDateTime createdAt;
}
