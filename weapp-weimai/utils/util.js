function formatTime(date) {
  var year = date.getFullYear()
  var month = date.getMonth() + 1
  var day = date.getDate()

  // var hour = date.getHours()
  // var minute = date.getMinutes()
  // var second = date.getSeconds()


  return [month, day,year].map(formatNumber).join('/')
  //+ ' ' + [hour, minute, second].map(formatNumber).join(':')
}

function formatYear(date) {
  var year = date.getFullYear()
  var month = date.getMonth() + 1
  var day = date.getDate()

  return [year, month, day].map(formatNumber).join('-')
}

function formatNumber(n) {
  n = n.toString()
  return n[1] ? n : '0' + n
}

function formatDate(date) {
  var month = date.getMonth() + 1
  var day = date.getDate()

  return (month+'月'+day+'日')
}

function formatNumber(n) {
  n = n.toString()
  return n[1] ? n : '0' + n
}

const throttle = (func, interval = 250) => {
  let timeout;
  let startTime = new Date();
  return function (event) {
    clearTimeout(timeout);
    let curTime = new Date();
    if (curTime - startTime <= interval) {
      //小于规定时间间隔时，用setTimeout在指定时间后再执行
      timeout = setTimeout(() => {
        func.call(this, event);
      }, interval)
    } else {
      //重新计时并执行函数
      startTime = curTime;
      func.call(this, event);
    }
  }
}

const getToday = () => {
  const today = new Date()
  return formatTime(new Date()).split(' ')[0]
}

const calcTime = (time) => {
  if (!time) {
    return
  }
  const day = new Date(time)
  const now = new Date()
  const result = now.getTime() - day.getTime()
  if (now.getFullYear() !== day.getFullYear()) {
    return time.split(' ')[0]
  }
  //一分钟前评论
  if (result < 60000) {
    return '刚刚'
  }
  if (60000 <= result && result < 3600000) {
    return `${Math.floor(result / 60000)}分钟前`
  }
  if (3600000 <= result && result < 86400000) {
    return `${Math.floor(result / 3600000)}小时前`
  }
  if (86400000 <= result && result < 604800000) {
    return `${Math.floor(result / 86400000)}天前`
  }
  return `${formatNumber(day.getMonth() + 1)}-${formatNumber(day.getDate())}`

}

//获取指定区间的随机整数
const getRandom = (lowerValue, upperValue, isFormat) => {
  const num = Math.floor(Math.random() * (upperValue - lowerValue + 1) + lowerValue);
  if (isFormat) {
    return formatNumber(num);
  } else {
    return num
  }
}

function getDate() {
  var time = new Date()
  var year = time.getFullYear()
  var month = time.getMonth()
  month = month < 10 ? '0' + month : month
  var day = time.getDay()
  day = day < 10 ? '0' + day : day
  return [year, month, day].join('-')
}

function getTime() {
  var time = new Date()
  var hours = time.getHours()
  hours = hours < 10 ? '0' + hours : hours
  var minute = time.getMinutes()
  minute = minute < 10 ? '0' + minute : minute
  var second = time.getSeconds()
  second = second < 10 ? '0' + second : second
  return [hours, minute, second].join(':')
}

module.exports = {
  formatTime: formatTime,
  throttle,
  getToday,
  getRandom,
  calcTime,
  formatDate: formatDate,
  formatYear: formatYear,
  formatNumber: formatNumber,
  getDate: getDate,
  getTime: getTime
}
