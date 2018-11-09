<template>
  <div class="centering-wrap inactive-area" v-if="isAuthenticated">
    <router-view/>
  </div>
</template>

<script>
import protect from '@/mixins/protect'
export default {
  mixins: [protect]
}
</script>