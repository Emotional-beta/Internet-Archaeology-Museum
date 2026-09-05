import axios from 'axios'
import type { ApiResult } from '@/types/artifact'

const http = axios.create({
  baseURL: '/api/v1',
  timeout: 10000,
})

http.interceptors.response.use(
  (res) => res,
  (err) => {
    const msg = err.response?.data?.message || err.message || 'Request failed'
    return Promise.reject(new Error(msg))
  },
)

export async function get<T>(url: string, params?: Record<string, unknown>): Promise<T> {
  const res = await http.get<ApiResult<T>>(url, { params })
  if (res.data.code !== 0) throw new Error(res.data.message)
  return res.data.data
}

export async function post<T>(url: string, data?: unknown): Promise<T> {
  const res = await http.post<ApiResult<T>>(url, data)
  if (res.data.code !== 0) throw new Error(res.data.message)
  return res.data.data
}

export default http
