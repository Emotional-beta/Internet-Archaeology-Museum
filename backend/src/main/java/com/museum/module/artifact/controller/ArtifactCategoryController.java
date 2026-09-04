package com.museum.module.artifact.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.museum.common.response.Result;
import com.museum.module.artifact.entity.ArtifactCategory;
import com.museum.module.artifact.mapper.ArtifactCategoryMapper;
import com.museum.module.artifact.vo.CategoryVO;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/categories")
@RequiredArgsConstructor
public class ArtifactCategoryController {

    private final ArtifactCategoryMapper categoryMapper;

    @GetMapping
    public Result<List<CategoryVO>> list() {
        List<ArtifactCategory> categories = categoryMapper.selectList(
                new LambdaQueryWrapper<ArtifactCategory>().orderByAsc(ArtifactCategory::getSortOrder)
        );
        List<CategoryVO> vos = categories.stream().map(c -> {
            CategoryVO vo = new CategoryVO();
            vo.setId(c.getId());
            vo.setName(c.getName());
            vo.setNameZh(c.getNameZh());
            vo.setSlug(c.getSlug());
            vo.setIcon(c.getIcon());
            return vo;
        }).collect(Collectors.toList());
        return Result.ok(vos);
    }
}
