const app = getApp();
Page({
  data: {
    avatarUrl: '/image/user/avatar.png',
    username: '点击登录',
    hasUserInfo: false
  },
  onShareAppMessage(res) {
    return {
      title: '微票电影',
      path: 'pages/home/home'
    }
  },
  onLoad: function() {
    this.userAuthorized();
  },
  onShow: function(){
    this.userAuthorized();
  },
  userAuthorized() {
    var _this = this;
    const userInfo = wx.getStorageSync('userInfo')
    if (userInfo) {
      //存在则判断服务端session是否过期
      console.log("判断服务端session是否过期")
      wx.request({
        url: app.globalData.url + '/user/isAuth',
        method: 'GET',
        header: {
          'token': userInfo.data.token
        },
        success(res) {
          if (res.data.state == 202) {
            _this.setData({
              hasUserInfo: false
            });
          } else {
            _this.setData({
              hasUserInfo: true
            });
          }
        }
      })
    } else {
      _this.setData({
        hasUserInfo: false
      });
    }
  },
  onGetUserInfo(event) {
    var that = this;
    const userInfo = event.detail.userInfo
    if (userInfo) {
      wx.login({
        success: function(res_1) {
          wx.getUserInfo({
            success: function(res_2) {
              console.log(res_2)
              wx.request({
                url: app.globalData.url + '/user/wxLogin',
                method: 'POST',
                header: {
                  'content-type': 'application/x-www-form-urlencoded'
                },
                data: {
                  code: res_1.code,
                  nickName: res_2.userInfo.nickName,
                  avatarUrl: res_2.userInfo.avatarUrl,
                  gender: res_2.userInfo.gender
                },
                success: function(res) {
                  const userInfo = res.data
                  wx.setStorage({
                    key: 'userInfo',
                    data: userInfo
                  })
                  that.setData({
                    hasUserInfo: true
                  })
                  app.globalData.userInfo = res_2.userInfo
                }
              })
            }
          })
        }
      })
    }
  }
})