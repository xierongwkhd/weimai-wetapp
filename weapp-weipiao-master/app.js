//app.js
const QQMapWX = require('./locale/qqmap-wx-jssdk.min.js');
let qqmapsdk;
qqmapsdk = new QQMapWX({
  key: 'XXOBZ-PKQWU-26BVI-4RPT3-LV5HQ-OIBQF'
});

App({
  onLaunch: function () {
    this.initPage();
  },
  initPage() {
    // 获取用户授权信息信息,防止重复出现授权弹框
    wx.getSetting({
      success: res => {
        //已有权限直接获得信息，否则出现授权弹框
        if (res.authSetting['scope.userLocation']) {
          this.getUserLocation()
        } else{
          this.getUserLocation()
        }
      }
    })
  },
  //获取用户的位置信息
  getUserLocation() {
    wx.getLocation({
      //成功授权
      success: (res) => {
        const latitude = res.latitude;
        const longitude = res.longitude;
        // 使用腾讯地图接口将位置坐标转出成名称（为什么弹框出出现两次？）
        qqmapsdk.reverseGeocoder({
          location: {   //文档说location默认为当前位置可以省略，但是还是要手动加上，否则弹框会出现两次，手机端则出现问题
            latitude,
            longitude
          },
          success: (res) => {
            const cityFullname = res.result.address_component.city;
            const cityInfo = {
              latitude,
              longitude,
              cityName: cityFullname.substring(0, cityFullname.length - 1),
              status: 1
            }
            this.globalData.userLocation = { ...cityInfo }   //浅拷贝对象
            this.globalData.selectCity = { ...cityInfo } //浅拷贝对象
            // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回，所以此处加入 callback 以防止这种情况
            if (this.userLocationReadyCallback) {
              this.userLocationReadyCallback()
            }
          }
        })
      },
      fail: () => {
        this.globalData.userLocation = { status: 0 }
        //防止当弹框出现后，用户长时间不选择，
        if (this.userLocationReadyCallback) {
          this.userLocationReadyCallback()
        }
      }
    })
  },
  globalData: {
    userInfo: null,//用户信息
    userLocation: null, //用户的位置信息
    selectCity: null, //用户切换的城市
    isRefresh: false,
    //url: 'http://localhost:8080',
    url: 'https://mokespace.cn/weimai'
  }
})