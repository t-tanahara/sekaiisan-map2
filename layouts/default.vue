<template>
<v-app dark>
  <v-app-bar
    :clipped-left="clipped"
    fixed
    app
  >
    <v-toolbar-title v-text="title" />
  </v-app-bar>

  <v-main>
    <nuxt />
  </v-main>
</v-app>
</template>

<script>
export default {
  data () {
    return {
      clipped: false,
      title: '世界遺産マップ',
    }
  }
}
</script>
