package com.museum.module.artifact.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.museum.module.artifact.entity.ArtifactImage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ArtifactImageMapper extends BaseMapper<ArtifactImage> {

    @Select("SELECT * FROM artifact_image WHERE artifact_id = #{artifactId} ORDER BY sort_order, id")
    List<ArtifactImage> findByArtifactId(Long artifactId);
}
