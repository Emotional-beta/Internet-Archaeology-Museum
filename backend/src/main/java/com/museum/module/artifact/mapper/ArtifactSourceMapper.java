package com.museum.module.artifact.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.museum.module.artifact.entity.ArtifactSource;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ArtifactSourceMapper extends BaseMapper<ArtifactSource> {

    @Select("SELECT * FROM artifact_source WHERE artifact_id = #{artifactId} ORDER BY id")
    List<ArtifactSource> findByArtifactId(Long artifactId);
}
