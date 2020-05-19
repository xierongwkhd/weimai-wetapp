// pages/subPages/comment-write/comment-write.js
const app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    movieId: 0,
    img: '',
    user_sc: '期待你的打分',
    stars: ['超烂','较差','一般','较好','不错','完美'],
    index: [0, 1, 2, 3, 4],
    normalSrc: '../../../image/user/star-empty.png',
    selectedSrc: '../../../image/user/star-full.png',
    halfSrc: '../../../image/user/star-half.png',
    key: 0,
    comment: '',
    hasComment: false
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    const movieId = options.movieId;
    const img = options.img;
    const content = options.content;
    console.log(content)
    if (content != 'undefined'){
      const sc = options.sc;
      this.setData({
        key: sc/2,
        comment: content,
        hasComment: true
      })
    }
    this.setData({
      movieId, img,
    })
  },
  //点击左边,半颗星
  selectLeft: function (e) {
    var that = this;
    var key = e.currentTarget.dataset.key
    if (this.data.key == 0.5 && e.currentTarget.dataset.key == 0.5) {
      //只有一颗星的时候,再次点击,变为0颗
      key = 0;
      this.setData({
        key: key,
        user_sc: '期待你的打分'
      })
      return
    }
    console.log("得" + key + "分")
    this.setData({
      key: key,
      user_sc: '分 ' + that.data.stars[parseInt(key-0.5)]
    })
  },
  //点击右边,整颗星
  selectRight: function (e) {
    var that = this
    var key = e.currentTarget.dataset.key
    this.setData({
      key: key,
      user_sc: '分 ' + that.data.stars[parseInt(key)]
    })
  },
  addComment: function () {
    if (this.data.comment == '' || this.data.key==0) return
    var that = this;
    wx.getStorage({
      key: 'userInfo',
      success: function (res1) {
        console.log(res1.data.data.token)
        wx.request({
          url: app.globalData.url +'/Comment/addComment',
          method: 'POST',
          header: {
            'content-type': 'application/x-www-form-urlencoded',
            'token': res1.data.data.token
          },
          data: {
            movieId: that.data.movieId,
            sc: that.data.key * 2,
            content: that.data.comment
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
            }else{
              var pages = getCurrentPages();
              pages[pages.length - 2].setData({
                isComment: true
              })
              wx.navigateBack({
                delta: 1
              })
            }
          }
        })
      },
      fail: function(res1){
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
  },
  inputHandler: function (e) {
    this.setData({
      comment: e.detail.value
    })
  }
})