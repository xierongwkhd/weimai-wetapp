<template>
  <div id="hall-manage">
    <!--搜索-->
    <div class="top">
      <el-col :span="12">
        <el-input placeholder="请输入内容" v-model="input" class="input-with-select" style="width: 100%">
          <el-button slot="append" icon="el-icon-search" @click="search">搜索</el-button>
        </el-input>
      </el-col>
      <el-col :span="2" :offset="1">
        <el-button type="primary" size="small" @click="addHall">添加影厅</el-button>
      </el-col>
    </div>
    <!--表格-->
    <div class="hall-table">
      <el-table
        border
        :data="tableData"
      >
        <el-table-column
          label="影厅 ID"
          align="center"
          width="100"
          prop="id">
        </el-table-column>
        <el-table-column
          label="影院名"
          width="250"
          prop="cinemaNm">
        </el-table-column>
        <el-table-column
          label="影厅名"
          show-overflow-tooltip
          prop="hallType">
        </el-table-column>
        <el-table-column 
        width="100"
        align="center"
        label="影厅座位">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="info"
              @click="handleSeat(scope.$index, scope.row)">座位</el-button>
          </template>
        </el-table-column>
        <el-table-column 
        width="200"
        align="center"
        label="操作">
          <template slot-scope="scope">
            <el-button
              size="mini"
              @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
            <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <!--分页-->
    <div class="block" v-if="tableData.length">
      <el-pagination
        @current-change="currentChange"
        background
        layout="prev, pager, next"
        :page-size="8"
        :page-count="total">
      </el-pagination>
    </div>
    <!--修改影厅信息-->
    <div>
      <el-dialog
        :title="dialogTitle"
        :visible.sync="dialogFormVisible"
        :modal-append-to-body="false"
        v-if="dialogFormVisible"
        :showClose="false"
      >
        <el-form :label-position="labelPosition" :rules="rules" label-width="80px" :model="hallInfo">
          <el-form-item label="影院名" prop="cinemaNm">
            <el-col :span="18">
              <el-select v-model="hallInfo.cinemaId" placeholder="请选择影院" style="width: 100%">
                <el-option v-for="(item,index) in cinemaList" :key="index" :label="item.nm" :value="item.id"></el-option>
              </el-select>
            </el-col>
          </el-form-item>
          <el-form-item label="影厅名" prop="hallType">
            <el-col :span="18">
              <el-select v-model="hallInfo.hallTypeId" placeholder="请选择类型" style="width: 100%">
                <el-option v-for="(item,index) in hallTypeList" :key="index" :label="item.halltype" :value="item.id"></el-option>
              </el-select>
            </el-col>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="cancel">取 消</el-button>
          <el-button type="primary" @click="manageHallInfo()">确 定</el-button>
        </div>
      </el-dialog>
    </div>
    <!--添加影厅-->
    <div>
      <el-dialog
        title="添加影厅"
        :visible.sync="addDialogFormVisible"
        :modal-append-to-body="false"
        v-if="addDialogFormVisible"
        :show-close="false"
      >
        <el-form :label-position="labelPosition" :rules="rules" label-width="80px" :model="hallInfo">
          <el-form-item label="影院名" prop="cinemaNm">
            <el-col :span="12">
              <el-select v-model="addcinemaId" placeholder="请选择" style="width: 100%">
                <el-option v-for="(item,index) in cinemaList" :key="index" :label="item.nm" :value="item.id"></el-option>
              </el-select>
            </el-col>
          </el-form-item>
          <el-form-item label="影厅名" prop="hallType">
            <el-col :span="12">
              <el-select v-model="addHallTypeId" placeholder="请选择" style="width: 100%">
                <el-option v-for="(item,index) in hallTypeList" :key="index" :label="item.halltype" :value="item.id"></el-option>
              </el-select>
            </el-col>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="addDialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="commitAddHall()">确 定</el-button>
        </div>
      </el-dialog>
    </div>

    <!--影厅座位-->
    <div>
      <el-dialog
        title="座位信息"
        :visible.sync="seatDialogFormVisible"
        :modal-append-to-body="false"
        v-if="seatDialogFormVisible"
        :show-close="false"
      >
        <div class="seat">
            <div class='x' v-for="(value,index1) in seat" :key="index1">
                <div class='y' v-for="(item,index2) in value" :key="index2">
                  <img class="img" :src="require('../../../image/'+item.iconSrc)" @click="changSeat(item,index1,index2)"></img>
                </div>
            </div>
        </div>
        <div slot="footer" class="dialog-footer">
          <el-button @click="seatDialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="commitSeat()">确 定</el-button>
        </div>
      </el-dialog>
    </div>

    <!-- loading -->
    <div>
      <el-dialog
        title="座位生成中..."
        :visible.sync="loadingDialogFormVisible"
        :modal-append-to-body="false"
        v-if="loadingDialogFormVisible"
        :show-close="false"
      >
        <div class='sk-fading-circle'>
          <div class='sk-circle sk-circle-1'></div>
          <div class='sk-circle sk-circle-2'></div>
          <div class='sk-circle sk-circle-3'></div>
          <div class='sk-circle sk-circle-4'></div>
          <div class='sk-circle sk-circle-5'></div>
          <div class='sk-circle sk-circle-6'></div>
          <div class='sk-circle sk-circle-7'></div>
          <div class='sk-circle sk-circle-8'></div>
          <div class='sk-circle sk-circle-9'></div>
          <div class='sk-circle sk-circle-10'></div>
          <div class='sk-circle sk-circle-11'></div>
          <div class='sk-circle sk-circle-12'></div>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
    import {MessageBox,Message} from 'element-ui'
    import {getCurrentPageHall,deleteHall,updateHallInfo,addHall,getOptions,getSeats,commitSeat} from "../../../api";
    import Vue from "vue"
    export default {
        name: "HallManage",
        data(){
          return{
            tableData:[],
            total:0,
            currentPage:1,
            hallInfo:{},
            cinemaList: [],
            hallTypeList: [],
            dialogFormVisible:false,
            dialogTitle:'',
            labelPosition:'right',
            input:'',
            searchInput:'',
            hallOldName:'',
            addDialogFormVisible:false,
            seatDialogFormVisible:false,
            loadingDialogFormVisible:false,
            seat:[[]],
            seats: [],
            changeSeat:[],
            newSeat:[],
            addcinemaId:'',
            addHallTypeId:'',
            xSeat:15,
            ySeat:15,

            rules: {
              addcinemaId: [
                { required: true, message: '影院名不能为空', trigger: 'change' },
              ],
              addHallTypeId: [
                { required: true, message: '影厅名不能为空', trigger: 'blur' },
              ]
            },
          }
        },
        created(){
          this.loadCurrentPageHall(this.currentPage,8,'');
        },
        methods:{
          async loadCurrentPageHall(currentPage,pageSize,input){
            let json = await getCurrentPageHall(currentPage,pageSize,input);
            if (json.state===200){
              this.tableData = json.data.beanList;
              this.total = json.data.tr;
            }
          },
          async loadOptions(){
            let json = await getOptions();
            if (json.state===200){
              this.hallTypeList = json.data.hallTypes;
              this.cinemaList = json.data.cinemas;
            }
          },
          async currentChange(currentPage){
            this.currentPage = currentPage;
            this.loadCurrentPageHall(this.currentPage,8,this.searchInput);
          },
          //修改影厅信息
          async manageHallInfo(){
              if (this.dialogTitle === '编辑影厅信息') {
                if (this.hallInfo.cinemaId && this.hallInfo.hallTypeId){
                  let json = await updateHallInfo(this.hallInfo.id,this.hallInfo.cinemaId,this.hallInfo.hallTypeId);
                  if (json.state===200){
                    this.dialogFormVisible = false;
                    this.loadCurrentPageHall(this.currentPage,8,this.searchInput);
                    Message.success('修改影厅信息成功！');
                  } else{
                    Message.error(json.message);
                  }
                } else{
                  Message.error('请完成必填内容！');
                }
              }
          },
          handleEdit(index, row) {
            this.loadOptions();
            this.dialogTitle = '编辑影厅信息';
            this.hallInfo = row;
            this.dialogFormVisible = true;
            console.log(index, row);
          },
          handleSeat(index,row){
            this.dialogTitle = '影厅座位信息';
            this.hallInfo = row;
            this.seats = [];
            this.seat = [];
            this.newSeat = [];
            this.changeSeat = [];
            this.setSeat();
            this.seatDialogFormVisible = true;
          },
          handleDelete(index, row) {
            console.log(index, row);
            MessageBox.confirm('此操作将永久删除该影厅所有信息, 是否继续？','提示').then(async (value)=>{
              if (value==='confirm'){
                let json = await deleteHall(row.id);
                if (json.state===200){
                  Message.success('删除该影厅成功！');
                  this.loadCurrentPageHall(this.currentPage,8,this.searchInput);
                }
              }
            });
            console.log(index, row);
          },
          //搜索影院
          search(){
            this.searchInput = this.input;
            this.loadCurrentPageHall(1,8,this.searchInput);
          },
          cancel(){
            this.loadCurrentPageHall(this.currentPage,8,this.searchInput);
            this.dialogFormVisible = false;
          },
          async addHall(){
            this.loadOptions();
            this.addcinemaId = '';
            this.addHallTypeId = '';
            this.hallInfo = {};
            this.addDialogFormVisible = true;
          },
          async commitAddHall(){
              let json = await addHall(this.addcinemaId,this.addHallTypeId);
              if (json.state===200) {
                this.addDialogFormVisible = false;
                Message.success('添加影厅成功！');
                this.loadCurrentPageHall(this.currentPage,8,this.searchInput);
              } else if (json.error_code===1){
                Message.error(json.message);
              }
          },
          async setSeat() {
            this.seat = [];
            this.seats = [];
            let json = await getSeats(this.hallInfo.id);
            this.seats = json.data;
            let yArray = [];
            //遍历座位信息中的 yCoord 行数，保存到 yArray 中
            if(this.seats.length>0){
              for (let a = 0; a < this.seats.length; a++) {
                if (yArray.indexOf(this.seats[a].yCoord) == -1) {
                  yArray.push(this.seats[a].yCoord);
                }
              }
              let totalArray = [];
              for (let b = 0; b < yArray.length; b++) {
                let xxA = [];
                for (let c = 0; c < this.seats.length; c++) {
                  if (yArray[b] == this.seats[c].yCoord) {
                    if (this.seats[c].type == "danren") {//单人座
                        this.seats[c].iconSrc = "seatPre.png";//增加座位图片字段
                    } else if (this.seats[c].type == "road") {//过道
                      this.seats[c].iconSrc = "noSeat.png";
                    } 
                    xxA.push(this.seats[c]);
                  }
                }
                totalArray.push(xxA);//每一行保存到 totalArray 中
              }
              this.seat = totalArray;
              for(let i=this.seat.length;i<this.ySeat;i++){
                let xxA = [];
                let tmp = {};
                tmp.yCoord = i;
                tmp.xCoord = 0;
                tmp.iconSrc = "noSeat.png";
                xxA.push(tmp);
                this.seat.push(xxA);
              }
              for(let i=0;i<this.ySeat;i++){
                for(let j=0;j<this.xSeat;j++){
                  if(j>this.seat[i].length){
                    let tmp = {};
                    tmp.yCoord = i;
                    tmp.xCoord = j;
                    tmp.iconSrc = "noSeat.png";
                    this.seat[i].push(tmp);
                  }
                }
              }
            }else{
              let totalArray = [];
              for(let i=0;i<this.ySeat;i++){
                let xxA = [];
                for(let j=0;j<this.xSeat;j++){
                  let tmp = {};
                  tmp.yCoord = i;
                  tmp.xCoord = j;
                  tmp.iconSrc = "noSeat.png";
                  xxA.push(tmp);
                }
                totalArray.push(xxA);
              }
              this.seat = totalArray;
            }
          },
          changSeat(item,index1,index2){
            console.log(index1,index2);
            if(this.seat[index1][index2].iconSrc === 'noSeat.png'){
              this.seat[index1][index2].iconSrc = 'seatPre.png';
            }else{
              this.seat[index1][index2].iconSrc = 'noSeat.png';
            }
            this.seat.push();
            //有id为改变已有座位
            if(item.id){
              const index = this.changeSeat.indexOf(item);
              if(index != -1){
                this.changeSeat.splice(index,1);
              }else{
                this.changeSeat.push(item);
              }
              console.log(this.changeSeat);
            }else{
              //无id为增加座位
              const index = this.newSeat.indexOf(item);
              if(index != -1){
                this.newSeat.splice(index,1);
              }else{
                this.newSeat.push(item);
              }
              console.log(this.newSeat);
            }
          },
          async commitSeat(){
            if(this.newSeat.length>0 || this.changeSeat.length>0){
              this.loadingDialogFormVisible = true;
              let json = await commitSeat(this.hallInfo.id,JSON.stringify(this.newSeat),JSON.stringify(this.changeSeat));
              if(json.state===200){
                this.loadingDialogFormVisible = false;
                this.seatDialogFormVisible = false;
                Message.success('修改座位信息成功！');
                this.loadCurrentPageHall(this.currentPage,8,this.searchInput);
              }else{
                Message.error(json.message);
              }
            }
          }
        }
    }
</script>

<style>
  .hall-table{
    width:90%;
    min-width:900px;
    margin: 0 auto;
    margin-bottom: 30px;
  }
  .top{
    display: flex;
    justify-content: center;
    align-items: center;
    /* padding: 30px 0; */
    margin-bottom: 30px;
  }
  .block{
    text-align: center;
  }
  .el-dialog__header{
    text-align: center;
  }
  .el-dialog__body .el-form-item{
    width: 80%;
    padding-left: 20%;
  }
  .x {
    display: flex;
    flex-direction: row;
  }
  .y {
    display: flex;
    flex-direction: column;
  }
  .img {
    margin: 1px;
    height: 30px;
    width: 30px;
  }
  .seat {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    justify-content: flex-start;
    align-items: center;
  }
  .sk-fading-circle {
  width: 4em;
  height: 4em;
  position: relative;
  margin: auto;
}
.sk-fading-circle .sk-circle {
  width: 100%;
  height: 100%;
  position: absolute;
  left: 0;
  top: 0;
}
.sk-fading-circle .sk-circle:before {
  content: '';
  display: block;
  margin: 0 auto;
  width: 15%;
  height: 15%;
  background-color: #337ab7;
  border-radius: 100%;
  -webkit-animation: sk-fading-circle-delay 1.2s infinite ease-in-out both;
          animation: sk-fading-circle-delay 1.2s infinite ease-in-out both;
}
.sk-fading-circle .sk-circle-2 {
  -webkit-transform: rotate(30deg);
          transform: rotate(30deg);
}
.sk-fading-circle .sk-circle-3 {
  -webkit-transform: rotate(60deg);
          transform: rotate(60deg);
}
.sk-fading-circle .sk-circle-4 {
  -webkit-transform: rotate(90deg);
          transform: rotate(90deg);
}
.sk-fading-circle .sk-circle-5 {
  -webkit-transform: rotate(120deg);
          transform: rotate(120deg);
}
.sk-fading-circle .sk-circle-6 {
  -webkit-transform: rotate(150deg);
          transform: rotate(150deg);
}
.sk-fading-circle .sk-circle-7 {
  -webkit-transform: rotate(180deg);
          transform: rotate(180deg);
}
.sk-fading-circle .sk-circle-8 {
  -webkit-transform: rotate(210deg);
          transform: rotate(210deg);
}
.sk-fading-circle .sk-circle-9 {
  -webkit-transform: rotate(240deg);
          transform: rotate(240deg);
}
.sk-fading-circle .sk-circle-10 {
  -webkit-transform: rotate(270deg);
          transform: rotate(270deg);
}
.sk-fading-circle .sk-circle-11 {
  -webkit-transform: rotate(300deg);
          transform: rotate(300deg);
}
.sk-fading-circle .sk-circle-12 {
  -webkit-transform: rotate(330deg);
          transform: rotate(330deg);
}
.sk-fading-circle .sk-circle-2:before {
  -webkit-animation-delay: -1.1s;
          animation-delay: -1.1s;
}
.sk-fading-circle .sk-circle-3:before {
  -webkit-animation-delay: -1s;
          animation-delay: -1s;
}
.sk-fading-circle .sk-circle-4:before {
  -webkit-animation-delay: -0.9s;
          animation-delay: -0.9s;
}
.sk-fading-circle .sk-circle-5:before {
  -webkit-animation-delay: -0.8s;
          animation-delay: -0.8s;
}
.sk-fading-circle .sk-circle-6:before {
  -webkit-animation-delay: -0.7s;
          animation-delay: -0.7s;
}
.sk-fading-circle .sk-circle-7:before {
  -webkit-animation-delay: -0.6s;
          animation-delay: -0.6s;
}
.sk-fading-circle .sk-circle-8:before {
  -webkit-animation-delay: -0.5s;
          animation-delay: -0.5s;
}
.sk-fading-circle .sk-circle-9:before {
  -webkit-animation-delay: -0.4s;
          animation-delay: -0.4s;
}
.sk-fading-circle .sk-circle-10:before {
  -webkit-animation-delay: -0.3s;
          animation-delay: -0.3s;
}
.sk-fading-circle .sk-circle-11:before {
  -webkit-animation-delay: -0.2s;
          animation-delay: -0.2s;
}
.sk-fading-circle .sk-circle-12:before {
  -webkit-animation-delay: -0.1s;
          animation-delay: -0.1s;
}

@-webkit-keyframes sk-fading-circle-delay {
  0%, 39%, 100% {
    opacity: 0;
  }
  40% {
    opacity: 1;
  }
}

@keyframes sk-fading-circle-delay {
  0%, 39%, 100% {
    opacity: 0;
  }
  40% {
    opacity: 1;
  }
}
</style>
