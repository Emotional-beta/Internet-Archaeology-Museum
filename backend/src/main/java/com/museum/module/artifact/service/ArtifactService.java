package com.museum.module.artifact.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.museum.common.exception.BusinessException;
import com.museum.common.response.PageResult;
import com.museum.module.artifact.dto.ArtifactCreateDTO;
import com.museum.module.artifact.dto.ArtifactQueryDTO;
import com.museum.module.artifact.entity.*;
import com.museum.module.artifact.mapper.*;
import com.museum.module.artifact.vo.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ArtifactService {

    private final ArtifactMapper artifactMapper;
    private final ArtifactCategoryMapper categoryMapper;
    private final ArtifactTagMapper tagMapper;
    private final ArtifactImageMapper imageMapper;
    private final ArtifactSourceMapper sourceMapper;
    private final ArtifactTimelineEventMapper timelineEventMapper;

    public PageResult<ArtifactListVO> list(ArtifactQueryDTO query) {
        LambdaQueryWrapper<Artifact> wrapper = new LambdaQueryWrapper<Artifact>()
                .isNull(Artifact::getDeletedAt);

        if (query.getStatus() != null) {
            wrapper.eq(Artifact::getStatus, query.getStatus());
        }

        if (StringUtils.hasText(query.getEra())) {
            applyEraFilter(wrapper, query.getEra());
        }

        if (StringUtils.hasText(query.getCategory())) {
            ArtifactCategory cat = findCategoryBySlug(query.getCategory());
            wrapper.eq(Artifact::getCategoryId, cat.getId());
        }

        if (StringUtils.hasText(query.getQ())) {
            wrapper.and(w -> w
                    .like(Artifact::getName, query.getQ())
                    .or().like(Artifact::getNameZh, query.getQ())
                    .or().like(Artifact::getDescription, query.getQ())
            );
        }

        wrapper.orderByDesc(Artifact::getCreatedAt);

        Page<Artifact> page = new Page<>(query.getPage(), query.getPageSize());
        Page<Artifact> result = artifactMapper.selectPage(page, wrapper);

        Map<Long, ArtifactCategory> categoryMap = loadCategoryMap(result.getRecords());

        List<ArtifactListVO> list = result.getRecords().stream()
                .map(a -> toListVO(a, categoryMap.get(a.getCategoryId())))
                .collect(Collectors.toList());

        return new PageResult<>(list, result.getTotal(), query.getPage(), query.getPageSize());
    }

    public ArtifactDetailVO getBySlug(String slug) {
        Artifact artifact = artifactMapper.findBySlug(slug)
                .orElseThrow(() -> BusinessException.notFound("Artifact"));

        artifactMapper.update(null, new LambdaUpdateWrapper<Artifact>()
                .eq(Artifact::getId, artifact.getId())
                .setSql("view_count = view_count + 1"));

        artifact.setViewCount(artifact.getViewCount() + 1);

        ArtifactCategory category = categoryMapper.selectById(artifact.getCategoryId());
        List<ArtifactTag> tags = tagMapper.findByArtifactId(artifact.getId());
        List<ArtifactImage> images = imageMapper.findByArtifactId(artifact.getId());
        List<ArtifactSource> sources = sourceMapper.findByArtifactId(artifact.getId());
        List<ArtifactTimelineEvent> events = timelineEventMapper.findByArtifactId(artifact.getId());

        return toDetailVO(artifact, category, tags, images, sources, events);
    }

    @Transactional
    public ArtifactDetailVO create(ArtifactCreateDTO dto, Long createdBy) {
        if (artifactMapper.findBySlug(dto.getSlug()).isPresent()) {
            throw BusinessException.badRequest("Artifact slug already exists: " + dto.getSlug());
        }

        categoryMapper.selectById(dto.getCategoryId());

        Artifact artifact = new Artifact();
        artifact.setSlug(dto.getSlug());
        artifact.setName(dto.getName());
        artifact.setNameZh(dto.getNameZh());
        artifact.setCategoryId(dto.getCategoryId());
        artifact.setStatus(dto.getStatus() != null ? dto.getStatus() : 3);
        artifact.setFoundedYear(dto.getFoundedYear());
        artifact.setClosedYear(dto.getClosedYear());
        artifact.setCountry(dto.getCountry());
        artifact.setDescription(dto.getDescription());
        artifact.setDescriptionZh(dto.getDescriptionZh());
        artifact.setSignificance(dto.getSignificance());
        artifact.setSignificanceZh(dto.getSignificanceZh());
        artifact.setWhatHappened(dto.getWhatHappened());
        artifact.setWhatHappenedZh(dto.getWhatHappenedZh());
        artifact.setCoverImageUrl(dto.getCoverImageUrl());
        artifact.setWebsiteUrl(dto.getWebsiteUrl());
        artifact.setArchiveUrl(dto.getArchiveUrl());
        artifact.setCreatedBy(createdBy);

        artifactMapper.insert(artifact);

        return getBySlug(artifact.getSlug());
    }

    @Transactional
    public ArtifactDetailVO update(String slug, ArtifactCreateDTO dto) {
        Artifact artifact = artifactMapper.findBySlug(slug)
                .orElseThrow(() -> BusinessException.notFound("Artifact"));

        if (!slug.equals(dto.getSlug())) {
            if (artifactMapper.findBySlug(dto.getSlug()).isPresent()) {
                throw BusinessException.badRequest("Artifact slug already exists: " + dto.getSlug());
            }
        }

        artifact.setSlug(dto.getSlug());
        artifact.setName(dto.getName());
        artifact.setNameZh(dto.getNameZh());
        artifact.setCategoryId(dto.getCategoryId());
        if (dto.getStatus() != null) artifact.setStatus(dto.getStatus());
        artifact.setFoundedYear(dto.getFoundedYear());
        artifact.setClosedYear(dto.getClosedYear());
        artifact.setCountry(dto.getCountry());
        artifact.setDescription(dto.getDescription());
        artifact.setDescriptionZh(dto.getDescriptionZh());
        artifact.setSignificance(dto.getSignificance());
        artifact.setSignificanceZh(dto.getSignificanceZh());
        artifact.setWhatHappened(dto.getWhatHappened());
        artifact.setWhatHappenedZh(dto.getWhatHappenedZh());
        artifact.setCoverImageUrl(dto.getCoverImageUrl());
        artifact.setWebsiteUrl(dto.getWebsiteUrl());
        artifact.setArchiveUrl(dto.getArchiveUrl());

        artifactMapper.updateById(artifact);

        return getBySlug(artifact.getSlug());
    }

    // --- helpers ---

    private void applyEraFilter(LambdaQueryWrapper<Artifact> wrapper, String era) {
        switch (era) {
            case "1990s":
                wrapper.between(Artifact::getFoundedYear, 1990, 1999);
                break;
            case "2000s":
                wrapper.between(Artifact::getFoundedYear, 2000, 2009);
                break;
            case "2010s":
                wrapper.between(Artifact::getFoundedYear, 2010, 2019);
                break;
            case "2020s":
                wrapper.ge(Artifact::getFoundedYear, 2020);
                break;
            default:
                throw BusinessException.badRequest("Unknown era: " + era);
        }
    }

    private ArtifactCategory findCategoryBySlug(String slug) {
        return categoryMapper.selectOne(
                new LambdaQueryWrapper<ArtifactCategory>().eq(ArtifactCategory::getSlug, slug)
        );
    }

    private Map<Long, ArtifactCategory> loadCategoryMap(List<Artifact> artifacts) {
        List<Long> ids = artifacts.stream().map(Artifact::getCategoryId).distinct().toList();
        if (ids.isEmpty()) return Map.of();
        return categoryMapper.selectBatchIds(ids).stream()
                .collect(Collectors.toMap(ArtifactCategory::getId, c -> c));
    }

    private ArtifactListVO toListVO(Artifact a, ArtifactCategory category) {
        ArtifactListVO vo = new ArtifactListVO();
        vo.setId(a.getId());
        vo.setSlug(a.getSlug());
        vo.setName(a.getName());
        vo.setNameZh(a.getNameZh());
        vo.setStatus(a.getStatus());
        vo.setFoundedYear(a.getFoundedYear());
        vo.setClosedYear(a.getClosedYear());
        vo.setCountry(a.getCountry());
        vo.setCoverImageUrl(a.getCoverImageUrl());
        vo.setMemoryCount(a.getMemoryCount());
        vo.setViewCount(a.getViewCount());
        if (category != null) vo.setCategory(toCategoryVO(category));
        return vo;
    }

    private ArtifactDetailVO toDetailVO(Artifact a, ArtifactCategory category,
                                        List<ArtifactTag> tags, List<ArtifactImage> images,
                                        List<ArtifactSource> sources, List<ArtifactTimelineEvent> events) {
        ArtifactDetailVO vo = new ArtifactDetailVO();
        vo.setId(a.getId());
        vo.setSlug(a.getSlug());
        vo.setName(a.getName());
        vo.setNameZh(a.getNameZh());
        vo.setStatus(a.getStatus());
        vo.setFoundedYear(a.getFoundedYear());
        vo.setClosedYear(a.getClosedYear());
        vo.setCountry(a.getCountry());
        vo.setDescription(a.getDescription());
        vo.setDescriptionZh(a.getDescriptionZh());
        vo.setSignificance(a.getSignificance());
        vo.setSignificanceZh(a.getSignificanceZh());
        vo.setWhatHappened(a.getWhatHappened());
        vo.setWhatHappenedZh(a.getWhatHappenedZh());
        vo.setCoverImageUrl(a.getCoverImageUrl());
        vo.setWebsiteUrl(a.getWebsiteUrl());
        vo.setArchiveUrl(a.getArchiveUrl());
        vo.setMemoryCount(a.getMemoryCount());
        vo.setViewCount(a.getViewCount());
        if (category != null) vo.setCategory(toCategoryVO(category));
        vo.setTags(tags.stream().map(this::toTagVO).collect(Collectors.toList()));
        vo.setImages(images.stream().map(this::toImageVO).collect(Collectors.toList()));
        vo.setSources(sources.stream().map(this::toSourceVO).collect(Collectors.toList()));
        vo.setTimelineEvents(events.stream().map(this::toTimelineEventVO).collect(Collectors.toList()));
        return vo;
    }

    private CategoryVO toCategoryVO(ArtifactCategory c) {
        CategoryVO vo = new CategoryVO();
        vo.setId(c.getId());
        vo.setName(c.getName());
        vo.setNameZh(c.getNameZh());
        vo.setSlug(c.getSlug());
        vo.setIcon(c.getIcon());
        return vo;
    }

    private TagVO toTagVO(ArtifactTag t) {
        TagVO vo = new TagVO();
        vo.setId(t.getId());
        vo.setName(t.getName());
        vo.setNameZh(t.getNameZh());
        vo.setSlug(t.getSlug());
        return vo;
    }

    private ArtifactImageVO toImageVO(ArtifactImage i) {
        ArtifactImageVO vo = new ArtifactImageVO();
        vo.setId(i.getId());
        vo.setUrl(i.getUrl());
        vo.setCaption(i.getCaption());
        vo.setCaptionZh(i.getCaptionZh());
        vo.setYear(i.getYear());
        return vo;
    }

    private ArtifactSourceVO toSourceVO(ArtifactSource s) {
        ArtifactSourceVO vo = new ArtifactSourceVO();
        vo.setId(s.getId());
        vo.setTitle(s.getTitle());
        vo.setUrl(s.getUrl());
        vo.setType(s.getType());
        vo.setYear(s.getYear());
        return vo;
    }

    private TimelineEventVO toTimelineEventVO(ArtifactTimelineEvent e) {
        TimelineEventVO vo = new TimelineEventVO();
        vo.setId(e.getId());
        vo.setEventDate(e.getEventDate());
        vo.setEventYear(e.getEventYear());
        vo.setEventMonth(e.getEventMonth());
        vo.setTitle(e.getTitle());
        vo.setTitleZh(e.getTitleZh());
        vo.setDescription(e.getDescription());
        vo.setDescriptionZh(e.getDescriptionZh());
        vo.setType(e.getType());
        return vo;
    }
}
