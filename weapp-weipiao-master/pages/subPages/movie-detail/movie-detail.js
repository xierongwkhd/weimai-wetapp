const util = require('../../../utils/util.js');
const app = getApp();
Page({
  data:{
    detailMovie: null,
    isFold:true,
    comments:{},   //观众评论
    showst: 0, //1想看 2预售 3上映
    movieId: 0,
    isWish: false,
    isComment: false,
    comment:{}
  },
  onLoad(options){
    const movieId = options.movieId;
    const showst = options.showst;
    this.setData({
      showst,movieId
    })
    this.initPage(movieId);
  },
  //初始页面
  initPage(movieId){
    const _this = this
    wx.showLoading({
      title: '加载中...',
    })
    this.getComment(movieId)
    wx.request({
      url: app.globalData.url +`/home/getMovieById/${movieId}`,
      success(res) {
        wx.hideLoading()
        res.data.data.movie = _this.handleData(res.data.data.movie)
        //console.log(res.data.data.movie)
        _this.setData({
          detailMovie: res.data.data
        })
      }
    })
    wx.getStorage({
      key: 'userInfo',
      success: function (res1) {
        console.log(res1.data.data.token)
        wx.request({
          url: app.globalData.url +'/home/getIsWish',
          method: 'GET',
          header: {
            'token': res1.data.data.token
          },
          data: {
            movieId: _this.data.movieId,
          },
          success: function (res) {
              _this.setData({
                isWish: res.data.data
              })
          }
        })
        wx.request({
          url: app.globalData.url +'/Comment/getIsComment',
          method: 'GET',
          header: {
            'token': res1.data.data.token
          },
          data: {
            movieId: _this.data.movieId,
          },
          success: function (res) {
            if(res.data.data==null) return
            _this.setData({
              comment: res.data.data,
              isComment: true
            })
          }
        })
      }
    })
  },
  //获取观众评论
  getComment(movieId){
    const _this = this
    wx.getStorage({
      key: 'userInfo',
      success: function (res1) {
        wx.request({
          url: app.globalData.url +`/Comment/getHotComment/${movieId}`,
          header: {
            'token': res1.data.data.token
          },
          success(res){
            if(res.data.state ==200){
              var com = res.data.data;
              com.comList = _this.formatData(res.data.data.comList);
              console.log(com);
              _this.setData({
                comments: com
              })
            }
          }
        })
      },
      fail: function (res1){
        wx.request({
          url: app.globalData.url + `/Comment/getHotComment/${movieId}`,
          success(res) {
            if (res.data.state == 200) {
              var com = res.data.data;
              com.comList = _this.formatData(res.data.data.comList);
              console.log(com);
              _this.setData({
                comments: com
              })
            }
          }
        })
      }
    })
  },
  //处理数据
  formatData(arr) {
    let list = []
    if (arr.length) {
      list = arr.map(item => {
        let temp = { ...item }
        temp.stars = this.formatStar(temp.sc/2)
        temp.calcTime = util.calcTime(temp.calcTime)
        return temp
      })
    }
    return list
  },
  //预览图片
  previewImage(e){
    const currentIndex = e.currentTarget.dataset.index
    const urls = this.data.detailMovie.photos.map(item => item.replace('180w_140h','375w_250h'))
    wx.previewImage({
      urls,
      current: urls[currentIndex]
    })
  },
  //处理评分星星
  formatStar(sc){
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
  //处理数据
  handleData(data){
    //小程序的{{}}中不能调用函数，只能在这里处理数据
    let obj = data
    //将类似“v3d imax”转化为['3D','IMAX']
    obj.version = obj.version && obj.version.split(' ').map(item=>{
      return item.toUpperCase().replace('V','')
    })
    //将评分人数单位由个转化为万
    obj.snum = obj.snum/10000
    obj.snum = obj.snum.toFixed(1)
    //评分星星,满分10分，一颗满星代表2分
    obj.stars = this.formatStar(obj.sc/2)
    //处理上映日期
    obj.rt = util.formatYear(new Date(obj.rt))
    return obj
  },
  //折叠与展开剧情简介
  toggleFold(){
    this.setData({
      isFold:!this.data.isFold
    })
  },
  //跳转到video页面
  toVideo(){
    const detailMovie = this.data.detailMovie.movie;
    const paramsStr = JSON.stringify({
      video:{
        videourl: detailMovie.videoUrl,
        videoImg: detailMovie.videoImg,
        videoName: detailMovie.videoName,
      },
      movieName: detailMovie.nm,  //电影名称
      id: detailMovie.id,//电影ID
      version: detailMovie.version, //电影类型（3d、IMAX）
      release: detailMovie.src, //上映时间
      rt: detailMovie.rt,//电影上映时间
      wish: detailMovie.wish, //想看的人数
      globalReleased: detailMovie.globalreleased, //是否上映
      sc: detailMovie.sc, //评分
      showst: detailMovie.showst,//判读“想看”、“预售”
      cat: detailMovie.cat
    })
    wx.navigateTo({
      url: `../video-page/video-page?paramsStr=${paramsStr}`
    })
  },
  goCommentWrite: function(){
    var that = this
    wx.navigateTo({
      url: `../comment-write/comment-write?movieId=` + that.data.detailMovie.movie.id + `&img=` + that.data.detailMovie.movie.img + `&sc=` + that.data.comment.sc + `&content=` + that.data.comment.content
    })
    
  },
  wantToWatch: function(){
    var that = this
    wx.getStorage({
      key: 'userInfo',
      success: function (res1) {
        console.log(res1.data.data.token)
        wx.request({
          url: app.globalData.url +'/home/updateWish',
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
                success(res){
                  wx.switchTab({
                    url: '/pages/user/user',
                  })
                }
              })
            }else{
              that.setData({
                isWish: !that.data.isWish
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
  upApprove: function(e){
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