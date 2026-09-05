import { get } from './http'
import type {
  ArtifactDetail,
  ArtifactListItem,
  ArtifactQuery,
  Category,
  PageResult,
} from '@/types/artifact'

export function listArtifacts(query: ArtifactQuery = {}) {
  return get<PageResult<ArtifactListItem>>('/artifacts', query as Record<string, unknown>)
}

export function getArtifact(slug: string) {
  return get<ArtifactDetail>(`/artifacts/${slug}`)
}

export function listCategories() {
  return get<Category[]>('/categories')
}
