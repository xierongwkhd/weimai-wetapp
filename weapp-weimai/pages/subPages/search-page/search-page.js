const util = require('../../../utils/util.js')
const app = getApp();
Page({
  data: {
    value: '',
    stype: '',
    placeholder: '',
    movies: {},
    cinemas: {},
    history: []
  },
  onLoad(query) {
   this.initPage(query)
    this.setData({
      history: wx.getStorageSync("history") || []
    })
  },
  initPage(query){
    //搜索类型，-1代表搜索影院或电影，2代表搜索影院
    const stype = query.stype
    let placeholder = ''
    if (stype === '-1') {
      placeholder = '搜电影、搜影院'
    } else {
      placeholder = '搜影院'
    }
    this.setData({
      stype,
      placeholder
    })
  },
  search(e) {
    var value = e.detail.value
    const _this = this
    console.log(e.target.dataset.index)
    if(e.target.dataset.index!=null){
      value = _this.data.history[e.target.dataset.index]
    }else{
      let history = wx.getStorageSync("history") || [];
      history.push(value)
      wx.setStorageSync("history", history);
    }
    this.setData({
      value,
      history: []
    })
    wx.request({
      url: app.globalData.url +`/home/search`,
      method: 'POST',
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
      data: {
        keyword: value,
        stype: _this.data.stype,
        selectCity: JSON.stringify(app.globalData.selectCity)
      },
      success(res) {
        console.log(res)
        for (var index in res.data.data.movies) {
          res.data.data.movies[index].rt = util.formatYear(new Date(res.data.data.movies[index].rt))
        }
        _this.setData({
          movies: res.data.data.movies ? res.data.data.movies : [],
          cinemas: res.data.data.cinemaVos ? res.data.data.cinemaVos : []
        })
      }
    })
  },
  goBack() {
    wx.navigateBack({
      delta: 1
    })
  },
  //清除缓存历史
  clearHistory: function () {
    this.setData({
      history: []
    })
    wx.setStorageSync("history", [])
  },
})