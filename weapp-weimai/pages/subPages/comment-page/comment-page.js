const util = require('../../../utils/util.js')
const app = getApp()
Page({
  data:{
    movieId:'',
    cmts:[], //最新评论
    hcmts:[], //热门评论
    hasMore: true, //是否还有
    pageNum: 0,
    limit: 6
  },
  onLoad(options){
    this.initPage(options)
  },
  //初始化页面
  initPage(options){
    const movieId = options.movieId
    const movieName = options.movieName
    wx.setNavigationBarTitle({
      title: `观众评论-${movieName}`
    })
    wx.showLoading({
      title: '正在加载...',
    })
    this.getHotComment(movieId)
    this.getComment(movieId)
    this.setData({
      movieId
    })
  },
  onReachBottom(){
    this.getComment(this.data.movieId)
  },
  //获取热门观众评论
  getHotComment(movieId) {
    const _this = this
    //热门评论
    wx.getStorage({
      key: 'userInfo',
      success: function (res1) {
        wx.request({
          url: app.globalData.url +`/Comment/getHotComment/${movieId}`,
          header: {
            'token': res1.data.data.token
          },
          success(res) {
            wx.hideLoading() 
            _this.setData({
              hcmts: _this.formatData(res.data.data.comList),
            })
          }
        })
      },
      fail: function (res1){
        wx.request({
          url: app.globalData.url + `/Comment/getHotComment/${movieId}`,
          success(res) {
            wx.hideLoading()
            _this.setData({
              hcmts: _this.formatData(res.data.data.comList),
            })
          }
        })
      }
    })
  },
  //分页获取最新评论
  getComment(movieId){
    if(!this.data.hasMore) return;
    var pageNum = this.data.pageNum;
    var that = this;
    wx.getStorage({
      key: 'userInfo',
      success: function (res1) {
        wx.request({
          url: app.globalData.url +`/Comment/getComment/${movieId}`,
          method: 'GET',
          header: {
            'token': res1.data.data.token
          },
          data: {
            pageNum: ++pageNum,
            limit: that.data.limit
          },
          success: function(res){
            console.log(res.data.data)
            const cmts = that.data.cmts.concat(that.formatData(res.data.data.beanList))
            that.setData({
              hasMore: pageNum < res.data.data.tr,
              cmts: cmts,
              pageNum: pageNum
            })
          }
        })
      },
      fail:function(res1){
        wx.request({
          url: app.globalData.url + `/Comment/getComment/${movieId}`,
          method: 'GET',
          data: {
            pageNum: ++pageNum,
            limit: that.data.limit
          },
          success: function (res) {
            console.log(res.data.data)
            const cmts = that.data.cmts.concat(that.formatData(res.data.data.beanList))
            that.setData({
              hasMore: pageNum < res.data.data.tr,
              cmts: cmts,
              pageNum: pageNum
            })
          }
        })
      }
    })
  },
  //处理数据
  formatData(arr){
    let list = []
    if(arr.length){
      list = arr.map(item => {
        let temp = { ...item }
        //temp.purchase = !!(temp.tagList && temp.tagList.fixed.some(item => item.id === 4))
        temp.stars = this.formatStar(temp.sc)
        temp.calcTime = util.calcTime(temp.calcTime)
        return temp
      })
    }
    return list
  },
  //处理评分星星
  formatStar(sc) {
    //1分对应满星，0.5对应半星
    let stars = new Array(5).fill('star-empty')
    const fullStars = Math.floor(sc)  //满星的个数
    const halfStar = sc % 1 ? 'star-half' : 'star-empty' //半星的个数，半星最多1个
    stars.fill('star-full', 0, fullStars)              //填充满星
    if (fullStars < 5) {
      stars[fullStars] = halfStar;           //填充半星
    }
    return stars
  },
  upApprove: function (e) {
    console.log(e)
    var that = this
    wx.getStorage({
      key: 'userInfo',
      success: function (res1) {
        console.log(res1.data.data.token)
        wx.request({
          url: app.globalData.url + '/Comment/upApprove',
          method: 'POST',
          header: {
            'content-type': 'application/x-www-form-urlencoded',
            'token': res1.data.data.token
          },
          data: {
            commentId: e.target.dataset.hi,
          },
          success: function (res) {
            if (res.data.state == 202) {
              wx.showModal({
                content: '您还未登录',
                success(res) {
                  wx.switchTab({
                    url: '/pages/user/user',
                  })
                }
              })
            } else {
              const index = e.target.dataset.index;
              that.data.comments.comList[index].hasApprove = !that.data.comments.comList[index].hasApprove;
              that.setData({
                comments: that.data.comments
              })
            }
          }
        })
      },
      fail: function (res1) {
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
  }
})