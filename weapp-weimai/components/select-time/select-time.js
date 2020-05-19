const util = require('../../utils/util.js')

Component({
  properties: {
    /**
     * 模拟日期列表时开头的时间
     */
    startTime: {
      type: String,
      value: util.getToday(),
      observer: function(start) {
        start && this.getWeek(start)
      }
    },
    /**
     * 默认选择的天数
     */
    defaultSelect: {
      type: String,
      value: '',
      observer: function(day) {
        day && this.setData({
          selectDay: day
        })
      }
    },
    /**
     * 日期列表
     */
    days: {
      type: Array,
      value: null,
      observer: function(days) {
        if (Array.isArray(days) && days.length) {
          this.setData({
            days
          },()=>{
            this.selectDay()
          })
        }
      }
    }
  },
  data: {
    selectDay: '',
    days: []
  },
  attached() {
    //如果没有传递日期列表，就模拟一个日期列表
    if (!this.properties.days) {
      this.getWeek(this.properties.startTime)
    }
  },
  methods: {
    //模拟7天时间列表
    getWeek(startTime) {
      const todayTomorrow = ['今天', '明天', '后天']
      const week = ['周日', '周一', '周二', '周三', '周四', '周五', '周六']
      let days = []
      //当开始时间大于今天时，日期从大的时间开始算（主要是为了“预售”时间）
      let start = util.getToday()
      if (startTime > start) { //都是“2018-09-12”的格式，所以可以直接相减，否则转化为毫秒在相减
        start = startTime
      }
      for (let i = 0; i < 7; i++) {
        let day = new Date(start)
        day.setDate(day.getDate() + i) //往后推几天
        const num = (day - new Date(util.getToday())) / (1000 * 60 * 60 * 24) //计算相隔几天，减少必须是“今天”0时0分
        days.push({
          title: `${todayTomorrow[num] || week[day.getDay()]}${day.getMonth() + 1}月${day.getDate()}日`, //获取类似 “后天9月1日” 的字符串
          day: util.formatTime(day).split(' ')[0]
        })
      }
      this.setData({
        days,
      }, () => {
        this.selectDay()
      })
    },
    selectDay(e) {
      const day = (e && e.currentTarget.dataset.day) || this.findDefaultDay() || this.data.days[0].day
      if (day === this.data.selectDay) {
        return
      }
      this.setData({
        selectDay: day
      })
      this.triggerEvent('selectDayEvent', {
        day
      })
    },
    findDefaultDay(){
      const day = this.data.days.find(item => item.day === this.properties.defaultSelect)
      return day && day.day
    }
  }
})