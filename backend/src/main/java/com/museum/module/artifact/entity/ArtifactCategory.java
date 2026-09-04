package com.museum.module.artifact.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("artifact_category")
public class ArtifactCategory {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;
    private String nameZh;
    private String slug;
    private String description;
    private String descriptionZh;
    private String icon;
    private Short sortOrder;
    private LocalDateTime createdAt;
}
