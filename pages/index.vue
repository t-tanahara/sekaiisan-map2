<template>
<v-layout row justify-center align-center>
<GmapMap
  :center="tokyo"
  :zoom="5"
  :options="{minZoom: 3}"
  map-type-id="terrain"
  id='gmap'
>
  <GmapMarker
    v-for="(marker) in markers"
      :key="marker.site_id"
      :position="marker.position"
      :clickable="true"
      @click="toggleInfoWindow(marker, marker.site_id)"
  ></GmapMarker>
  <gmap-info-window
    :position="infoWindowPosition"
    :opened="openInfoWindow"
  >
    <InfoWindow :currentMarker="currentMarker" />
  </gmap-info-window>
</GmapMap>
</v-layout>
</template>

<script>
import InfoWindow from '~/components/InfoWindow'

export default {
  components: {
    InfoWindow,
  },

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
          site_id: site.id_number,
          position: {lng: parseFloat(site.longitude), lat: parseFloat(site.latitude)},
          title: site.site,
          description: site.short_description,
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
    toggleInfoWindow: function(marker, site_id) {
      if (this.currentMarker.site_id == site_id) {
        this.openInfoWindow = !this.openInfoWindow
        return
      }
      this.infoWindowPosition = marker.position
      this.openInfoWindow = true
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