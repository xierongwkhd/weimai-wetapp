const util = require('../../../utils/util.js')
const app = getApp()
const formatNumber = util.formatNumber
const getRandom = util.getRandom
Page({
  data: {
    cinemaId: '',
    movieId: '',
    cinemaDetail: null, //影院详情
    movie: null, //选中的电影
    movies:null, //电影列表
    days: [], //该电影的排片日期列表
    timeList: [], //当天播放电影的时间段
    divideDealList: [], //影院分类零食列表
    first:true //只在第一次提示
  }, 
  onLoad(query) {
   this.initPage(query)
  },
  //初始化页面
  initPage(query) {
    const { cinemaId = '', movieId = '', day = '' } = query
    this.setData({
      cinemaId,
      movieId,
      day
    })
    const _this = this
    wx.showLoading({
      title: '正在加载...',
    })
    wx.request({
      url: app.globalData.url + `/cinema/getCinema/${cinemaId}`,
      method: 'GET',
      data: {
        movieId: _this.data.movieId 
      },
      success(res) {
        wx.hideLoading()
        _this.setData({
          cinemaDetail: res.data.data.cinema,
          movies: res.data.data.movies,
          divideDealList: res.data.data.snacks
        })
      }
    })
  },
  //选择电影
  selectMovie(e) {
    const movie = e.detail.movie
    console.log(movie)
    let days = []
    movie.movieDays.forEach(item => {
      days.push({
        title: util.formatDate(new Date(item.day)),
        day: item.day
      })
    })
    this.setData({
      movie,
      days,
      timeList: this.createEndTime(movie.movieDays[0].times, movie.dur,movie.version)
    })
  },
  //选择时间
  selectDay(e) {
    const day = e.detail.day
    const movie = this.data.movie
    const index = movie.movieDays.findIndex(item => item.day === day)
    console.log(movie.movieDays)
    this.setData({
      timeList: this.createEndTime(movie.movieDays[index].times, movie.dur, movie.version)
    })
  },
  //跳转到“套餐详情”页面
  goSnackPage(e){
    const info = e.currentTarget.dataset.info;
    //将参数转化为JSON通过页面跳转时传递
    const paramsStr = JSON.stringify({
      cinemaName: this.data.cinemaDetail.nm,
      cinemaId: this.data.cinemaId,
      cinemaData: this.data.cinemaDetail,//影院信息
      info: info
    })
    wx.navigateTo({
      url: `/pages/subPages/snack-page/snack-page?paramsStr=${encodeURIComponent(paramsStr)}`,
    })
  },
  //购票
  buyTicket(e){
    const info = JSON.stringify(e.currentTarget.dataset.info);
    console.log(info)
    const movie = JSON.stringify(this.data.movie);
    const cinema = JSON.stringify(this.data.cinemaDetail);
    wx.navigateTo({
      url: `/pages/subPages/seat/hall?movie=${movie}&info=${info}&cinema=${cinema}`,
    })
  },
  //处理散场时间
  createEndTime(arr, dur,version) {
    let timeList = []
    if (Array.isArray(arr)) {
      timeList = arr.map(item => {
        let temp = { ...item
        }
        temp.version = version && version.split(' ').map(item => {
          return item.toUpperCase().replace('V', '')
        })
        console.log(item.startTime);
        var time = new Date(item.startTime)
        console.log(time);
        temp.beginTime = `${formatNumber(time.getHours())}:${formatNumber(time.getMinutes())}`
        time = time.setMinutes(time.getMinutes() + dur)
        const endTime = new Date(time)
        temp.endTime = `${formatNumber(endTime.getHours())}:${formatNumber(endTime.getMinutes())}`
        return temp
      })
    }
    return timeList
  }
})