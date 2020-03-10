const app = getApp();
Page({
  data:{
    order:null,
    first:true //是否是第一次支付
  },
  onLoad(opt){
    const paramsObj = JSON.parse(decodeURIComponent(opt.paramsStr))
    this.initData(paramsObj)
  },
  initData(order){
    this.setData({
      order
    })
  },
  //减少数量
  minus(){
    if(this.data.order.amount===1){
      return 
    } else {
      this.chanegAmount()
    }
  },
  //增加数量
  plus(){
    this.chanegAmount(1)
  },
  chanegAmount(flag){
    let order = { ...this.data.order }
    let amount = order.amount
    if(flag){
      amount++
    } else {
      amount--
    }
    let total = (amount * order.price).toFixed(1)
    this.setData({
      order: {
        ...order,
        amount,
        total
      }
    })
  },
payment() {
    //避免重复支付
    if (this.data.first) {
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
              itemId: order.snackId,
              itemType: '小吃',
              relateId: order.cinemaId,
              orderId: order.orderId,
              price: order.total,
              seat: order.amount
            },
            success: function(res) {
              console.log(res);
              if (res.data.state == 202) {
                wx.showModal({
                  content: '您还未登录',
                  success(res) {
                    wx.switchTab({
                      url: '/pages/user/user',
                    })
                  }
                })
              }else if (res.data.state === 200) {
                wx.showToast({
                  title: '支付成功',
                })
                that.setData({
                  first: false
                })
                wx.switchTab({
                  url: '/pages/user/user',
                })
              } else {
                wx.showToast({
                  title: '支付失败',
                })
              }
            }
          })
        },
        fail: function (res1){
          wx.showModal({
            content: '您还未登录',
            success(res) {
              wx.switchTab({
                url: '/pages/user/user',
              })
            }
          })
        }
      })
    } else {
      wx.showToast({
        title: '已支付',
        icon: 'none'
      })
    }
  }
})