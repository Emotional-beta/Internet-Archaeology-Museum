package com.museum.module.artifact.controller;

import com.museum.common.response.PageResult;
import com.museum.common.response.Result;
import com.museum.module.artifact.dto.ArtifactCreateDTO;
import com.museum.module.artifact.dto.ArtifactQueryDTO;
import com.museum.module.artifact.service.ArtifactService;
import com.museum.module.artifact.vo.ArtifactDetailVO;
import com.museum.module.artifact.vo.ArtifactListVO;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/artifacts")
@RequiredArgsConstructor
public class ArtifactController {

    private final ArtifactService artifactService;

    @GetMapping
    public Result<PageResult<ArtifactListVO>> list(ArtifactQueryDTO query) {
        return Result.ok(artifactService.list(query));
    }

    @GetMapping("/{slug}")
    public Result<ArtifactDetailVO> getBySlug(@PathVariable String slug) {
        return Result.ok(artifactService.getBySlug(slug));
    }

    @PostMapping
    public Result<ArtifactDetailVO> create(@Valid @RequestBody ArtifactCreateDTO dto) {
        // TODO: get createdBy from security context once auth module is complete
        return Result.ok(artifactService.create(dto, null));
    }

    @PutMapping("/{slug}")
    public Result<ArtifactDetailVO> update(@PathVariable String slug,
                                           @Valid @RequestBody ArtifactCreateDTO dto) {
        return Result.ok(artifactService.update(slug, dto));
    }
}
