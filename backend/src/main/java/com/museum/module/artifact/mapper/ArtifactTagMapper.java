package com.museum.module.artifact.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.museum.module.artifact.entity.ArtifactTag;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ArtifactTagMapper extends BaseMapper<ArtifactTag> {

    @Select("""
            SELECT t.* FROM artifact_tag t
            INNER JOIN artifact_tag_rel r ON r.tag_id = t.id
            WHERE r.artifact_id = #{artifactId}
            """)
    List<ArtifactTag> findByArtifactId(Long artifactId);
}
