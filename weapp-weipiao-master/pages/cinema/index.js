const util = require('../../utils/util.js')

const app = getApp();
Page({
    data: {
      title: '',
      city: '正在定位...',
      params: { //url请求参数对象
        pageNum: 0,
        limit: 8,
        hallType: -1,
        brandId: -1,
        serviceId: -1,
        selectRegion: ''
      },
      hasMore: true,
      cinemas: [], //影院列表
      cityCinemaInfo: {}, //城市影院信息
      isShow: false, //导航下拉框是否展开
      nothing: false, //是否有符合过滤的影院
      noSchedule: false //当天是否有场次，原本时间是由后台返回的，但是缺少城市ID就没有返回，导致当天可能没有播放场次
    },
    //事件处理函数
  onLoad: function (options) {
    var that = this
    that.cityInit();
    that.getFilter()
    that.getCinemas(that.data.params);
  },
  onReady: function () {
    wx.setNavigationBarTitle({
      title: '电影院'
    })
  },
  getFilter(){
    var that = this
    wx.request({
      url: app.globalData.url + '/cinema/getFilters',
      method: 'POST',
      data: app.globalData.selectCity,
      success: function (res) {
        console.log(res.data)
        that.setData({
          cityCinemaInfo: res.data
        })
      }
    })
  },
  getCinemas(params) {
    const _this = this;
    var pageIndex = _this.data.params.pageNum;
    return new Promise((resolve, reject) => {
      wx.request({
        url: app.globalData.url +`/cinema/getCinemas`,
        method: 'POST',
        header: {
          'content-type': 'application/x-www-form-urlencoded'
        },
        data: {
          ...params,
          pageNum: ++pageIndex,
          selectCity: JSON.stringify(app.globalData.selectCity)
        },
        success(res) {
          wx.hideLoading()
          resolve(res.data.data.beanList)
          if (!res.data.data.beanList.length) {
            _this.setData({
              noSchedule: true,
              hasMore: false
            })
            return
          }
          _this.setData({
            hasMore: pageIndex < res.data.data.tr,
            cinemas: _this.data.cinemas.concat(res.data.data.beanList),
            params: {
              ..._this.data.params,
              pageNum: pageIndex
            }
          })
        }
      })
    })
  },
  //上拉触底加载更多
  onReachBottom() {
    if (!this.data.hasMore) return
    this.getCinemas(this.data.params)
  },
  cityInit: function () {
    if (app.globalData.userLocation) {
      this.setData({
        city: app.globalData.selectCity ? app.globalData.selectCity.cityName : '定位失败'
      })
    } else {
      app.userLocationReadyCallback = () => {
        this.setData({
          city: app.globalData.selectCity ? app.globalData.selectCity.cityName : '定位失败'
        })
      }
    }
  },
  onShow: function () {
    if (app.globalData.selectCity) {
      this.setData({
        city: app.globalData.selectCity.cityName
      })
    }
    if (app.globalData.isRefresh){
      app.globalData.isRefresh = false;
      this.setData({
        params: {
          ...this.data.params,
          pageNum: 0
        },
        city: app.globalData.selectCity.cityName,
        cinemas: [],
        nothing: false
      })
      this.getFilter()
      this.getCinemas(this.data.params)
    }
  },
  changeCondition(e) {
    const obj = e.detail
    wx.showLoading({
      title: '正在加载...'
    })
    this.setData({
      params: {
        ...this.data.params,
        ...obj,
        pageNum: 0
      },
      cinemas: [],
      nothing: false
    }, () => {
      this.getCinemas(this.data.params).then((list) => {
        if (!list.length) {
          this.setData({
            nothing: true
          })
        }
        wx.hideLoading()
      })
    })
  },
  //导航下拉框状态变化时的处理
  toggleShow(e) {
    const item = e.detail.item
    this.setData({
      isShow: item !== -1
    })
  }
})
