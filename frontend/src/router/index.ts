import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/artifacts/:slug',
      name: 'artifact-detail',
      component: () => import('../views/ArtifactDetailView.vue'),
    },
  ],
})

export default router
