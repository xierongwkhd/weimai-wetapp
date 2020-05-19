Component({
  /**
   * 组件的属性列表
   */
  properties: {
    cityCinemaInfo: {
      type: Object
    },
    hidden:{
      type: Boolean,
      value: true,
      observer: function (newVal){
        if (newVal){
          this.setData({
            itemNum: -1
          })
        }
      }
    }
  },

  /**
   * 组件的初始数据
   */
  data: {
    itemNum: -1,
    itemName1: '全城',
    itemName2: '品牌',
    itemName3: '特色',
    selectBrandId: -1, //选择的品牌ID
    selectServiceId: -1, //选择的服务ID
    selectHallTypeId: -1, //选择的特殊厅ID
    selectRegion:'全城'
  },
  created() {
    //自己实现的一个watch。因为不能在外面直接写watch，所以只能定义在这里
    const watch = {
      itemNum: (value) => {
        this.triggerEvent('toggleShow', {
          item: value
        })
      }
    }
    this._setWatcher(this.data, watch)
  },
  /**
   * 组件的方法列表
   */
  methods: {
    //导航栏的点击事件
    selectItemNum(e) {
      const itemNum = e.currentTarget.dataset.itemNum
      let num = itemNum
      if (this.data.itemNum !== -1) {
        num = itemNum === this.data.itemNum ? -1 : itemNum
      }
      this.setData({
        itemNum: num
      })
    },
    //蒙板的点击事件
    cancal() {
      this.setData({
        itemNum: -1
      })
    },
    //选择品牌的点击事件
    selectBrand(e) {
      const brand = e.currentTarget.dataset.brand
      let brandName = brand.brand
      if (brand.id === -1) {
        brandName = '品牌'
      }
      this.triggerEvent('change', {
        brandId: brand.id
      })
      this.setData({
        selectBrandId: brand.id,
        itemName2: brandName,
        itemNum: -1
      })
    },
    //特色重置按钮
    specialReset() {
      this.setData({
        selectServiceId: -1,
        selectHallTypeId: -1,
      })
    },
    //特色选择按钮
    specialSelectItem(e) {
      const {
        type,
        typeId
      } = e.currentTarget.dataset
      if (type === 'service') {
        this.setData({
          selectServiceId: typeId
        })
      } else {
        this.setData({
          selectHallTypeId: typeId
        })
      }
    },
    //特色确定按钮
    specialConfirm() {
      const {
        selectServiceId,
        selectHallTypeId
      } = this.data
      console.log()
      this.triggerEvent('change', {
        serviceId: selectServiceId,
        hallType: selectHallTypeId
      })
      this.setData({
        itemNum: -1
      })
    },
    //行政区域的点击事件
    regionClick(e) {
      const region = e.currentTarget.dataset.region
      if (region=='全城'){
        this.triggerEvent('change', {
          selectRegion: ''
        })
      }else{
        this.triggerEvent('change', {
          selectRegion: region
        })
      }
      this.setData({
        selectRegion: region,
        itemNum: -1,
        itemName1: region
      })
    },
    //简单实现类似vue的watch
    _setWatcher(data, watch) {
      Object.keys(watch).forEach(key => {
        this._observe(data, key, watch[key])
      })
    },
    _observe(obj, key, func) {
      let val = obj[key]
      Object.defineProperty(obj, key, {
        configurable: true,
        enumerable: true,
        set: function(newVal) {
          if (newVal === val) {
            return
          }
          val = newVal;
          func(newVal); // 赋值(set)时，调用对应函数
        },
        get: function() {
          return val;
        }
      })
    }
  },
  attached() {
  }
})