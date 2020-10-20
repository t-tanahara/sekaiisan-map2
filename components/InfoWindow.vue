<template>
<div>
  <table border="1" cellpadding="1" style="border-style:solid; color:black;">
    <tr style="border:1px black solid; padding:30px;">
      <td colspan="2" style="padding:3px;">
        <a :href="currentMarker.url" :alt="currentMarker.title" target="_blank">
          <img :src="currentMarker.image_url">
        </a>
      </td>
    </tr>
    <tr>
      <td colspan="2" style="padding:3px;">
        <a :href="currentMarker.url" target="_blank">{{ currentMarker.title }}</a>
      </td>
    </tr>
    <tr>
      <th width="30%">登録区分</th>
      <td style="padding:3px;">{{ siteCategory(currentMarker.category) }}</td>
    </tr>
    <tr>
      <th width="30%">登録基準</th>
      <td style="padding:3px;">{{ currentMarker.criteria }}</td>
    </tr>
    <tr>
      <th width="30%">登録年</th>
      <td style="padding:3px;">{{ currentMarker.registration_year }} 年</td>
    </tr>
    <tr>
      <td colspan="2" style="padding:3px;">
        <p>{{ currentMarker.description }}</p>
      </td>
    </tr>
  </table>
</div>
</template>

<script>
export default {
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