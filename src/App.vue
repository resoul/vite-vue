<template>
  <component :is="$route.meta.layoutComponent" />
</template>
<script>
export default {
  watch: {
    $route(to) {
      document.title = to.meta.title || "Vite & Vue 3"
    }
  }
}
</script>