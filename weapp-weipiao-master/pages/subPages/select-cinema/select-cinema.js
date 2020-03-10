const util = require('../../../utils/util.js')
const app = getApp()
Page({
  data: {
    showTime:'',//影片上映日期
    params: { //url请求参数对象
      dateTime: '',
      movieId: 0,
      pageNum: 0,
      limit: 8,
      hallType: -1,
      brandId: -1,
      serviceId: -1,
      selectRegion: ''
    },
    hasMore: true,
    isShow: false, //导航下拉框是否展开
    cityCinemaInfo: {}, //影院过滤菜单
    cinemas: [], //影院列表 
    nothing: false, //是否有符合过滤的影院
    noSchedule: false //当天是否有场次，原本时间是由后台返回的，但是缺少城市ID就没有返回，导致当天可能没有播放场次

  },
  onLoad(options) {
    this.initPage(options)
  },
  initPage(options){
    const movieId = options.movieId
    const movieName = options.movieName
    const showTime = options.showTime //影片上映日期
    wx.setNavigationBarTitle({
      title: movieName
    })
    var that = this;
    this.setData({
      showTime: util.formatYear(new Date()),
      params:{
        ...that.data.params,
        movieId: movieId
      }
    })
    //select-time会触发事件来调用changeTime初始化数据
  },
  //获取影院列表
  getCinemas(params) {
    const _this = this;
    var pageIndex = _this.data.params.pageNum;
    return new Promise((resolve, reject) => {
      wx.request({
        url: app.globalData.url + `/cinema/getCinemas`,
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
          // 缺少了城市ID所以返回值缺少showDays，只能自己模拟时间了
          resolve(res.data.data.beanList)
          console.log(res.data.data)
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
            pageNum: pageIndex
          })
        }
      })
    })
  },
  //获取过滤菜单数据
  getFilter() {
    const _this = this;
    wx.request({
      url: app.globalData.url + '/cinema/getFilters',
      method: 'POST',
      data: app.globalData.selectCity,
      success: function (res) {
        console.log(res.data)
        _this.setData({
          cityCinemaInfo: res.data
        })
      }
    })
  },
  //当选择的时间变化时触发
  changeTime(e){
    var that = this
    const day = util.formatYear(new Date(e.detail.day))
    this.setData({
      cinemas: [],
      isShow: false, //隐藏过滤下拉框
      noSchedule: false,
      hasMore: true,
      
      params: {
        ...that.data.params,
        dateTime: day,
        pageNum: 0
      }
    })
    wx.showLoading({
      title: '正在加载...'
    })
    this.getCinemas(this.data.params)
    this.getFilter()
  },
  //当过滤条件变化时调用的函数
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
  //导航下拉框状态变化时的处理，在下拉框展开时禁止滚动穿透
  toggleShow(e) {
    const item = e.detail.item
    this.setData({
      isShow: item !== -1
    })
  },
  //上拉触底加载更多
  onReachBottom(e) {
    if (!this.data.hasMore) return
    this.getCinemas(this.data.params)
  }
})