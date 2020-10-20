<template>
<v-card
  class="mx-auto"
  width="300px"
>
  <v-img
    :src="currentMarker.image_url"
    height="200px"
  ></v-img>
  <v-card-title>
    {{ currentMarker.title }}
  </v-card-title>
  <v-card-subtitle>
    {{ currentMarker.registration_year }}年 登録<br>
    {{ siteCategory(currentMarker.category) }}
  </v-card-subtitle>
  <v-card-actions @click="show = !show">
    <v-btn
      color="orange lighten-2"
      text
    >
      詳細
    </v-btn>
    <v-spacer></v-spacer>
    <v-btn
      icon
    >
      <v-icon>{{ show ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
    </v-btn>
  </v-card-actions>
  <v-expand-transition>
    <div v-show="show">
      <v-divider></v-divider>
      <v-card-text>
        {{ currentMarker.description }}
      </v-card-text>
    </div>
  </v-expand-transition>
</v-card>
</template>

<script>
export default {
  data: () => ({
    show: false,
  }),

  props: {
    currentMarker: Object,
    default: {
      title: '',
      url: '',
      image_url: '',
      category: '',
      criteria: '',
      registration_year: '',
      description: '',
    },
  },

  created: function() {
    this.show = false
  },

  methods: {
    siteCategory: function(category) {
      const categories = {
        Cultural: '文化遺産',
        Natural: '自然遺産',
        Mixed: '複合遺産',
      }
      return categories[category] || ''
    },
  },
}
</script>