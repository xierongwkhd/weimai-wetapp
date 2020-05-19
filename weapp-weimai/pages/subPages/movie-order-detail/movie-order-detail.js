Page({
  data:{
    order:null
  },
  onLoad(opt){
    const paramsObj = JSON.parse(opt.paramsStr)
    this.initData(paramsObj)
  },
  initData(order){
    this.setData({
      order
    })
  }
})