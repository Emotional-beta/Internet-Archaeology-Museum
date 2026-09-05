<script setup lang="ts">
import { ref, reactive, watch, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { listArtifacts, listCategories } from '@/api/artifact'
import type { ArtifactListItem, Category } from '@/types/artifact'

const router = useRouter()

const artifacts = ref<ArtifactListItem[]>([])
const categories = ref<Category[]>([])
const total = ref(0)
const loading = ref(false)
const error = ref('')

const query = reactive({
  page: 1,
  pageSize: 18,
  category: '',
  era: '',
  q: '',
})

const eras = [
  { label: '1990s', value: '1990s' },
  { label: '2000s', value: '2000s' },
  { label: '2010s', value: '2010s' },
  { label: '2020s', value: '2020s' },
]

async function loadArtifacts() {
  loading.value = true
  error.value = ''
  try {
    const params = {
      page: query.page,
      pageSize: query.pageSize,
      ...(query.category && { category: query.category }),
      ...(query.era && { era: query.era }),
      ...(query.q && { q: query.q }),
    }
    const result = await listArtifacts(params)
    artifacts.value = result.list
    total.value = result.total
  } catch (e: unknown) {
    error.value = e instanceof Error ? e.message : 'Failed to load artifacts'
  } finally {
    loading.value = false
  }
}

function resetPage() {
  query.page = 1
  loadArtifacts()
}

function onPageChange(page: number) {
  query.page = page
  loadArtifacts()
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

function goToArtifact(slug: string) {
  router.push(`/artifacts/${slug}`)
}

function artifactEra(year: number | null): string {
  if (!year) return ''
  if (year < 2000) return '1990s'
  if (year < 2010) return '2000s'
  if (year < 2020) return '2010s'
  return '2020s'
}

const eraColorMap: Record<string, string> = {
  '1990s': 'var(--era-1990s)',
  '2000s': 'var(--era-2000s)',
  '2010s': 'var(--era-2010s)',
  '2020s': 'var(--era-2020s)',
}

function eraColor(era: string) {
  return eraColorMap[era] || 'var(--color-text-muted)'
}

onMounted(async () => {
  const [, cats] = await Promise.all([loadArtifacts(), listCategories()])
  categories.value = cats
})

let searchTimer: ReturnType<typeof setTimeout>
watch(() => query.q, () => {
  clearTimeout(searchTimer)
  searchTimer = setTimeout(resetPage, 400)
})
</script>

<template>
  <div>
    <!-- Hero -->
    <section class="hero">
      <div class="content-column">
        <h1 class="hero-title">Internet Archaeology Museum</h1>
        <p class="hero-sub">互联网考古博物馆</p>
        <p class="hero-desc">
          保存正在消失的互联网记忆 &nbsp;·&nbsp; Preserving the Internet's fading memory
        </p>
      </div>
    </section>

    <!-- Filters -->
    <section class="filters-bar">
      <div class="wide-column filters-inner">
        <el-input
          v-model="query.q"
          placeholder="搜索文物 / Search artifacts"
          clearable
          class="filter-search"
        />

        <div class="filter-group">
          <span class="filter-label">时代 Era</span>
          <el-radio-group v-model="query.era" @change="resetPage" size="small">
            <el-radio-button value="">全部</el-radio-button>
            <el-radio-button v-for="era in eras" :key="era.value" :value="era.value">
              {{ era.label }}
            </el-radio-button>
          </el-radio-group>
        </div>

        <div class="filter-group">
          <span class="filter-label">类型 Category</span>
          <el-select
            v-model="query.category"
            placeholder="全部分类"
            clearable
            size="small"
            @change="resetPage"
          >
            <el-option
              v-for="cat in categories"
              :key="cat.slug"
              :label="`${cat.nameZh || cat.name} / ${cat.name}`"
              :value="cat.slug"
            />
          </el-select>
        </div>
      </div>
    </section>

    <!-- Artifact Grid -->
    <section class="artifacts-section wide-column">
      <div v-if="error" class="state-box">
        <el-alert :title="error" type="error" show-icon :closable="false" />
      </div>

      <div v-else-if="loading && artifacts.length === 0" class="state-box">
        <el-skeleton :rows="4" animated />
      </div>

      <template v-else>
        <p class="result-count">共 {{ total }} 件文物 &nbsp;·&nbsp; {{ total }} artifacts</p>

        <div class="artifact-grid" v-loading="loading">
          <div
            v-for="artifact in artifacts"
            :key="artifact.id"
            class="artifact-card"
            @click="goToArtifact(artifact.slug)"
          >
            <div class="card-cover">
              <img
                v-if="artifact.coverImageUrl"
                :src="artifact.coverImageUrl"
                :alt="artifact.name"
                loading="lazy"
              />
              <div v-else class="card-cover-placeholder">
                <span>{{ artifact.nameZh || artifact.name }}</span>
              </div>
              <span v-if="artifact.status === 2" class="ghost-badge">幽灵 Ghost</span>
            </div>

            <div class="card-body">
              <div class="card-meta">
                <span
                  class="era-dot"
                  :style="{ background: eraColor(artifactEra(artifact.foundedYear)) }"
                />
                <span class="card-years">
                  <template v-if="artifact.foundedYear">{{ artifact.foundedYear }}</template>
                  <template v-if="artifact.closedYear"> – {{ artifact.closedYear }}</template>
                </span>
                <span class="card-category">{{ artifact.category?.nameZh || artifact.category?.name }}</span>
              </div>

              <h3 class="card-name">{{ artifact.nameZh || artifact.name }}</h3>
              <p v-if="artifact.nameZh" class="card-name-en">{{ artifact.name }}</p>

              <div class="card-stats">
                <span>{{ artifact.memoryCount }} 条记忆</span>
                <span>{{ artifact.viewCount }} 次浏览</span>
              </div>
            </div>
          </div>
        </div>

        <div v-if="total === 0 && !loading" class="state-box">
          <p>没有找到相关文物</p>
          <p class="state-sub">No artifacts found</p>
        </div>

        <div v-if="total > query.pageSize" class="pagination-bar">
          <el-pagination
            v-model:current-page="query.page"
            :page-size="query.pageSize"
            :total="total"
            layout="prev, pager, next"
            background
            @current-change="onPageChange"
          />
        </div>
      </template>
    </section>
  </div>
</template>

<style scoped>
.hero {
  background: var(--color-bg-alt);
  border-bottom: 1px solid var(--color-border);
  padding: var(--space-12) 0 var(--space-8);
  text-align: center;
}
.hero-title {
  font-size: 28px;
  font-weight: 700;
  margin-bottom: var(--space-1);
}
.hero-sub {
  font-size: 16px;
  color: var(--color-text-secondary);
  font-family: 'PingFang SC', sans-serif;
  margin-bottom: var(--space-3);
}
.hero-desc {
  font-size: 14px;
  color: var(--color-text-muted);
  font-style: italic;
}

.filters-bar {
  background: var(--color-surface);
  border-bottom: 1px solid var(--color-border);
  padding: var(--space-4) 0;
  position: sticky;
  top: 60px;
  z-index: 90;
}
.filters-inner {
  display: flex;
  align-items: center;
  gap: var(--space-6);
  flex-wrap: wrap;
}
.filter-search { width: 220px; }
.filter-group {
  display: flex;
  align-items: center;
  gap: var(--space-2);
}
.filter-label {
  font-size: 13px;
  color: var(--color-text-muted);
  white-space: nowrap;
  font-family: 'Inter', sans-serif;
}

.artifacts-section {
  padding: var(--space-8) var(--space-8);
}
.result-count {
  font-size: 13px;
  color: var(--color-text-muted);
  font-family: 'Inter', sans-serif;
  margin-bottom: var(--space-6);
}
.artifact-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: var(--space-6);
}

.artifact-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: 6px;
  overflow: hidden;
  cursor: pointer;
  transition: box-shadow 0.2s, transform 0.2s;
}
.artifact-card:hover {
  box-shadow: 0 4px 16px rgba(0,0,0,0.08);
  transform: translateY(-2px);
}

.card-cover {
  position: relative;
  height: 180px;
  background: var(--color-bg-alt);
  overflow: hidden;
}
.card-cover img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.card-cover-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-4);
  font-size: 20px;
  color: var(--color-text-muted);
  font-family: 'PingFang SC', sans-serif;
}
.ghost-badge {
  position: absolute;
  top: var(--space-2);
  right: var(--space-2);
  background: rgba(0,0,0,0.5);
  color: #fff;
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 3px;
  font-family: 'Inter', sans-serif;
}

.card-body { padding: var(--space-4); }
.card-meta {
  display: flex;
  align-items: center;
  gap: var(--space-2);
  margin-bottom: var(--space-2);
}
.era-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  flex-shrink: 0;
}
.card-years {
  font-size: 12px;
  font-family: 'Courier New', monospace;
  color: var(--color-text-muted);
}
.card-category {
  font-size: 11px;
  color: var(--color-accent);
  background: rgba(43,95,142,0.08);
  padding: 1px 6px;
  border-radius: 3px;
  font-family: 'Inter', sans-serif;
  margin-left: auto;
}
.card-name {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 2px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.card-name-en {
  font-size: 13px;
  color: var(--color-text-muted);
  margin-bottom: var(--space-3);
  font-style: italic;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.card-stats {
  display: flex;
  gap: var(--space-4);
  font-size: 12px;
  color: var(--color-text-muted);
  font-family: 'Inter', sans-serif;
  border-top: 1px solid var(--color-border);
  padding-top: var(--space-3);
  margin-top: var(--space-3);
}

.state-box {
  padding: var(--space-12) 0;
  text-align: center;
  color: var(--color-text-secondary);
}
.state-sub {
  font-size: 13px;
  color: var(--color-text-muted);
  margin-top: var(--space-2);
}
.pagination-bar {
  display: flex;
  justify-content: center;
  margin-top: var(--space-12);
}
</style>
