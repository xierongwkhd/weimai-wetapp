//其实页面可以和movie-order页面复用
const app = getApp();
Page({
  data: {
    orderList: []
  },
  onLoad() {
  },
  onShow() {
    this.initData()
  },
  initData() {
    var that = this;
    wx.getStorage({
      key: 'userInfo',
      success: function (res1) {
        wx.request({
          url: app.globalData.url + '/order/getSnackOrder',
          method: "GET",
          header: {
            'token': res1.data.data.token
          },
          success(res) {
            if(res.data.state == 202){
              wx.showModal({
                content: '您还未登录',
                success(res) {
                  wx.switchTab({
                    url: '/pages/user/user',
                  })
                }
              })
            }else{
              that.setData({
                orderList: res.data.data
              })
            }
          }
        })
      }
    })
  },
  //删除订单
  deleteOrder(e) {
    const index = e.currentTarget.dataset.index;
    let orderList = this.data.orderList.slice();
    orderList.splice(index, 1)
    wx.showModal({
      title: '提示',
      content: '确认删除订单吗？',
      success: (res) => {
        if (res.confirm) {
          this.setData({
            orderList
          })
          wx.setStorageSync('snackOrder', orderList)
        }
      }
    })
  },
})