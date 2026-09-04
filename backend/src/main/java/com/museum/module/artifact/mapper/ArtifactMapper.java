package com.museum.module.artifact.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.museum.module.artifact.entity.Artifact;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.Optional;

@Mapper
public interface ArtifactMapper extends BaseMapper<Artifact> {

    @Select("SELECT * FROM artifact WHERE slug = #{slug} AND deleted_at IS NULL LIMIT 1")
    Optional<Artifact> findBySlug(String slug);
}
