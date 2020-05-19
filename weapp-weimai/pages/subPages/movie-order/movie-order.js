const app = getApp();
const util = require("../../../utils/util.js")
Page({
  data:{ 
    orderList:[]
  },
  onLoad(){
  },
  onShow(){
    this.initData()
  },
  initData(){
    var that = this;
    wx.getStorage({
      key: 'userInfo',
      success: function(res1) {
        wx.request({
          url: app.globalData.url +'/order/getMovieOrder',
          method: "GET",
          header:{
            'token': res1.data.data.token
          },
          success(res){
            console.log(res);
            if(res.data.state === 202){
              wx.showModal({
                content: '您还未登录',
                success(res) {
                  wx.switchTab({
                    url: '/pages/user/user',
                  })
                }
              })
            }else{
              res.data.data.forEach(order => { order.time = util.formatYear(new Date(order.time))})
              that.setData({
                orderList: res.data.data
              })
            }
          }
        })
      }
    })
  },
  //跳转到订单详情页面
  goTo(e){
    const order = e.currentTarget.dataset.order
    order.Vcode = util.getRandom(100000, 999999)
    const paramsStr = JSON.stringify(order)
    wx.navigateTo({
      url: `../movie-order-detail/movie-order-detail?paramsStr=${paramsStr}`
    })
  }
})