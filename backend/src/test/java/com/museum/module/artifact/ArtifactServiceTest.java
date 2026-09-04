package com.museum.module.artifact;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.museum.common.exception.BusinessException;
import com.museum.common.response.PageResult;
import com.museum.module.artifact.dto.ArtifactCreateDTO;
import com.museum.module.artifact.dto.ArtifactQueryDTO;
import com.museum.module.artifact.entity.*;
import com.museum.module.artifact.mapper.*;
import com.museum.module.artifact.service.ArtifactService;
import com.museum.module.artifact.vo.ArtifactDetailVO;
import com.museum.module.artifact.vo.ArtifactListVO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ArtifactServiceTest {

    @Mock ArtifactMapper artifactMapper;
    @Mock ArtifactCategoryMapper categoryMapper;
    @Mock ArtifactTagMapper tagMapper;
    @Mock ArtifactImageMapper imageMapper;
    @Mock ArtifactSourceMapper sourceMapper;
    @Mock ArtifactTimelineEventMapper timelineEventMapper;

    @InjectMocks
    ArtifactService service;

    private Artifact sampleArtifact;
    private ArtifactCategory sampleCategory;

    @BeforeEach
    void setUp() {
        sampleCategory = new ArtifactCategory();
        sampleCategory.setId(3L);
        sampleCategory.setName("Social Network");
        sampleCategory.setNameZh("社交网络");
        sampleCategory.setSlug("social");

        sampleArtifact = new Artifact();
        sampleArtifact.setId(1L);
        sampleArtifact.setSlug("renren");
        sampleArtifact.setName("Renren");
        sampleArtifact.setNameZh("人人网");
        sampleArtifact.setCategoryId(3L);
        sampleArtifact.setStatus(2);
        sampleArtifact.setFoundedYear((short) 2005);
        sampleArtifact.setViewCount(0);
        sampleArtifact.setMemoryCount(0);
    }

    // --- list ---

    @Test
    void list_returnsPageResult() {
        Page<Artifact> page = new Page<>(1, 20);
        page.setRecords(List.of(sampleArtifact));
        page.setTotal(1);

        when(artifactMapper.selectPage(any(), any())).thenReturn(page);
        when(categoryMapper.selectBatchIds(anyList())).thenReturn(List.of(sampleCategory));

        PageResult<ArtifactListVO> result = service.list(new ArtifactQueryDTO());

        assertThat(result.getTotal()).isEqualTo(1);
        assertThat(result.getList()).hasSize(1);
        assertThat(result.getList().get(0).getSlug()).isEqualTo("renren");
        assertThat(result.getList().get(0).getCategory().getSlug()).isEqualTo("social");
    }

    @Test
    void list_emptyResult_returnsEmptyList() {
        Page<Artifact> page = new Page<>(1, 20);
        page.setRecords(Collections.emptyList());
        page.setTotal(0);

        when(artifactMapper.selectPage(any(), any())).thenReturn(page);

        PageResult<ArtifactListVO> result = service.list(new ArtifactQueryDTO());

        assertThat(result.getTotal()).isEqualTo(0);
        assertThat(result.getList()).isEmpty();
    }

    // --- getBySlug ---

    @Test
    void getBySlug_returnsDetailVO() {
        when(artifactMapper.findBySlug("renren")).thenReturn(Optional.of(sampleArtifact));
        when(artifactMapper.update(isNull(), any())).thenReturn(1);
        when(categoryMapper.selectById(3L)).thenReturn(sampleCategory);
        when(tagMapper.findByArtifactId(1L)).thenReturn(Collections.emptyList());
        when(imageMapper.findByArtifactId(1L)).thenReturn(Collections.emptyList());
        when(sourceMapper.findByArtifactId(1L)).thenReturn(Collections.emptyList());
        when(timelineEventMapper.findByArtifactId(1L)).thenReturn(Collections.emptyList());

        ArtifactDetailVO vo = service.getBySlug("renren");

        assertThat(vo.getSlug()).isEqualTo("renren");
        assertThat(vo.getName()).isEqualTo("Renren");
        assertThat(vo.getCategory().getSlug()).isEqualTo("social");
    }

    @Test
    void getBySlug_notFound_throwsBusinessException() {
        when(artifactMapper.findBySlug("missing")).thenReturn(Optional.empty());

        assertThatThrownBy(() -> service.getBySlug("missing"))
                .isInstanceOf(BusinessException.class)
                .hasMessageContaining("not found");
    }

    // --- create ---

    @Test
    void create_success_returnsDetailVO() {
        ArtifactCreateDTO dto = buildCreateDTO("new-artifact");

        when(artifactMapper.findBySlug("new-artifact")).thenReturn(Optional.empty());
        when(categoryMapper.selectById(3L)).thenReturn(sampleCategory);
        when(artifactMapper.insert(any(Artifact.class))).thenAnswer(inv -> {
            Artifact a = inv.getArgument(0);
            a.setId(99L);
            return 1;
        });

        // getBySlug is called after insert
        Artifact created = new Artifact();
        created.setId(99L);
        created.setSlug("new-artifact");
        created.setName("New Artifact");
        created.setCategoryId(3L);
        created.setStatus(3);
        created.setViewCount(0);
        created.setMemoryCount(0);

        when(artifactMapper.findBySlug("new-artifact"))
                .thenReturn(Optional.empty())          // first check: not exists
                .thenReturn(Optional.of(created));     // after insert: load detail

        when(artifactMapper.update(isNull(), any())).thenReturn(1);
        when(tagMapper.findByArtifactId(99L)).thenReturn(Collections.emptyList());
        when(imageMapper.findByArtifactId(99L)).thenReturn(Collections.emptyList());
        when(sourceMapper.findByArtifactId(99L)).thenReturn(Collections.emptyList());
        when(timelineEventMapper.findByArtifactId(99L)).thenReturn(Collections.emptyList());

        ArtifactDetailVO vo = service.create(dto, 1L);

        assertThat(vo.getSlug()).isEqualTo("new-artifact");
        verify(artifactMapper).insert(any(Artifact.class));
    }

    @Test
    void create_duplicateSlug_throwsBusinessException() {
        ArtifactCreateDTO dto = buildCreateDTO("renren");

        when(artifactMapper.findBySlug("renren")).thenReturn(Optional.of(sampleArtifact));

        assertThatThrownBy(() -> service.create(dto, 1L))
                .isInstanceOf(BusinessException.class)
                .hasMessageContaining("slug already exists");
    }

    // --- update ---

    @Test
    void update_notFound_throwsBusinessException() {
        when(artifactMapper.findBySlug("unknown")).thenReturn(Optional.empty());

        assertThatThrownBy(() -> service.update("unknown", buildCreateDTO("unknown")))
                .isInstanceOf(BusinessException.class)
                .hasMessageContaining("not found");
    }

    // --- helpers ---

    private ArtifactCreateDTO buildCreateDTO(String slug) {
        ArtifactCreateDTO dto = new ArtifactCreateDTO();
        dto.setSlug(slug);
        dto.setName("New Artifact");
        dto.setCategoryId(3L);
        return dto;
    }
}
