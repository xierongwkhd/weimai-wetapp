const fetch = require("../../../locale/fetch.js")
const util = require('../../../utils/util.js')
const formatNumber = util.formatNumber
const getRandom = util.getRandom
const app = getApp()
Page({
  data: {
    first: true, //只在第一次提示
    height: "",
    //页面显示座位
    seat: [],
    //原有座位
    seats: [],
    lineTop: 0,
    lineHeight: "",
    lineArray: [],
    columnNumber: 0,
    //选择的座位
    selectSeatList: [],
    totalMoney: "",
    totalMoneyFloat: 0.00,
    movie:{},
    price: 0,
    info: {}
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    // 页面跳转传参：电影票价格，电影信息
    const cinema = JSON.parse(options.cinema)
    const movie = JSON.parse(options.movie);
    const info = JSON.parse(options.info)
    const time = new Date(info.startTime)
    info.startTime = '今天' + (time.getMonth()+1) + '月' + time.getDate()+'日 '
      + time.getHours() + ':' + time.getMinutes() + ":" + time.getSeconds()
                      +"  国语2D"
    this.setData({
      info: info,
      price: info.price,
      movie: movie,
      cinemaDetail: cinema
    })
    var that = this;
    new Promise((resolve, reject) => {
      wx.request({
        url: app.globalData.url +`/cinema/getSeatByHallId/${info.hallId}?timesId=${info.id}`,
        method: 'GET',
        success(res) {
          resolve(res.data.data)
        },
        fail(err) {
          reject(err)
        }
      })
    }).then(seats => {
      that.setData({
        seats: seats
      })
      that.setSeat();
    })
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  setSeat: function() {
    let yArray = [];
    //遍历座位信息中的 yCoord 行数，保存到 yArray 中
    for (let a = 0; a < this.data.seats.length; a++) {
      if (yArray.indexOf(this.data.seats[a].yCoord) == -1) {
        yArray.push(this.data.seats[a].yCoord);
      }
    }
    //console.log(yArray);
    let totalArray = [];
    for (let b = 0; b < yArray.length; b++) {
      let xxA = [];
      //遍历地 b 行 的所有座位，进行判断
      for (let c = 0; c < this.data.seats.length; c++) {
        if (yArray[b] == this.data.seats[c].yCoord) {
          if (this.data.seats[c].type == "danren") {//单人座
            if (this.data.seats[c].status == "ok") {
              this.data.seats[c].iconSrc = "../../../image/icon/seatPre.png";//增加座位图片字段
            } else {
              this.data.seats[c].iconSrc = "../../../image/icon/seatDone.png";
            }
          } else if (this.data.seats[c].type == "road") {//过道
            this.data.seats[c].iconSrc = "";
          }
          this.data.seats[c].select = false;
          xxA.push(this.data.seats[c]);
        }
      }
      totalArray.push(xxA);//每一行保存到 totalArray 中
    }
    this.setData({
      seat: totalArray,
      lineArray: yArray,
      columnNumber: yArray.length
    })
    //console.log(totalArray);

    //与行号显示相关
    const query = wx.createSelectorQuery()
    query.select('#seatView').boundingClientRect()
    query.exec((res) => {
      //console.log(res);
      let height = res[0].height;
      let newHeight = height / yArray.length;
      let top = res[0].top;
      this.setData({
        lineHeight: newHeight,
        lineTop: top
      })
    })
  },
  //movable-view相关
  onChange(e) {
    const query = wx.createSelectorQuery()
    query.select('#seatView').boundingClientRect()
    query.exec((res) => {
      //console.log(res);
      let height = res[0].height;
      let top = res[0].top;
      let newHeight = height / this.data.columnNumber;
      this.setData({
        lineHeight: newHeight,
        lineTop: top
      })
    })
  },
  onScale(e) {
    const query = wx.createSelectorQuery()
    query.select('#seatView').boundingClientRect()
    query.exec((res) => {
      //console.log(res);
      let height = res[0].height;
      let top = res[0].top;
      let newHeight = height / this.data.columnNumber;
      this.setData({
        lineHeight: newHeight,
        lineTop: top
      })
    })
  },
  //选座座位触发
  selectSeat(e) {
    let x = e.currentTarget.dataset.index + 1;
    let y = e.currentTarget.dataset.ix + 1;
    let totalArray = this.data.seat;
    for (var a = 0; a < totalArray.length; a++) {
      for (var b = 0; b < totalArray[a].length; b++) {
        let item = totalArray[a][b];
        if (item.yCoord == x && item.xCoord == y && item.status == 'ok' && item.type != 'road') {
          let totalMoney = 0.00;
          let totalMoneyStr = "";
          if (item.select == true) {
            item.select = false;
            item.iconSrc = "../../../image/icon/seatPre.png";
            let seatInfo = item.yCoord + "排" + item.xCoord + "座";
            this.remove(seatInfo);
            totalMoney = parseFloat(this.data.totalMoneyFloat) - parseFloat(this.data.price);
            totalMoneyStr = totalMoney.toString();
            if (totalMoney == 0) {
              totalMoneyStr = "";
            }
          } else {
            if (this.data.selectSeatList.length == 6) {
              wx.showToast({
                title: '最多选择6个座位',
                icon: 'none',
                duration: 1000,
                mask: true
              })
            } else {
              item.select = true;
              item.iconSrc = "../../../image/icon/selectIcon.png";
              let seat = {};
              let seatInfo = item.yCoord + "排" + item.xCoord + "座";
              seat.id = item.id;
              seat.seatInfo = seatInfo;
              seat.xCoord = item.xCoord;
              seat.yCoord = item.yCoord;
              seat.index = item.xCoord + item.yCoord;
              this.data.selectSeatList.push(seat);
              totalMoney = parseFloat(this.data.totalMoneyFloat) + parseFloat(this.data.price);
              totalMoneyStr = totalMoney.toString();
            }
          }
          this.setData({
            selectSeatList: this.data.selectSeatList,
            totalMoney: totalMoneyStr,
            totalMoneyFloat: totalMoney
          })
        }
      }
    }
    this.setData({
      seat: totalArray
    })
  },
  //移除已选座座位信息
  remove(val) {
    for (var a = 0; a < this.data.selectSeatList.length; a++) {
      if (this.data.selectSeatList[a].seatInfo == val) {
        this.data.selectSeatList.splice(a, 1);
        break;
      }
    }
    this.setData({
      selectSeatList: this.data.selectSeatList
    })
  },
  //叉叉符号事件
  cancelSeat(e) {
    let index = e.currentTarget.dataset.index;
    let x = e.currentTarget.dataset.x;
    let y = e.currentTarget.dataset.y;
    let totalArray = this.data.seat;
    for (var a = 0; a < totalArray.length; a++) {
      for (var b = 0; b < totalArray[a].length; b++) {
        if (totalArray[a][b].xCoord == x && totalArray[a][b].yCoord == y) {
          totalArray[a][b].select = false;
          totalArray[a][b].iconSrc = "../../../image/icon/seatPre.png";
          break;
        }
      }
    }
    for (var c = 0; c < this.data.selectSeatList.length; c++) {
      if (this.data.selectSeatList[c].index == index) {
        this.data.selectSeatList.splice(c, 1);
        break;
      }
    }
    let totalMoney = this.data.totalMoneyFloat - parseFloat(this.data.price);
    let totalMoneyStr = totalMoney.toString();
    if (totalMoney == 0) {
      totalMoneyStr = "";
    }
    this.setData({
      seat: totalArray,
      selectSeatList: this.data.selectSeatList,
      totalMoney: totalMoneyStr,
      totalMoneyFloat: totalMoney
    })
  },
  //无商户号无法对接微信支付，这里模拟一下支付后的流程
  submit() {
     //添加订单信息
    const cinemaDetail = this.data.cinemaDetail;
    const movie = this.data.movie;
    const info = this.data.info;
    const paramsStr = JSON.stringify({
      cinemaName: cinemaDetail.nm,//电影院名
      cinemaId: cinemaDetail.id,//电影院ID
      hall:info.hallId,//大厅
      movieName: movie.nm,//电影名
      movieImg:movie.img,//海报
      movieId:movie.id,
      timesId:info.id,
      time: info.startTime,//时间
      price: this.data.totalMoney,//票价
      seat: this.data.selectSeatList,//座位 seat.seatInfo
      Vcode: getRandom(100000,999999), //模拟6位数的验证码
      flowNumber: getRandom(100000000, 999999999), //模拟9位数的流水号,
      orderId: getRandom(1000000000, 9999999999), //模拟10位数的订单号,
      cinemaData: cinemaDetail.cinemaData,//影院信息
    })
    //只提示一次
    if (this.data.first){
      wx.showModal({
        title: '提示',
        content: '此小程序仅为学习，不会产生任何支付',
        success: (res) => {
          this.setData({
            first:false
          })
          if (res.confirm) {
            wx.navigateTo({
              url: `/pages/subPages/buy-ticket/buy-ticket?paramsStr=${paramsStr}`,
            })
          }
        }
      })
    } else {
      wx.navigateTo({
        url: `/pages/subPages/buy-ticket/buy-ticket?paramsStr=${paramsStr}`,
      })
    }
  }

})