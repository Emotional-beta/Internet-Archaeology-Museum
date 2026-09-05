export interface Category {
  id: number
  name: string
  nameZh: string | null
  slug: string
  icon: string | null
}

export interface Tag {
  id: number
  name: string
  nameZh: string | null
  slug: string
}

export interface ArtifactImage {
  id: number
  url: string
  caption: string | null
  captionZh: string | null
  year: number | null
}

export interface ArtifactSource {
  id: number
  title: string
  url: string | null
  type: number
  year: number | null
}

export interface TimelineEvent {
  id: number
  eventDate: string | null
  eventYear: number
  eventMonth: number | null
  title: string
  titleZh: string | null
  description: string | null
  descriptionZh: string | null
  type: number
}

export interface ArtifactListItem {
  id: number
  slug: string
  name: string
  nameZh: string | null
  category: Category
  status: number
  foundedYear: number | null
  closedYear: number | null
  country: string | null
  coverImageUrl: string | null
  memoryCount: number
  viewCount: number
}

export interface ArtifactDetail extends ArtifactListItem {
  description: string | null
  descriptionZh: string | null
  significance: string | null
  significanceZh: string | null
  whatHappened: string | null
  whatHappenedZh: string | null
  websiteUrl: string | null
  archiveUrl: string | null
  tags: Tag[]
  images: ArtifactImage[]
  sources: ArtifactSource[]
  timelineEvents: TimelineEvent[]
}

export interface PageResult<T> {
  list: T[]
  total: number
  page: number
  pageSize: number
}

export interface ApiResult<T> {
  code: number
  message: string
  data: T
}

export interface ArtifactQuery {
  page?: number
  pageSize?: number
  category?: string
  era?: string
  status?: number
  q?: string
}
