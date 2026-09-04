package com.museum.module.artifact.enums;

import lombok.Getter;

@Getter
public enum TimelineEventType {
    LAUNCH(1, "Launch"),
    MILESTONE(2, "Milestone"),
    DECLINE(3, "Decline"),
    CLOSURE(4, "Closure");

    private final int code;
    private final String label;

    TimelineEventType(int code, String label) {
        this.code = code;
        this.label = label;
    }
}
