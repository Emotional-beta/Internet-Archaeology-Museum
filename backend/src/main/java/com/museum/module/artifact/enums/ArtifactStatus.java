package com.museum.module.artifact.enums;

import lombok.Getter;

@Getter
public enum ArtifactStatus {
    ACTIVE(1, "Active"),
    GHOST(2, "Digital Ghost"),
    DRAFT(3, "Draft");

    private final int code;
    private final String label;

    ArtifactStatus(int code, String label) {
        this.code = code;
        this.label = label;
    }

    public static ArtifactStatus of(int code) {
        for (ArtifactStatus s : values()) {
            if (s.code == code) return s;
        }
        throw new IllegalArgumentException("Unknown artifact status: " + code);
    }
}
