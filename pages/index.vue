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
    :key="index"
    v-for="(marker, index) in this.markers"
    :position="marker.position"
    :clickable="true"
    @click="center=marker.position"
  />
</GmapMap>
</v-layout>
</template>

<script>
export default {
  data() {
    return {
      tokyo: {lat: 35.681167, lng: 139.767052},
      markers: [],
    }
  },

  async asyncData({}) {
    const baseUrl = process.env.BASE_URL || 'http://localhost:3000'
    const response = await (await fetch(`${baseUrl}/world_heritage_list.json`)).json()
    const sites = response.query.row

    const markers = []
    for (const site of sites) {
      const marker_opt = {
        position: {lng: parseFloat(site.longitude), lat: parseFloat(site.latitude)}
      }
      markers.push(marker_opt)
    }
    return {markers: markers}
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