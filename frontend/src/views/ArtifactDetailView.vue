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

const sourceTypeLabel: Record<number, string> = {
  1: '网站 Website',
  2: '新闻 News',
  3: '书籍 Book',
  4: '存档 Archive',
  5: '访谈 Interview',
}

const timelineTypeLabel: Record<number, string> = {
  1: '诞生 Launch',
  2: '里程碑 Milestone',
  3: '衰退 Decline',
  4: '关闭 Closure',
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
  <div>
    <div v-if="loading" class="loading-state wide-column">
      <el-skeleton :rows="6" animated />
    </div>

    <div v-else-if="error" class="wide-column" style="padding: 48px 32px">
      <el-result icon="error" :title="error">
        <template #extra>
          <el-button @click="router.push('/')">返回首页 Back</el-button>
        </template>
      </el-result>
    </div>

    <template v-else-if="artifact">
      <!-- Cover -->
      <div class="artifact-cover" :class="{ 'is-ghost': artifact.status === 2 }">
        <img
          v-if="artifact.coverImageUrl"
          :src="artifact.coverImageUrl"
          :alt="artifact.name"
        />
        <div v-else class="cover-placeholder">
          <span>{{ artifact.nameZh || artifact.name }}</span>
        </div>
        <div class="cover-overlay">
          <div class="wide-column cover-inner">
            <div class="cover-badges">
              <span class="era-badge" :style="{ background: eraColor }">{{ eraLabel }}</span>
              <span v-if="artifact.status === 2" class="ghost-label">数字幽灵 Digital Ghost</span>
              <span class="category-badge">
                {{ artifact.category?.nameZh || artifact.category?.name }}
              </span>
            </div>
            <h1 class="cover-name">{{ artifact.nameZh || artifact.name }}</h1>
            <p v-if="artifact.nameZh" class="cover-name-en">{{ artifact.name }}</p>
            <p class="cover-years">
              <template v-if="artifact.foundedYear">{{ artifact.foundedYear }}</template>
              <template v-if="artifact.closedYear"> – {{ artifact.closedYear }}</template>
              <template v-if="artifact.country"> · {{ artifact.country }}</template>
            </p>
          </div>
        </div>
      </div>

      <!-- Body -->
      <div class="detail-body wide-column">
        <div class="detail-main">

          <!-- Tags -->
          <div v-if="artifact.tags?.length" class="detail-section">
            <el-tag
              v-for="tag in artifact.tags"
              :key="tag.id"
              size="small"
              effect="plain"
              style="margin-right: 6px"
            >
              {{ tag.nameZh || tag.name }}
            </el-tag>
          </div>

          <!-- Description -->
          <section v-if="artifact.description || artifact.descriptionZh" class="detail-section">
            <h2 class="section-title">关于 / About</h2>
            <p v-if="artifact.descriptionZh" class="text-block text-zh">{{ artifact.descriptionZh }}</p>
            <p v-if="artifact.description" class="text-block text-en">{{ artifact.description }}</p>
          </section>

          <!-- Significance -->
          <section v-if="artifact.significance || artifact.significanceZh" class="detail-section">
            <h2 class="section-title">历史意义 / Historical Significance</h2>
            <p v-if="artifact.significanceZh" class="text-block text-zh">{{ artifact.significanceZh }}</p>
            <p v-if="artifact.significance" class="text-block text-en">{{ artifact.significance }}</p>
          </section>

          <!-- Timeline -->
          <section v-if="artifact.timelineEvents?.length" class="detail-section">
            <h2 class="section-title">时间轴 / Timeline</h2>
            <div class="timeline">
              <div
                v-for="event in artifact.timelineEvents"
                :key="event.id"
                class="timeline-item"
              >
                <div
                  class="timeline-dot"
                  :style="{ background: timelineTypeColor[event.type] || 'var(--color-accent)' }"
                />
                <div class="timeline-content">
                  <span class="timeline-year">{{ event.eventYear }}</span>
                  <span class="timeline-type">{{ timelineTypeLabel[event.type] }}</span>
                  <h4 class="timeline-title">{{ event.titleZh || event.title }}</h4>
                  <p v-if="event.descriptionZh" class="timeline-desc">{{ event.descriptionZh }}</p>
                  <p v-if="event.description" class="timeline-desc timeline-desc-en">{{ event.description }}</p>
                </div>
              </div>
            </div>
          </section>

          <!-- What Happened -->
          <section v-if="artifact.whatHappened || artifact.whatHappenedZh" class="detail-section">
            <h2 class="section-title">最终命运 / What Happened</h2>
            <p v-if="artifact.whatHappenedZh" class="text-block text-zh">{{ artifact.whatHappenedZh }}</p>
            <p v-if="artifact.whatHappened" class="text-block text-en">{{ artifact.whatHappened }}</p>
          </section>

          <!-- Gallery -->
          <section v-if="artifact.images?.length" class="detail-section">
            <h2 class="section-title">图片 / Gallery</h2>
            <div class="gallery">
              <figure v-for="img in artifact.images" :key="img.id" class="gallery-item">
                <img :src="img.url" :alt="img.caption || ''" loading="lazy" />
                <figcaption v-if="img.captionZh || img.caption">
                  {{ img.captionZh || img.caption }}
                  <span v-if="img.year" class="img-year">{{ img.year }}</span>
                </figcaption>
              </figure>
            </div>
          </section>

          <!-- Sources -->
          <section v-if="artifact.sources?.length" class="detail-section">
            <h2 class="section-title">来源 / Sources</h2>
            <ul class="sources-list">
              <li v-for="source in artifact.sources" :key="source.id">
                <span class="source-type">{{ sourceTypeLabel[source.type] || 'Source' }}</span>
                <a v-if="source.url" :href="source.url" target="_blank" rel="noopener">
                  {{ source.title }}
                </a>
                <span v-else>{{ source.title }}</span>
                <span v-if="source.year" class="source-year">({{ source.year }})</span>
              </li>
            </ul>
          </section>

        </div>

        <!-- Sidebar -->
        <aside class="detail-sidebar">
          <div class="sidebar-card">
            <h3 class="sidebar-title">信息 / Info</h3>
            <dl class="info-list">
              <template v-if="artifact.foundedYear">
                <dt>创立 Founded</dt>
                <dd>{{ artifact.foundedYear }}</dd>
              </template>
              <template v-if="artifact.closedYear">
                <dt>关闭 Closed</dt>
                <dd>{{ artifact.closedYear }}</dd>
              </template>
              <template v-if="artifact.country">
                <dt>国家 Country</dt>
                <dd>{{ artifact.country }}</dd>
              </template>
              <dt>记忆 Memories</dt>
              <dd>{{ artifact.memoryCount }}</dd>
              <dt>浏览 Views</dt>
              <dd>{{ artifact.viewCount }}</dd>
            </dl>

            <div v-if="artifact.websiteUrl || artifact.archiveUrl" class="sidebar-links">
              <a
                v-if="artifact.websiteUrl"
                :href="artifact.websiteUrl"
                target="_blank"
                rel="noopener"
                class="sidebar-link"
              >
                官网 Website ↗
              </a>
              <a
                v-if="artifact.archiveUrl"
                :href="artifact.archiveUrl"
                target="_blank"
                rel="noopener"
                class="sidebar-link"
              >
                互联网存档 Archive ↗
              </a>
            </div>
          </div>

          <el-button
            class="back-btn"
            @click="router.push('/')"
            plain
          >
            ← 返回文物列表
          </el-button>
        </aside>
      </div>
    </template>
  </div>
</template>

<style scoped>
.loading-state {
  padding: var(--space-12) var(--space-8);
}

/* Cover */
.artifact-cover {
  position: relative;
  height: 340px;
  background: var(--color-bg-alt);
  overflow: hidden;
}
.artifact-cover.is-ghost {
  filter: saturate(0.4);
}
.artifact-cover img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.cover-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 48px;
  color: var(--color-border);
  font-family: 'PingFang SC', sans-serif;
}
.cover-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(to top, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.1) 60%, transparent 100%);
  display: flex;
  align-items: flex-end;
}
.cover-inner {
  padding-bottom: var(--space-8);
}
.cover-badges {
  display: flex;
  gap: var(--space-2);
  margin-bottom: var(--space-3);
  flex-wrap: wrap;
}
.era-badge {
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 3px;
  color: #fff;
  font-family: 'Inter', sans-serif;
}
.ghost-label {
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 3px;
  background: rgba(255,255,255,0.2);
  color: #fff;
  font-family: 'Inter', sans-serif;
}
.category-badge {
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 3px;
  background: rgba(255,255,255,0.15);
  color: rgba(255,255,255,0.9);
  font-family: 'Inter', sans-serif;
}
.cover-name {
  font-size: 32px;
  font-weight: 700;
  color: #fff;
  margin-bottom: var(--space-1);
}
.cover-name-en {
  font-size: 16px;
  color: rgba(255,255,255,0.7);
  font-style: italic;
  margin-bottom: var(--space-2);
}
.cover-years {
  font-size: 14px;
  color: rgba(255,255,255,0.6);
  font-family: 'Courier New', monospace;
}

/* Body layout */
.detail-body {
  display: grid;
  grid-template-columns: 1fr 280px;
  gap: var(--space-12);
  padding: var(--space-8) var(--space-8);
  align-items: start;
}

@media (max-width: 768px) {
  .detail-body {
    grid-template-columns: 1fr;
  }
  .detail-sidebar {
    order: -1;
  }
}

/* Sections */
.detail-section {
  margin-bottom: var(--space-12);
}
.section-title {
  font-size: 18px;
  font-weight: 600;
  margin-bottom: var(--space-4);
  padding-bottom: var(--space-2);
  border-bottom: 2px solid var(--color-border);
}
.text-block {
  margin-bottom: var(--space-4);
  line-height: 1.8;
}
.text-zh {
  font-family: 'PingFang SC', 'Source Han Serif SC', serif;
}
.text-en {
  font-style: italic;
  color: var(--color-text-secondary);
}

/* Timeline */
.timeline {
  position: relative;
  padding-left: var(--space-8);
}
.timeline::before {
  content: '';
  position: absolute;
  left: 10px;
  top: 8px;
  bottom: 8px;
  width: 2px;
  background: var(--color-border);
}
.timeline-item {
  position: relative;
  margin-bottom: var(--space-6);
}
.timeline-dot {
  position: absolute;
  left: -26px;
  top: 6px;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  border: 2px solid var(--color-surface);
}
.timeline-content { padding-left: var(--space-2); }
.timeline-year {
  font-size: 13px;
  font-family: 'Courier New', monospace;
  color: var(--color-text-muted);
  margin-right: var(--space-2);
}
.timeline-type {
  font-size: 11px;
  color: var(--color-text-muted);
  background: var(--color-bg-alt);
  padding: 1px 6px;
  border-radius: 3px;
  font-family: 'Inter', sans-serif;
}
.timeline-title {
  font-size: 15px;
  font-weight: 600;
  margin: var(--space-2) 0 var(--space-1);
}
.timeline-desc {
  font-size: 14px;
  color: var(--color-text-secondary);
  line-height: 1.6;
}
.timeline-desc-en {
  font-style: italic;
  margin-top: var(--space-1);
  color: var(--color-text-muted);
}

/* Gallery */
.gallery {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: var(--space-4);
}
.gallery-item {
  border: 1px solid var(--color-border);
  border-radius: 4px;
  overflow: hidden;
  background: var(--color-bg-alt);
}
.gallery-item img {
  width: 100%;
  height: 160px;
  object-fit: cover;
}
.gallery-item figcaption {
  padding: var(--space-2) var(--space-3);
  font-size: 12px;
  color: var(--color-text-muted);
  display: flex;
  justify-content: space-between;
}
.img-year { font-family: 'Courier New', monospace; }

/* Sources */
.sources-list {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: var(--space-3);
}
.sources-list li {
  font-size: 14px;
  display: flex;
  align-items: baseline;
  gap: var(--space-2);
}
.source-type {
  font-size: 11px;
  background: var(--color-bg-alt);
  color: var(--color-text-muted);
  padding: 1px 6px;
  border-radius: 3px;
  white-space: nowrap;
  font-family: 'Inter', sans-serif;
}
.source-year {
  color: var(--color-text-muted);
  font-size: 13px;
}

/* Sidebar */
.sidebar-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: 6px;
  padding: var(--space-4);
  margin-bottom: var(--space-4);
  position: sticky;
  top: 120px;
}
.sidebar-title {
  font-size: 14px;
  font-weight: 600;
  margin-bottom: var(--space-4);
  color: var(--color-text-secondary);
}
.info-list {
  display: grid;
  grid-template-columns: auto 1fr;
  gap: var(--space-2) var(--space-4);
  font-size: 13px;
}
.info-list dt {
  color: var(--color-text-muted);
  font-family: 'Inter', sans-serif;
}
.info-list dd {
  color: var(--color-text-primary);
  font-family: 'Courier New', monospace;
}
.sidebar-links {
  margin-top: var(--space-4);
  display: flex;
  flex-direction: column;
  gap: var(--space-2);
  padding-top: var(--space-4);
  border-top: 1px solid var(--color-border);
}
.sidebar-link {
  font-size: 13px;
  color: var(--color-accent);
  font-family: 'Inter', sans-serif;
}
.back-btn {
  width: 100%;
  font-family: 'Inter', sans-serif;
}
</style>
