const util = require('../../../utils/util.js')
const getRandom = util.getRandom
const app = getApp()
Page({
  data: {
    info: null,
    videoList: [], //播放列表
    current: -1, //当前播放视频索引
    infoList: [],
    isWish: false
  },
  onLoad(opt) {
    const paramsObj = JSON.parse(opt.paramsStr)
    this.initData(paramsObj)
  },
  initData(obj) {
    //没有获取video列表的API，所以只能自己模拟一个播放列表
    // const random = getRandom(1, 4)
    //const videoList = new Array(random).fill(obj.video)
    var that = this;
    wx.getStorage({
      key: 'userInfo',
      success: function (res1) {
        wx.request({
          url: app.globalData.url + `/home/getLikeMovieList?movieId=${obj.id}&cat=${obj.cat}`,
          method: 'GET',
          header: {
            'token': res1.data.data.token
          },
          success(res) {
            console.log(res);
            var likeVideos = res.data.data;
            const videoList = [{
              ...obj.video
            }]
            for (var i in likeVideos) {
              videoList.push({
                videourl: likeVideos[i].videoUrl,
                videoImg: likeVideos[i].videoImg,
                videoName: likeVideos[i].videoName,
              })
            }
            // likeVideos.unshift(obj);
            that.setData({
              videoList,
              info: obj,
              infoList: likeVideos
            }, () => {
              that.setCurrent(0)
            })
          }
        })
      },
      fail: function(res1){
          wx.request({
            url: app.globalData.url + `/home/getLikeMovieList?movieId=${obj.id}&cat=${obj.cat}`,
            method: 'GET',
            success(res) {
              console.log(res);
              var likeVideos = res.data.data;
              const videoList = [{
                ...obj.video
              }]
              for (var i in likeVideos) {
                videoList.push({
                  videourl: likeVideos[i].videoUrl,
                  videoImg: likeVideos[i].videoImg,
                  videoName: likeVideos[i].videoName,
                })
              }
              // likeVideos.unshift(obj);
              that.setData({
                videoList,
                info: obj,
                infoList: likeVideos
              }, () => {
                that.setCurrent(0)
              })
            }
          })
      }
    })
  },
  //设置当前播放视频
  setCurrent(current) {
    var {
      info,
      videoList
    } = this.data
    if(current>0){
      const detailMovie = this.data.infoList[current-1];
      info = {
        movieName: detailMovie.nm,  //电影名称
        id: detailMovie.id,//电影ID
        version: detailMovie.version && detailMovie.version.split(' ').map(item => {
          return item.toUpperCase().replace('V', '')
        }), //电影类型（3d、IMAX）
        release: detailMovie.src, //上映时间
        rt: detailMovie.rt,//电影上映时间
        wish: detailMovie.wish, //想看的人数
        globalReleased: detailMovie.globalreleased, //是否上映
        sc: detailMovie.sc, //评分
        showst: detailMovie.showst,//判读“想看”、“预售”
        cat: detailMovie.cat
      };
    }
    if(info.showst==1){
      var that = this;
      wx.getStorage({
        key: 'userInfo',
        success: function (res1) {
          wx.request({
            url: app.globalData.url + '/home/getIsWish',
            method: 'GET',
            header: {
              'token': res1.data.data.token
            },
            data: {
              movieId: info.id,
            },
            success: function (res) {
              that.setData({
                isWish: res.data.data
              })
            }
          })
        }
      })
    }
    wx.setNavigationBarTitle({
      title: `${info.movieName} ${videoList[current].videoName}`,
    })
    this.setData({
      info,
      current
    })
  },
  //播放列表的点击事件
  selectItem(e) {
    const index = e.currentTarget.dataset.index
    if (index !== this.data.current) {
      this.setCurrent(index)
    }
  },
  //视频播放结束
  endHandle() {
    const {
      current,
      videoList
    } = this.data
    let index = current + 1
    if (index === videoList.length) {
      index = 0
    }
    this.setCurrent(index)
  },
  //播放错误时
  errorHandle() {
    wx.showToast({
      title: '播放错误',
      icon: 'none'
    })
  },
  //购票
  goTo() {
    const info = this.data.info;
    const VideoContext = wx.createVideoContext('my-video', this);
    VideoContext.pause()
    wx.navigateTo({
      url: `../select-cinema/select-cinema?movieId=${info.id}&movieName=${info.movieName}&showTime=${info.rt}`,
    })
  },
  //想看
  wantToWatch: function () {
    var that = this
    wx.getStorage({
      key: 'userInfo',
      success: function (res1) {
        console.log(res1.data.data.token)
        wx.request({
          url: app.globalData.url + '/home/updateWish',
          method: 'POST',
          header: {
            'content-type': 'application/x-www-form-urlencoded',
            'token': res1.data.data.token
          },
          data: {
            movieId: that.data.movieId,
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
              that.setData({
                isWish: !that.data.isWish
              })
              var pages = getCurrentPages();
              var prevPage = pages[pages.length - 2];  //上一个页面
              var isWish = prevPage.data.isWish
              prevPage.setData({
                isWish: !isWish
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