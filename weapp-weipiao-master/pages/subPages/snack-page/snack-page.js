const util = require('../../../utils/util.js')
const getRandom = util.getRandom
Page({
  data: {
    info: null, //小吃详情
    cinemaName: '',
    cinemaData:null, //影院地图详情
    cinemaId: null
  },
  onLoad(obj) {
    console.log(obj)
    const paramsObj = JSON.parse(decodeURIComponent(obj.paramsStr))
    this.initPage(paramsObj)
  },
  initPage(obj, param) {
    wx.showLoading({
      title: '正在加载',
    })
    this.setData({
      cinemaName: obj.cinemaName,
      cinemaId: obj.cinemaId,
      cinemaData: obj.cinemaData,
      info: obj.info
    })
    wx.hideLoading();
  },
  //跳转到“提交订单”页面
  buySnack(){
    const { info, cinemaName, cinemaId} = this.data
    //添加订单信息
    const paramsStr = JSON.stringify({
      cinemaName,
      cinemaId,
      snackId: info.id,
      title: info.firstTitle,//套餐名
      orderId: getRandom(1000000000, 9999999999),
      img: info.imageUrl,//图片
      amount:1,//数量
      price: info.price,//单价
      total: info.price * 1//合计
    })
    wx.navigateTo({
      url: `/pages/subPages/buy-snack/buy-snack?paramsStr=${encodeURIComponent(paramsStr)}`,
    })
  }
})