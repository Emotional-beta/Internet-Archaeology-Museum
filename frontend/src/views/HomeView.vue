<script setup lang="ts">
import { ref, reactive, watch, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { listArtifacts, listCategories } from '@/api/artifact'
import type { ArtifactListItem, Category } from '@/types/artifact'

const route = useRoute()
const router = useRouter()

const VALID_ERAS = new Set(['1990s', '2000s', '2010s', '2020s'])
const VALID_STATUSES = new Set([1, 2])

function parseUrlParams() {
  const p = route.query
  const rawStatus = Number(p.status)
  const rawPage = parseInt(String(p.page ?? '1'), 10)
  return {
    q: typeof p.q === 'string' ? p.q : '',
    era: typeof p.era === 'string' && VALID_ERAS.has(p.era) ? p.era : '',
    category: typeof p.category === 'string' ? p.category : '',
    status: VALID_STATUSES.has(rawStatus) ? rawStatus : undefined as number | undefined,
    page: rawPage > 0 ? rawPage : 1,
  }
}

const initial = parseUrlParams()

const artifacts = ref<ArtifactListItem[]>([])
const categories = ref<Category[]>([])
const total = ref(0)
const loading = ref(false)
const errorMsg = ref('')

const query = reactive({
  page: initial.page,
  pageSize: 18,
  q: initial.q,
  era: initial.era,
  category: initial.category,
  status: initial.status as number | undefined,
})

const eras = [
  { label: '1990s', value: '1990s' },
  { label: '2000s', value: '2000s' },
  { label: '2010s', value: '2010s' },
  { label: '2020s', value: '2020s' },
]

function syncToUrl() {
  const q: Record<string, string> = {}
  if (query.q)              q.q        = query.q
  if (query.era)            q.era      = query.era
  if (query.category)       q.category = query.category
  if (query.status != null) q.status   = String(query.status)
  if (query.page > 1)       q.page     = String(query.page)
  router.replace({ query: q })
}

async function loadArtifacts() {
  loading.value = true
  errorMsg.value = ''
  try {
    const params: Record<string, unknown> = {
      page: query.page,
      pageSize: query.pageSize,
    }
    if (query.q)              params.q        = query.q
    if (query.era)            params.era      = query.era
    if (query.category)       params.category = query.category
    if (query.status != null) params.status   = query.status

    const result = await listArtifacts(params)
    artifacts.value = result.list
    total.value = result.total
  } catch (e) {
    console.error(e)
    errorMsg.value = '无法连接到博物馆档案库，请稍后再试'
  } finally {
    loading.value = false
  }
}

function resetPage() {
  query.page = 1
  syncToUrl()
  loadArtifacts()
}

function onPageChange(page: number) {
  query.page = page
  syncToUrl()
  loadArtifacts()
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

function goToArtifact(slug: string) {
  router.push(`/artifacts/${slug}`)
}

function onEraChange()      { resetPage() }
function onCategoryChange() { resetPage() }
function onStatusChange()   { resetPage() }

let searchTimer: ReturnType<typeof setTimeout>
watch(() => query.q, () => {
  clearTimeout(searchTimer)
  searchTimer = setTimeout(resetPage, 400)
})

const eraColorMap: Record<string, string> = {
  '1990s': 'var(--era-1990s)',
  '2000s': 'var(--era-2000s)',
  '2010s': 'var(--era-2010s)',
  '2020s': 'var(--era-2020s)',
}

function artifactEra(year: number | null): string {
  if (!year) return ''
  if (year < 2000) return '1990s'
  if (year < 2010) return '2000s'
  if (year < 2020) return '2010s'
  return '2020s'
}

function eraColor(era: string) {
  return eraColorMap[era] || 'var(--color-text-muted)'
}

onMounted(async () => {
  const [, cats] = await Promise.all([loadArtifacts(), listCategories()])
  categories.value = cats
})
</script>

<template>
  <div>
    <!-- Hero -->
    <section class="hero">
      <div class="content-column">
        <p class="hero-eyebrow">DIGITAL ARCHIVE &nbsp;·&nbsp; EST. 1990s — PRESENT</p>
        <h1 class="hero-title">Internet Archaeology Museum</h1>
        <p class="hero-sub">互联网考古博物馆</p>
        <p class="hero-desc">
          保存正在消失的互联网记忆 &nbsp;·&nbsp; Preserving the Internet's fading memory
        </p>
      </div>
    </section>

    <!-- Filters -->
    <section class="filters-bar">
      <div class="wide-column">
        <p class="filters-heading">ARCHIVE FILTERS</p>
        <div class="filters-inner">
          <el-input
            v-model="query.q"
            placeholder="搜索文物 / Search artifacts"
            clearable
            class="filter-search"
          />

          <div class="filter-group">
            <span class="filter-label">状态</span>
            <el-radio-group v-model="query.status" @change="onStatusChange" size="small">
              <el-radio-button :value="undefined">全部</el-radio-button>
              <el-radio-button :value="1">Active</el-radio-button>
              <el-radio-button :value="2">Ghost</el-radio-button>
            </el-radio-group>
          </div>

          <div class="filter-group">
            <span class="filter-label">时代</span>
            <el-radio-group v-model="query.era" @change="onEraChange" size="small">
              <el-radio-button value="">全部</el-radio-button>
              <el-radio-button v-for="era in eras" :key="era.value" :value="era.value">
                {{ era.label }}
              </el-radio-button>
            </el-radio-group>
          </div>

          <div class="filter-group">
            <span class="filter-label">类型</span>
            <el-select
              v-model="query.category"
              placeholder="全部分类"
              clearable
              size="small"
              @change="onCategoryChange"
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
      </div>
    </section>

    <!-- Artifact Grid -->
    <section class="artifacts-section wide-column">

      <!-- Error -->
      <div v-if="errorMsg" class="state-box">
        <p class="state-error-msg">{{ errorMsg }}</p>
        <button class="retry-btn" @click="loadArtifacts()">重试 Retry</button>
      </div>

      <!-- Initial loading -->
      <div v-else-if="loading && artifacts.length === 0" class="state-box">
        <p class="loading-text">正在读取互联网档案……</p>
        <el-skeleton :rows="3" animated style="margin-top: 24px;" />
      </div>

      <template v-else>
        <p class="result-count">共 {{ total }} 件文物 &nbsp;·&nbsp; {{ total }} artifacts in collection</p>

        <div class="artifact-grid" v-loading="loading">
          <div
            v-for="artifact in artifacts"
            :key="artifact.id"
            class="artifact-card"
            :class="{ 'is-ghost': artifact.status === 2 }"
            @click="goToArtifact(artifact.slug)"
          >
            <!-- Cover image -->
            <div class="card-cover">
              <img
                v-if="artifact.coverImageUrl"
                :src="artifact.coverImageUrl"
                :alt="artifact.name"
                loading="lazy"
              />
              <div v-else class="card-cover-placeholder">
                <span class="placeholder-label">IMAGE UNAVAILABLE</span>
                <span class="placeholder-name">{{ artifact.nameZh || artifact.name }}</span>
              </div>
              <span v-if="artifact.status === 2" class="ghost-badge">GHOST</span>
            </div>

            <!-- Card body -->
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

        <!-- Empty -->
        <div v-if="total === 0 && !loading" class="state-box">
          <p class="empty-title">暂时没有找到相关互联网遗迹</p>
          <p class="state-sub">No artifacts found matching your filters.</p>
          <p class="empty-hint">Try another era, category, or search term.</p>
        </div>

        <!-- Pagination -->
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
/* ---- Hero ---- */
.hero {
  background: var(--color-bg-alt);
  border-bottom: 1px solid var(--color-border);
  padding: var(--space-16) 0 var(--space-12);
  text-align: center;
}
.hero-eyebrow {
  font-size: 11px;
  font-family: 'Inter', sans-serif;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--color-text-muted);
  margin-bottom: var(--space-4);
}
.hero-title {
  font-size: 36px;
  font-weight: 700;
  letter-spacing: -0.01em;
  margin-bottom: var(--space-3);
}
.hero-sub {
  font-size: 18px;
  color: var(--color-text-secondary);
  font-family: 'PingFang SC', sans-serif;
  margin-bottom: var(--space-4);
}
.hero-desc {
  font-size: 14px;
  color: var(--color-text-muted);
  font-style: italic;
  font-family: Georgia, serif;
}

/* ---- Filters ---- */
.filters-bar {
  background: var(--color-surface);
  border-bottom: 1px solid var(--color-border);
  padding: var(--space-3) 0 var(--space-4);
  position: sticky;
  top: 60px;
  z-index: 90;
}
.filters-heading {
  font-size: 10px;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--color-text-muted);
  font-family: 'Inter', sans-serif;
  margin-bottom: var(--space-3);
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
  font-size: 12px;
  color: var(--color-text-muted);
  white-space: nowrap;
  font-family: 'Inter', sans-serif;
  letter-spacing: 0.03em;
}

/* ---- Artifacts section ---- */
.artifacts-section {
  padding: var(--space-8) var(--space-8);
}
.result-count {
  font-size: 12px;
  color: var(--color-text-muted);
  font-family: 'Inter', sans-serif;
  letter-spacing: 0.02em;
  margin-bottom: var(--space-6);
}

/* ---- Grid ---- */
.artifact-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: var(--space-6);
}

/* ---- Card ---- */
.artifact-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: 4px;
  overflow: hidden;
  cursor: pointer;
  transition: box-shadow 0.22s ease, transform 0.22s ease, border-color 0.22s ease;
}
.artifact-card:hover {
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.07);
  transform: translateY(-3px);
  border-color: rgba(43, 95, 142, 0.35);
}
.artifact-card.is-ghost {
  opacity: 0.88;
}
.artifact-card.is-ghost .card-cover {
  filter: grayscale(20%);
}

/* ---- Cover ---- */
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
  transition: transform 0.25s ease;
}
.artifact-card:hover .card-cover img {
  transform: scale(1.04);
}
.card-cover-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: var(--space-2);
  padding: var(--space-4);
}
.placeholder-label {
  font-size: 10px;
  letter-spacing: 0.16em;
  color: var(--color-text-muted);
  font-family: 'Inter', sans-serif;
  text-transform: uppercase;
}
.placeholder-name {
  font-size: 18px;
  color: var(--color-text-secondary);
  font-family: 'PingFang SC', Georgia, serif;
  text-align: center;
}
.ghost-badge {
  position: absolute;
  top: var(--space-2);
  left: var(--space-2);
  background: rgba(136, 136, 136, 0.12);
  color: var(--color-ghost);
  border: 1px solid rgba(136, 136, 136, 0.3);
  font-size: 10px;
  letter-spacing: 0.12em;
  font-weight: 600;
  padding: 2px 7px;
  font-family: 'Inter', sans-serif;
}

/* ---- Card body ---- */
.card-body { padding: var(--space-4); }
.card-meta {
  display: flex;
  align-items: center;
  gap: var(--space-2);
  margin-bottom: var(--space-3);
}
.era-dot {
  width: 7px;
  height: 7px;
  border-radius: 50%;
  flex-shrink: 0;
}
.card-years {
  font-size: 12px;
  font-family: 'Courier New', monospace;
  color: var(--color-text-muted);
  letter-spacing: 0.02em;
}
.card-category {
  font-size: 10px;
  color: var(--color-accent);
  background: rgba(43, 95, 142, 0.07);
  padding: 2px 7px;
  font-family: 'Inter', sans-serif;
  letter-spacing: 0.04em;
  text-transform: uppercase;
  margin-left: auto;
}
.card-name {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 3px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.4;
}
.card-name-en {
  font-size: 13px;
  color: var(--color-text-muted);
  margin-bottom: var(--space-3);
  font-style: italic;
  font-family: Georgia, serif;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.card-stats {
  display: flex;
  gap: var(--space-4);
  font-size: 11px;
  color: var(--color-text-muted);
  font-family: 'Inter', sans-serif;
  letter-spacing: 0.02em;
  border-top: 1px solid var(--color-border);
  padding-top: var(--space-3);
  margin-top: var(--space-3);
}

/* ---- States ---- */
.state-box {
  padding: var(--space-16) 0;
  text-align: center;
  color: var(--color-text-secondary);
}
.state-sub {
  font-size: 13px;
  color: var(--color-text-muted);
  margin-top: var(--space-2);
  font-style: italic;
}
.loading-text {
  font-size: 13px;
  color: var(--color-text-muted);
  font-family: 'Inter', sans-serif;
  letter-spacing: 0.04em;
}
.empty-title {
  font-size: 16px;
  color: var(--color-text-secondary);
  font-family: Georgia, serif;
  margin-bottom: var(--space-2);
}
.empty-hint {
  font-size: 12px;
  color: var(--color-text-muted);
  font-family: 'Inter', sans-serif;
  letter-spacing: 0.02em;
  margin-top: var(--space-3);
}
.state-error-msg {
  font-size: 14px;
  color: var(--color-text-secondary);
  font-family: 'Inter', sans-serif;
  margin-bottom: var(--space-4);
}
.retry-btn {
  font-size: 11px;
  font-family: 'Inter', sans-serif;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--color-accent);
  background: transparent;
  border: 1px solid rgba(43, 95, 142, 0.4);
  padding: var(--space-2) var(--space-4);
  cursor: pointer;
  transition: background 0.2s, border-color 0.2s;
}
.retry-btn:hover {
  background: rgba(43, 95, 142, 0.06);
  border-color: var(--color-accent);
}

/* ---- Pagination ---- */
.pagination-bar {
  display: flex;
  justify-content: center;
  margin-top: var(--space-12);
}

/* ---- Responsive ---- */
@media (max-width: 768px) {
  .hero {
    padding: var(--space-8) 0 var(--space-6);
  }
  .hero-title {
    font-size: 24px;
  }
  .hero-sub {
    font-size: 15px;
  }
  .filters-inner {
    flex-direction: column;
    align-items: flex-start;
    gap: var(--space-3);
  }
  .filter-search {
    width: 100%;
  }
  .artifacts-section {
    padding: var(--space-6) var(--space-4);
  }
}

@media (max-width: 480px) {
  .artifact-grid {
    grid-template-columns: 1fr;
  }
}
</style>
