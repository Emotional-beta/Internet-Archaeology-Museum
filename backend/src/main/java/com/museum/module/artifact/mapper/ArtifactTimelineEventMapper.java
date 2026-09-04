package com.museum.module.artifact.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.museum.module.artifact.entity.ArtifactTimelineEvent;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ArtifactTimelineEventMapper extends BaseMapper<ArtifactTimelineEvent> {

    @Select("SELECT * FROM artifact_timeline_event WHERE artifact_id = #{artifactId} ORDER BY event_year, event_month, sort_order")
    List<ArtifactTimelineEvent> findByArtifactId(Long artifactId);
}
