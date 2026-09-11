<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getArtifact } from '@/api/artifact'
import type { ArtifactDetail } from '@/types/artifact'

const route = useRoute()
const router = useRouter()

const artifact = ref<ArtifactDetail | null>(null)
const loading = ref(true)
const error = ref('')
const lightboxVisible = ref(false)
const lightboxIndex = ref(0)

const sourceTypeLabel: Record<number, string> = {
  1: 'Website',
  2: 'News',
  3: 'Book',
  4: 'Archive',
  5: 'Interview',
}

const timelineTypeLabel: Record<number, string> = {
  1: 'Launch',
  2: 'Milestone',
  3: 'Decline',
  4: 'Closure',
}

const timelineTypeColor: Record<number, string> = {
  1: 'var(--era-2000s)',
  2: 'var(--color-accent)',
  3: 'var(--color-accent-warm)',
  4: 'var(--color-ghost)',
}

const eraLabel = computed(() => {
  const y = artifact.value?.foundedYear
  if (!y) return ''
  if (y < 2000) return '1990s'
  if (y < 2010) return '2000s'
  if (y < 2020) return '2010s'
  return '2020s'
})

const eraColor = computed(() => {
  const map: Record<string, string> = {
    '1990s': 'var(--era-1990s)',
    '2000s': 'var(--era-2000s)',
    '2010s': 'var(--era-2010s)',
    '2020s': 'var(--era-2020s)',
  }
  return map[eraLabel.value] || 'var(--color-text-muted)'
})

const archiveNumber = computed(() => {
  if (!artifact.value) return ''
  return `IAM-${String(artifact.value.id).padStart(4, '0')}`
})

const galleryUrls = computed(() =>
  artifact.value?.images.map(img => img.url) ?? []
)

function openLightbox(idx: number) {
  lightboxIndex.value = idx
  lightboxVisible.value = true
}

onMounted(async () => {
  const slug = route.params.slug as string
  try {
    artifact.value = await getArtifact(slug)
  } catch (e: unknown) {
    error.value = e instanceof Error ? e.message : 'Failed to load artifact'
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <div class="detail-page">
    <div v-if="loading" class="loading-state wide-column">
      <el-skeleton :rows="8" animated />
    </div>

    <div v-else-if="error" class="error-state wide-column">
      <el-result icon="error" :title="error">
        <template #extra>
          <el-button @click="router.push('/')">← Return to Archive</el-button>
        </template>
      </el-result>
    </div>
    <template v-else-if="artifact">
      <!-- Back Navigation -->
      <nav class="archive-nav">
        <div class="wide-column archive-nav-inner">
          <button class="back-link" @click="router.push('/')">← BACK TO ARCHIVE</button>
          <span class="nav-archive-no">{{ archiveNumber }}</span>
        </div>
      </nav>

      <!-- Hero Cover -->
      <div class="artifact-hero" :class="{ 'is-ghost': artifact.status === 2 }">
        <div class="hero-bg">
          <img
            v-if="artifact.coverImageUrl"
            :src="artifact.coverImageUrl"
            :alt="artifact.name"
          />
          <div v-else class="hero-placeholder">
            <span class="placeholder-label">IMAGE UNAVAILABLE</span>
          </div>
        </div>
        <div class="hero-gradient" />
        <div class="hero-top-bar">
          <div class="wide-column hero-top-inner">
            <span class="museum-label">INTERNET ARCHAEOLOGY MUSEUM</span>
            <span class="hero-archive-no">{{ archiveNumber }}</span>
          </div>
        </div>
        <div class="hero-bottom-bar">
          <div class="wide-column hero-bottom-inner">
            <div class="hero-chips">
              <span class="era-chip" :style="{ background: eraColor }">{{ eraLabel }}</span>
              <span
                class="status-chip"
                :class="artifact.status === 2 ? 'chip-ghost' : 'chip-active'"
              >{{ artifact.status === 2 ? 'GHOST' : 'ACTIVE' }}</span>
              <span class="category-chip">{{ artifact.category?.nameZh || artifact.category?.name }}</span>
            </div>
            <h1 class="hero-name">{{ artifact.nameZh || artifact.name }}</h1>
            <p v-if="artifact.nameZh" class="hero-name-en">{{ artifact.name }}</p>
            <p class="hero-lifespan">
              <span v-if="artifact.foundedYear">{{ artifact.foundedYear }}</span>
              <span v-if="artifact.closedYear"> – {{ artifact.closedYear }}</span>
              <span v-if="artifact.country"> · {{ artifact.country }}</span>
            </p>
          </div>
        </div>
      </div>

      <!-- Status Declaration Banner -->
      <div
        class="status-bar"
        :class="artifact.status === 2 ? 'status-bar--ghost' : 'status-bar--active'"
      >
        <div class="wide-column status-bar-inner">
          <span class="status-label">{{ artifact.status === 2 ? 'GHOST ARTIFACT' : 'ACTIVE ARTIFACT' }}</span>
          <span class="status-desc">
            <template v-if="artifact.status === 2">
              No longer part of the living web — preserved as digital archaeological heritage · 已从现实网络消失
            </template>
            <template v-else>
              Currently part of the living web · 仍是现实网络的一部分
            </template>
          </span>
        </div>
      </div>

      <!-- Main Body -->
      <div class="detail-body wide-column">
        <main class="detail-main">

          <!-- Tags -->
          <div v-if="artifact.tags?.length" class="tags-row">
            <span
              v-for="tag in artifact.tags"
              :key="tag.id"
              class="artifact-tag"
            >{{ tag.nameZh || tag.name }}</span>
          </div>

          <!-- About / Description -->
          <section
            v-if="artifact.description || artifact.descriptionZh"
            class="archive-section"
          >
            <h2 class="archive-section-title">ABOUT THIS ARTIFACT</h2>
            <p v-if="artifact.descriptionZh" class="text-zh">{{ artifact.descriptionZh }}</p>
            <p v-if="artifact.description" class="text-en">{{ artifact.description }}</p>
          </section>

          <!-- What Happened – Narrative -->
          <section
            v-if="artifact.whatHappened || artifact.whatHappenedZh"
            class="archive-section narrative-section"
          >
            <h2 class="archive-section-title">WHAT HAPPENED</h2>
            <div class="narrative-body">
              <p v-if="artifact.whatHappenedZh" class="text-zh narrative-lead">{{ artifact.whatHappenedZh }}</p>
              <p v-if="artifact.whatHappened" class="text-en">{{ artifact.whatHappened }}</p>
            </div>
          </section>

          <!-- Significance -->
          <section
            v-if="artifact.significance || artifact.significanceZh"
            class="archive-section"
          >
            <h2 class="archive-section-title">HISTORICAL SIGNIFICANCE</h2>
            <p v-if="artifact.significanceZh" class="text-zh">{{ artifact.significanceZh }}</p>
            <p v-if="artifact.significance" class="text-en">{{ artifact.significance }}</p>
          </section>

          <!-- Timeline -->
          <section
            v-if="artifact.timelineEvents?.length"
            class="archive-section"
          >
            <h2 class="archive-section-title">CHRONOLOGICAL RECORD</h2>
            <div class="archive-timeline">
              <div
                v-for="(event, idx) in artifact.timelineEvents"
                :key="event.id"
                class="tl-item"
                :class="{ 'tl-item--last': idx === artifact.timelineEvents.length - 1 }"
              >
                <div class="tl-spine">
                  <div
                    class="tl-node"
                    :style="{ background: timelineTypeColor[event.type] || 'var(--color-accent)' }"
                  />
                  <div v-if="idx < artifact.timelineEvents.length - 1" class="tl-line" />
                </div>
                <div class="tl-content">
                  <div class="tl-meta">
                    <span class="tl-year">{{ event.eventYear }}</span>
                    <span
                      class="tl-type-badge"
                      :style="{ color: timelineTypeColor[event.type] || 'var(--color-accent)' }"
                    >{{ timelineTypeLabel[event.type] || 'Event' }}</span>
                  </div>
                  <h4 class="tl-title">{{ event.titleZh || event.title }}</h4>
                  <p v-if="event.descriptionZh" class="tl-desc">{{ event.descriptionZh }}</p>
                  <p v-if="event.description" class="tl-desc tl-desc-en">{{ event.description }}</p>
                </div>
              </div>
            </div>
          </section>
          <!-- Gallery -->
          <section
            v-if="artifact.images?.length"
            class="archive-section"
          >
            <h2 class="archive-section-title">ARCHIVE GALLERY</h2>
            <div class="archive-gallery">
              <figure
                v-for="(img, idx) in artifact.images"
                :key="img.id"
                class="gallery-figure"
                @click="openLightbox(idx)"
              >
                <div class="gallery-img-wrap">
                  <img :src="img.url" :alt="img.captionZh || img.caption || ''" loading="lazy" />
                  <div class="gallery-hover-overlay">
                    <span class="gallery-zoom-icon">⊕</span>
                  </div>
                </div>
                <figcaption v-if="img.captionZh || img.caption" class="gallery-caption">
                  <span>{{ img.captionZh || img.caption }}</span>
                  <span v-if="img.year" class="caption-year">{{ img.year }}</span>
                </figcaption>
              </figure>
            </div>
          </section>

          <!-- Archival Sources -->
          <section
            v-if="artifact.sources?.length"
            class="archive-section"
          >
            <h2 class="archive-section-title">ARCHIVAL SOURCES</h2>
            <ol class="sources-list">
              <li
                v-for="(source, idx) in artifact.sources"
                :key="source.id"
                class="source-item"
              >
                <span class="source-index">[{{ String(idx + 1).padStart(2, '0') }}]</span>
                <div class="source-body">
                  <div class="source-header">
                    <span class="source-type-badge">{{ sourceTypeLabel[source.type] || 'Reference' }}</span>
                    <span v-if="source.year" class="source-year">{{ source.year }}</span>
                  </div>
                  <a v-if="source.url" :href="source.url" target="_blank" rel="noopener noreferrer" class="source-title source-link">{{ source.title }} ↗</a>
                  <span v-else class="source-title">{{ source.title }}</span>
                </div>
              </li>
            </ol>
          </section>

        </main>

        <!-- Sidebar -->
        <aside class="detail-sidebar">
          <div class="archive-record-card">
            <div class="archive-record-header">
              <span class="record-label">ARCHIVE RECORD</span>
              <span class="record-no">{{ archiveNumber }}</span>
            </div>
            <dl class="record-dl">
              <template v-if="artifact.foundedYear">
                <dt>Founded</dt>
                <dd>{{ artifact.foundedYear }}</dd>
              </template>
              <template v-if="artifact.closedYear">
                <dt>Closed</dt>
                <dd>{{ artifact.closedYear }}</dd>
              </template>
              <template v-if="artifact.country">
                <dt>Country</dt>
                <dd>{{ artifact.country }}</dd>
              </template>
              <template v-if="artifact.category">
                <dt>Category</dt>
                <dd>{{ artifact.category.nameZh || artifact.category.name }}</dd>
              </template>
              <dt>Views</dt>
              <dd>{{ artifact.viewCount.toLocaleString() }}</dd>
              <dt>Memories</dt>
              <dd>{{ artifact.memoryCount.toLocaleString() }}</dd>
            </dl>

            <div v-if="artifact.websiteUrl || artifact.archiveUrl" class="record-links">
              <a v-if="artifact.websiteUrl" :href="artifact.websiteUrl" target="_blank" rel="noopener noreferrer" class="record-link">
                <span class="record-link-label">WEBSITE</span>
                <span class="record-link-arrow">↗</span>
              </a>
              <a v-if="artifact.archiveUrl" :href="artifact.archiveUrl" target="_blank" rel="noopener noreferrer" class="record-link">
                <span class="record-link-label">INTERNET ARCHIVE</span>
                <span class="record-link-arrow">↗</span>
              </a>
            </div>
          </div>

          <button class="back-btn-sidebar" @click="router.push('/')">← RETURN TO COLLECTION</button>
        </aside>
      </div>

    </template>
    <!-- Lightbox -->
    <el-dialog
      v-model="lightboxVisible"
      :title="artifact?.images[lightboxIndex]?.captionZh || artifact?.images[lightboxIndex]?.caption || ''"
      width="90%"
      align-center
    >
      <img v-if="galleryUrls[lightboxIndex]" :src="galleryUrls[lightboxIndex]" alt="" class="lightbox-img" />
      <div v-if="artifact?.images[lightboxIndex]?.captionZh || artifact?.images[lightboxIndex]?.caption" class="lightbox-caption">
        {{ artifact?.images[lightboxIndex]?.captionZh || artifact?.images[lightboxIndex]?.caption }}
        <span v-if="artifact?.images[lightboxIndex]?.year"> · {{ artifact?.images[lightboxIndex]?.year }}</span>
      </div>
    </el-dialog>
  </div>
</template>

<style scoped>
.loading-state,
.error-state {
  padding: var(--space-12) 0;
}

/* Back Navigation */
.archive-nav {
  background: var(--color-surface);
  border-bottom: 1px solid var(--color-border);
}
.archive-nav-inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 44px;
}
.back-link {
  background: none;
  border: none;
  font-family: 'Inter', sans-serif;
  font-size: 11px;
  font-weight: 600;
  letter-spacing: 0.12em;
  color: var(--color-text-muted);
  cursor: pointer;
  padding: 0;
  transition: color 0.2s;
}
.back-link:hover {
  color: var(--color-accent);
}
.nav-archive-no {
  font-family: 'Courier New', monospace;
  font-size: 11px;
  color: var(--color-text-muted);
  letter-spacing: 0.08em;
}

/* Hero */
.artifact-hero {
  position: relative;
  height: 480px;
  overflow: hidden;
  background: #1a1a1a;
}
.artifact-hero.is-ghost {
  filter: saturate(0.25) brightness(0.85);
}
.hero-bg {
  position: absolute;
  inset: 0;
}
.hero-bg img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  opacity: 0.85;
  transition: opacity 0.3s, transform 0.6s;
}
.artifact-hero:hover .hero-bg img {
  opacity: 1;
  transform: scale(1.015);
}
.hero-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--color-bg-alt);
}
.placeholder-label {
  font-family: 'Inter', sans-serif;
  font-size: 12px;
  letter-spacing: 0.15em;
  color: var(--color-text-muted);
}
.hero-gradient {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    to top,
    rgba(10, 10, 10, 0.85) 0%,
    rgba(10, 10, 10, 0.35) 50%,
    rgba(10, 10, 10, 0.15) 100%
  );
}
.hero-top-bar {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
}
.hero-top-inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-top: var(--space-4);
  padding-bottom: var(--space-4);
}
.museum-label {
  font-family: 'Inter', sans-serif;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.2em;
  color: rgba(255, 255, 255, 0.65);
}
.hero-archive-no {
  font-family: 'Courier New', monospace;
  font-size: 12px;
  color: rgba(255, 255, 255, 0.5);
  letter-spacing: 0.1em;
}
.hero-bottom-bar {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
}
.hero-bottom-inner {
  padding-bottom: var(--space-8);
}
.hero-chips {
  display: flex;
  gap: var(--space-2);
  flex-wrap: wrap;
  margin-bottom: var(--space-3);
}
.era-chip {
  font-family: 'Inter', sans-serif;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.1em;
  padding: 3px 10px;
  border-radius: 2px;
  color: #fff;
}
.status-chip {
  font-family: 'Inter', sans-serif;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.15em;
  padding: 3px 10px;
  border-radius: 2px;
}
.chip-active {
  background: rgba(74, 103, 65, 0.7);
  color: #c8e6c0;
  border: 1px solid rgba(200, 230, 192, 0.3);
}
.chip-ghost {
  background: rgba(100, 100, 100, 0.5);
  color: rgba(255, 255, 255, 0.7);
  border: 1px solid rgba(255, 255, 255, 0.15);
}
.category-chip {
  font-family: 'Inter', sans-serif;
  font-size: 10px;
  letter-spacing: 0.05em;
  padding: 3px 10px;
  border-radius: 2px;
  background: rgba(255, 255, 255, 0.12);
  color: rgba(255, 255, 255, 0.75);
  border: 1px solid rgba(255, 255, 255, 0.15);
}
.hero-name {
  font-family: 'Georgia', 'Source Han Serif SC', serif;
  font-size: 42px;
  font-weight: 700;
  color: #fff;
  line-height: 1.2;
  margin-bottom: var(--space-2);
  text-shadow: 0 2px 8px rgba(0, 0, 0, 0.5);
}
.hero-name-en {
  font-family: 'Georgia', serif;
  font-size: 18px;
  color: rgba(255, 255, 255, 0.65);
  font-style: italic;
  margin-bottom: var(--space-2);
}
.hero-lifespan {
  font-family: 'Courier New', monospace;
  font-size: 14px;
  color: rgba(255, 255, 255, 0.5);
  letter-spacing: 0.05em;
}

/* Status bar */
.status-bar {
  border-bottom: 1px solid var(--color-border);
}
.status-bar--active {
  background: #f3f6f2;
  border-left: 4px solid var(--era-1990s);
}
.status-bar--ghost {
  background: #f0eeec;
  border-left: 4px solid var(--color-ghost);
}
.status-bar-inner {
  display: flex;
  align-items: baseline;
  gap: var(--space-4);
  padding: var(--space-3) 0;
  flex-wrap: wrap;
}
.status-label {
  font-family: 'Inter', sans-serif;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.15em;
  color: var(--color-text-secondary);
  white-space: nowrap;
}
.status-desc {
  font-size: 13px;
  color: var(--color-text-muted);
  font-style: italic;
}

/* Body layout */
.detail-body {
  display: grid;
  grid-template-columns: 1fr 280px;
  gap: var(--space-12);
  padding-top: var(--space-8);
  padding-bottom: var(--space-16);
  align-items: start;
}
@media (max-width: 900px) {
  .detail-body {
    grid-template-columns: 1fr;
    gap: var(--space-8);
  }
  .detail-sidebar {
    order: -1;
  }
}

/* Tags */
.tags-row {
  display: flex;
  flex-wrap: wrap;
  gap: var(--space-2);
  margin-bottom: var(--space-8);
}
.artifact-tag {
  font-family: 'Inter', sans-serif;
  font-size: 11px;
  letter-spacing: 0.05em;
  padding: 3px 10px;
  border: 1px solid var(--color-border);
  border-radius: 2px;
  color: var(--color-text-muted);
  background: var(--color-surface);
}

/* Archive Sections */
.archive-section {
  margin-bottom: var(--space-12);
}
.archive-section-title {
  font-family: 'Inter', sans-serif;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.2em;
  color: var(--color-text-muted);
  margin-bottom: var(--space-4);
  padding-bottom: var(--space-3);
  border-bottom: 1px solid var(--color-border);
}
.text-zh {
  font-family: 'PingFang SC', 'Source Han Serif SC', serif;
  font-size: 16px;
  line-height: 1.9;
  color: var(--color-text-primary);
  margin-bottom: var(--space-4);
}
.text-en {
  font-family: 'Georgia', serif;
  font-size: 14px;
  font-style: italic;
  color: var(--color-text-secondary);
  line-height: 1.8;
  margin-bottom: var(--space-4);
}

/* Narrative - What Happened */
.narrative-section {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-left: 4px solid var(--color-accent-warm);
  padding: var(--space-6);
  border-radius: 0 4px 4px 0;
}
.narrative-section .archive-section-title {
  border-bottom-color: rgba(139, 69, 19, 0.2);
}
.narrative-lead {
  font-size: 17px;
  line-height: 2;
}
.narrative-body .text-en {
  border-top: 1px solid var(--color-border);
  padding-top: var(--space-4);
  margin-top: var(--space-2);
}

/* Timeline */
.archive-timeline {
  padding-left: 0;
}
.tl-item {
  display: grid;
  grid-template-columns: 40px 1fr;
  gap: var(--space-4);
}
.tl-spine {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 4px;
}
.tl-node {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  flex-shrink: 0;
  border: 2px solid var(--color-bg);
  box-shadow: 0 0 0 1px var(--color-border);
}
.tl-line {
  width: 1px;
  flex: 1;
  min-height: 32px;
  background: var(--color-border);
  margin-top: 4px;
}
.tl-content {
  padding-bottom: var(--space-8);
}
.tl-item--last .tl-content {
  padding-bottom: 0;
}
.tl-meta {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  margin-bottom: var(--space-2);
}
.tl-year {
  font-family: 'Courier New', monospace;
  font-size: 20px;
  font-weight: 700;
  color: var(--color-text-primary);
  letter-spacing: 0.03em;
  line-height: 1;
}
.tl-type-badge {
  font-family: 'Inter', sans-serif;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.12em;
  text-transform: uppercase;
}
.tl-title {
  font-family: 'Georgia', serif;
  font-size: 16px;
  font-weight: 600;
  color: var(--color-text-primary);
  margin-bottom: var(--space-2);
}
.tl-desc {
  font-size: 14px;
  color: var(--color-text-secondary);
  line-height: 1.7;
  margin-bottom: var(--space-1);
}
.tl-desc-en {
  font-style: italic;
  color: var(--color-text-muted);
  margin-top: var(--space-1);
}

/* Gallery */
.archive-gallery {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: var(--space-4);
}
.gallery-figure {
  cursor: pointer;
  border: 1px solid var(--color-border);
  background: var(--color-surface);
  overflow: hidden;
  margin: 0;
}
.gallery-img-wrap {
  position: relative;
  overflow: hidden;
  aspect-ratio: 4/3;
}
.gallery-img-wrap img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.35s ease;
}
.gallery-figure:hover .gallery-img-wrap img {
  transform: scale(1.04);
}
.gallery-hover-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.25s;
}
.gallery-figure:hover .gallery-hover-overlay {
  background: rgba(0, 0, 0, 0.25);
}
.gallery-zoom-icon {
  font-size: 28px;
  color: #fff;
  opacity: 0;
  transform: scale(0.8);
  transition: opacity 0.25s, transform 0.25s;
  line-height: 1;
  font-family: 'Courier New', monospace;
}
.gallery-figure:hover .gallery-zoom-icon {
  opacity: 1;
  transform: scale(1);
}
.gallery-caption {
  padding: var(--space-2) var(--space-3);
  font-size: 12px;
  color: var(--color-text-muted);
  display: flex;
  justify-content: space-between;
  gap: var(--space-2);
  border-top: 1px solid var(--color-border);
}
.caption-year {
  font-family: 'Courier New', monospace;
  white-space: nowrap;
  flex-shrink: 0;
}

/* Sources */
.sources-list {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: var(--space-4);
}
.source-item {
  display: grid;
  grid-template-columns: 44px 1fr;
  gap: var(--space-3);
  align-items: start;
  padding-bottom: var(--space-4);
  border-bottom: 1px solid var(--color-border);
}
.source-item:last-child {
  border-bottom: none;
  padding-bottom: 0;
}
.source-index {
  font-family: 'Courier New', monospace;
  font-size: 13px;
  color: var(--color-text-muted);
  padding-top: 2px;
}
.source-body {
  display: flex;
  flex-direction: column;
  gap: var(--space-1);
}
.source-header {
  display: flex;
  align-items: center;
  gap: var(--space-2);
  margin-bottom: var(--space-1);
}
.source-type-badge {
  font-family: 'Inter', sans-serif;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--color-text-muted);
  background: var(--color-bg-alt);
  padding: 2px 8px;
  border: 1px solid var(--color-border);
  border-radius: 2px;
}
.source-year {
  font-family: 'Courier New', monospace;
  font-size: 12px;
  color: var(--color-text-muted);
}
.source-title {
  font-family: 'Georgia', serif;
  font-size: 14px;
  color: var(--color-text-secondary);
  line-height: 1.5;
}
.source-link {
  color: var(--color-accent);
}
.source-link:hover {
  text-decoration: underline;
}

/* Sidebar */
.archive-record-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  margin-bottom: var(--space-4);
  position: sticky;
  top: 80px;
}
.archive-record-header {
  background: var(--color-bg-alt);
  border-bottom: 1px solid var(--color-border);
  padding: var(--space-3) var(--space-4);
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.record-label {
  font-family: 'Inter', sans-serif;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.2em;
  color: var(--color-text-muted);
}
.record-no {
  font-family: 'Courier New', monospace;
  font-size: 12px;
  color: var(--color-text-secondary);
}
.record-dl {
  padding: var(--space-4);
  display: grid;
  grid-template-columns: auto 1fr;
  row-gap: var(--space-3);
  column-gap: var(--space-4);
}
.record-dl dt {
  font-family: 'Inter', sans-serif;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.12em;
  color: var(--color-text-muted);
  text-transform: uppercase;
  padding-top: 2px;
  white-space: nowrap;
}
.record-dl dd {
  font-family: 'Courier New', monospace;
  font-size: 14px;
  color: var(--color-text-primary);
}
.record-links {
  border-top: 1px solid var(--color-border);
  padding: var(--space-3) var(--space-4);
  display: flex;
  flex-direction: column;
  gap: var(--space-2);
}
.record-link {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--space-2) var(--space-3);
  background: var(--color-bg-alt);
  border: 1px solid var(--color-border);
  text-decoration: none;
  transition: background 0.2s, border-color 0.2s;
}
.record-link:hover {
  background: var(--color-bg);
  border-color: var(--color-accent);
  text-decoration: none;
}
.record-link-label {
  font-family: 'Inter', sans-serif;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.12em;
  color: var(--color-text-secondary);
}
.record-link-arrow {
  font-size: 14px;
  color: var(--color-accent);
}
.back-btn-sidebar {
  width: 100%;
  background: none;
  border: 1px solid var(--color-border);
  padding: var(--space-3) var(--space-4);
  font-family: 'Inter', sans-serif;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.15em;
  color: var(--color-text-muted);
  cursor: pointer;
  transition: color 0.2s, border-color 0.2s;
}
.back-btn-sidebar:hover {
  color: var(--color-accent);
  border-color: var(--color-accent);
}

/* Lightbox */
.lightbox-img {
  width: 100%;
  max-height: 80vh;
  object-fit: contain;
}
.lightbox-caption {
  margin-top: var(--space-3);
  font-family: 'Georgia', serif;
  font-size: 14px;
  color: var(--color-text-muted);
  font-style: italic;
  text-align: center;
}

/* Responsive */
@media (max-width: 768px) {
  .artifact-hero {
    height: 320px;
  }
  .hero-name {
    font-size: 28px;
  }
  .hero-name-en {
    font-size: 15px;
  }
  .archive-gallery {
    grid-template-columns: repeat(2, 1fr);
  }
}
@media (max-width: 480px) {
  .artifact-hero {
    height: 260px;
  }
  .hero-name {
    font-size: 22px;
  }
  .archive-gallery {
    grid-template-columns: 1fr;
  }
  .detail-body {
    padding-top: var(--space-6);
  }
  .tl-year {
    font-size: 16px;
  }
}
</style>
