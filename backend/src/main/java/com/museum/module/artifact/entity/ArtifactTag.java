package com.museum.module.artifact.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("artifact_tag")
public class ArtifactTag {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;
    private String nameZh;
    private String slug;
    private LocalDateTime createdAt;
}
