package com.museum.module.artifact.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class ArtifactCreateDTO {

    @NotBlank(message = "slug is required")
    @Size(max = 200)
    private String slug;

    @NotBlank(message = "name is required")
    @Size(max = 200)
    private String name;

    @Size(max = 200)
    private String nameZh;

    @NotNull(message = "categoryId is required")
    private Long categoryId;

    /** 1=active  2=ghost  3=draft — defaults to draft on creation */
    private Integer status;

    private Short foundedYear;
    private Short closedYear;
    private String country;
    private String description;
    private String descriptionZh;
    private String significance;
    private String significanceZh;
    private String whatHappened;
    private String whatHappenedZh;
    private String coverImageUrl;
    private String websiteUrl;
    private String archiveUrl;
}
