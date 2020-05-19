Page({
  data: {
    cinemaData: null,
    markers: []
  },
  onLoad(opt) {
    console.log(opt)
    this.initData(opt)
  },
  initData(cinemaData) {
    this.setData({
      cinemaData,
      markers: [{
        latitude: cinemaData.latitude,
        longitude: cinemaData.longitude
      }]
    })
  },
  //定位自己的位置
  position() {
    const MapContext = wx.createMapContext('map')
    MapContext.moveToLocation()
  }
})