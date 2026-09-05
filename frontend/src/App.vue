<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div id="app-shell">
    <header class="site-header">
      <div class="wide-column header-inner">
        <RouterLink to="/" class="site-logo">
          <span class="logo-en">Internet Archaeology Museum</span>
          <span class="logo-zh">互联网考古博物馆</span>
        </RouterLink>
        <nav class="site-nav">
          <RouterLink to="/">文物 Artifacts</RouterLink>
          <RouterLink to="/timeline">时间轴 Timeline</RouterLink>
        </nav>
      </div>
    </header>

    <main class="site-main">
      <RouterView />
    </main>

    <footer class="site-footer">
      <div class="wide-column">
        <span>Internet Archaeology Museum · 互联网考古博物馆</span>
        <span class="footer-tagline">互联网不是没有记忆，只是它的记忆正在消失。</span>
      </div>
    </footer>
  </div>
</template>

<style scoped>
.site-header {
  background: var(--color-surface);
  border-bottom: 1px solid var(--color-border);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 60px;
}

.site-logo {
  display: flex;
  flex-direction: column;
  gap: 1px;
  text-decoration: none;
  line-height: 1.2;
}

.logo-en {
  font-family: 'Inter', sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: var(--color-text-primary);
  letter-spacing: 0.02em;
}

.logo-zh {
  font-size: 11px;
  color: var(--color-text-muted);
  font-family: 'PingFang SC', sans-serif;
}

.site-nav {
  display: flex;
  gap: var(--space-6);
}

.site-nav a {
  font-family: 'Inter', sans-serif;
  font-size: 14px;
  color: var(--color-text-secondary);
  text-decoration: none;
  padding: var(--space-2) 0;
  border-bottom: 2px solid transparent;
  transition: color 0.2s, border-color 0.2s;
}

.site-nav a:hover,
.site-nav a.router-link-active {
  color: var(--color-accent);
  border-bottom-color: var(--color-accent);
  text-decoration: none;
}

.site-main {
  flex: 1;
}

.site-footer {
  background: var(--color-bg-alt);
  border-top: 1px solid var(--color-border);
  padding: var(--space-8) 0;
  margin-top: var(--space-16);
}

.site-footer .wide-column {
  display: flex;
  flex-direction: column;
  gap: var(--space-2);
  font-size: 13px;
  color: var(--color-text-muted);
  font-family: 'Inter', sans-serif;
}

.footer-tagline {
  font-style: italic;
}
</style>
