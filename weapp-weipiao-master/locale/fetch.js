var config = require('./config.js')
var message = require('../components/message/message')

// 获取电影列表
// function fetchFilms(url, start, count, cb, fail_cb) {
//   var that = this
//   message.hide.call(that)
//   if (that.data.hasMore) {
//     if(start==0){
//       wx.showLoading({
//         title: '加载中...',
//       })
//     }
//     wx.request({
//       url: url,
//       data: {
//         city: config.city,
//         start: start,
//         count: config.count
//       },
//       method: 'GET', 
//       header: {
//         "Content-Type": "application/json,application/json"
//       },
//       success: function(res){
//         if(res.data.subjects.length === 0){
//           that.setData({
//             hasMore: false,
//           })
//         }else{
//           that.setData({
//             films: that.data.films.concat(res.data.subjects),
//             start: that.data.start + res.data.subjects.length,
//           })
//           console.log(that.data.start);
//         }
//         wx.hideLoading();
//         wx.stopPullDownRefresh()
//         typeof cb == 'function' && cb(res.data)
//       },
//       fail: function() {
//         wx.hideLoading();
//         message.show.call(that,{
//           content: '网络开小差了',
//           icon: 'offline',
//           duration: 3000
//         })
//         wx.stopPullDownRefresh()
//         typeof fail_cb == 'function' && fail_cb()
//       }
//     })
//   }
// }

function fetchFilms(url, fail_cb) {
  var that = this
  message.hide.call(that)
    wx.request({
      url: url,
      method: 'GET',
      header: {
        "Content-Type": "application/json,application/json"
      },
      success: function (res) {
        that.setData({
          films: res.data.subjects,
        })
        wx.hideLoading();
        wx.stopPullDownRefresh()
        typeof cb == 'function' && cb(res.data)
      },
      fail: function () {
        wx.hideLoading();
        message.show.call(that, {
          content: '网络开小差了',
          icon: 'offline',
          duration: 3000
        })
        wx.stopPullDownRefresh()
        typeof fail_cb == 'function' && fail_cb()
      }
    })
  
}

// 获取电影详情
function fetchFilmDetail(url, id, cb) {
  var that = this;
  message.hide.call(that)
  wx.showLoading({
    title: '加载中...',
  })
  wx.request({
    url: url + id + '?apikey=0df993c66c0c636e29ecbb5344252a4a',
    method: 'GET',
    header: {
      "Content-Type": "application/json,application/json"
    },
    success: function(res){
      that.setData({
        filmDetail: res.data,
        showLoading: false,
        showContent: true
      })
      wx.setNavigationBarTitle({
          title: res.data.title
      })
      wx.hideLoading();
      wx.stopPullDownRefresh()
      typeof cb == 'function' && cb(res.data)
    },
    fail: function() {
      wx.hideLoading();
      message.show.call(that,{
        content: '网络开小差了',
        icon: 'offline',
        duration: 3000
      })
    }
  })
}

const getData = (url, param) => {
  return new Promise((resolve, reject) => {
    wx.request({
      url: url,
      method: 'GET',
      data: param,
      success(res) {
        resolve(res.data.data)
      },
      fail(err) {
        reject(err)
      }
    })
  })
}

module.exports = {
  fetchFilms: fetchFilms,
  fetchFilmDetail: fetchFilmDetail,
  getData: getData
}