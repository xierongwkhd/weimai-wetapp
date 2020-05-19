const app = getApp();
Page({
  data:{
    order:null,
    first:true //是否是第一次支付
  },
  onLoad(params){
    const paramsObj = JSON.parse(params.paramsStr)
    this.initData(paramsObj)
  },
  initData(params){
    this.setData({
      order:params
    })
  },
  //模拟支付
  payment(){
    //避免重复支付
    if(this.data.first){
      var that = this;
      // let movieOrder = wx.getStorageSync('movieOrder') || []
      // movieOrder.unshift(this.data.order)
      // wx.setStorageSync('movieOrder', movieOrder)
      //请求后台模拟支付
      const order = this.data.order;
      wx.getStorage({
        key: 'userInfo',
        success: function (res1) {
          wx.request({
            url: app.globalData.url + '/order/addOrder',
            method: 'POST',
            header: {
              'content-type': 'application/x-www-form-urlencoded',
              'token': res1.data.data.token
            },
            data: {
              itemId: order.movieId,
              itemType: '电影票',
              relateId: order.timesId,
              orderId: order.orderId,
              price: order.price,
              seat: JSON.stringify(order.seat)
            },
            success(res) {
              if (res.data.state == 202) {
                wx.showModal({
                  content: '您还未登录',
                  success(res) {
                    wx.switchTab({
                      url: '/pages/user/user',
                    })
                  }
                })
              }else if (res.data.state===200){
                wx.showToast({
                  title: '支付成功',
                })
                that.setData({
                  first: false
                })
                // wx.navigateTo({
                //   url: `../movie-order-detail/movie-order-detail?paramsStr=${JSON.stringify(res.data.data)}`,
                // })
                wx.switchTab({
                  url: '/pages/user/user',
                })
              }else{
                wx.showToast({
                  title: '支付失败',
                })
              }
            }
          })
        },
        fail: function (res2) {
          wx.showModal({
            content: '您还未登录',
            success(res) {
              wx.switchTab({
                url: '../../user/user',
              })
            }
          })
        }
      })
    } else {
      wx.showToast({
        title: '已支付',
        icon:'none'
      })
    }
  }
})