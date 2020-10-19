<template>
<v-layout row justify-center align-center>
<GmapMap
  :center="tokyo"
  :zoom="5"
  :options="{minZoom: 4}"
  map-type-id="terrain"
  id='gmap'
>
  <GmapMarker
    v-for="(marker, index) in markers"
      :key="index"
      :position="marker.position"
      :clickable="true"
      @click="toggleInfoWindow(marker, index)"
  ></GmapMarker>
  <gmap-info-window
    :position="infoWindowPosition"
    :opened="openInfoWindow"
  >
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
  </gmap-info-window>
</GmapMap>
</v-layout>
</template>

<script>
export default {
  data() {
    return {
      tokyo: {lat: 35.681167, lng: 139.767052},
      markers: [],
      openInfoWindow: false,
      currentMarkerId: null,
      currentMarker: {},
      infoWindowPosition: {lat: 0, lng: 0},
    }
  },

  async asyncData({}) {
    const baseUrl = process.env.BASE_URL || 'http://localhost:3000'
    const response = await (await fetch(`${baseUrl}/world_heritage_list.json`)).json()
    const sites = response.query.row

    const markers = []
    for (const site of sites) {
      const marker_opt = {
        position: {lng: parseFloat(site.longitude), lat: parseFloat(site.latitude)},
      }
      markers.push(
        {
          position: {lng: parseFloat(site.longitude), lat: parseFloat(site.latitude)},
          title: site.site,
          description: site.short_description,
          site_id: site.id_number,
          category: site.category,
          url: site.http_url,
          image_url: site.image_url,
          criteria: site.criteria_txt,
          registration_year: site.date_inscribed,
        }
      )
    }
    return {markers: markers}
  },

  methods: {
    toggleInfoWindow: function(marker, index) {
      if (this.currentMarkerId == index) {
        this.openInfoWindow = !this.openInfoWindow
        return
      }
      this.infoWindowPosition = marker.position
      this.openInfoWindow = true
      this.currentMarkerId = index
      this.currentMarker = marker
    },
    siteCategory: function(category) {
      const categories = {
        Cultural: '文化遺産',
        Natural: '自然遺産',
        Mixed: '複合遺産',
      }
      return categories[category] || ''
    }
  },
};
</script>

<style scoped>
#gmap {
  width: 100%;
  height: 100%;
  position: absolute;
  left:0;
  top:0;
}
</style>