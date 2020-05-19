<template>
  <div id="order-manage">
    <!--搜索-->
    <div class="top">
      <el-col :span="12">
        <el-input placeholder="请输入订单号" v-model="input" class="input-with-select" style="width: 100%">
          <el-button slot="append" icon="el-icon-search" @click="search">搜索</el-button>
        </el-input>
      </el-col>
      <el-col :span="2" :offset="1">
      </el-col>
    </div>
    <!--表格-->
    <div class="order-table">
      <el-table
        border
        :data="tableData"
        style="width: 100%">
        <el-table-column
          label="订单ID"
          align="center"
          width="70"
          prop="id">
        </el-table-column>
        <el-table-column
          label="商品ID"
          width="70"
          show-overflow-tooltip
          prop="itemId">
        </el-table-column>
        <el-table-column
          label="商品类型"
          show-overflow-tooltip
          prop="itemType">
        </el-table-column>
        <el-table-column
          label="档期/影院 ID"
          width="110"
          show-overflow-tooltip
          prop="relateId">
        </el-table-column>
        <el-table-column
          label="补充信息"
          width="150"
          show-overflow-tooltip
          prop="describe">
        </el-table-column>
        <el-table-column
          label="订单号"
          width="120"
          align="center"
          prop="orderId">
        </el-table-column>
        <el-table-column
          label="购买用户"
          align="center"
          prop="userNick">
        </el-table-column>
        <el-table-column
          label="总价"
          align="center"
          prop="price">
        </el-table-column>
        <el-table-column
          label="下单时间"
          width="200"
          show-overflow-tooltip
          prop="createTime">
        </el-table-column>
        <el-table-column 
        width="100"
        align="center"
        label="操作">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">撤销</el-button>
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
  </div>
</template>

<script>
    import {getCurrentPageBOrder,deleteOrder} from '../../../api/index'
    import {MessageBox,Message} from 'element-ui'
    export default {
        name: "OrderManage",
        data(){
          return{
            tableData:[],
            total:0,
            currentPage:1,
            dialogFormVisible:false,
            dialogTitle:'',
            labelPosition:'left',
            input:'',
            searchInput:'',
          }
        },
        created() {
          this.loadCurrentPageOrder(this.currentPage,8,'');
        },
        methods:{
          async loadCurrentPageOrder(currentPage,pageSize,input){
            const cinemaId = this.$cookies.get("cinemaId");
            let json = await getCurrentPageBOrder(currentPage,pageSize,input,cinemaId);
            if (json.state===200){
              this.tableData = json.data.beanList;
              this.total = json.data.tr;
            }
          },
          async currentChange(currentPage){
            this.currentPage = currentPage;
            this.loadCurrentPageOrder(this.currentPage,8,this.searchInput);
          },
          //搜索订单
          search(){
            this.searchInput = this.input;
            this.loadCurrentPageOrder(1,8,this.searchInput);
          },
          handleDelete(index, row) {
            MessageBox.confirm('此操作将永久删除该订单所有信息, 是否继续？','提示').then(async (value)=>{
              if (value==='confirm'){
                let json = await deleteOrder(row.id);
                if (json.state===200){
                  Message.success('删除该订单成功！');
                  this.loadCurrentPageOrder(this.currentPage,8,this.searchInput);
                }
              }
            });
            console.log(index, row);
          },
        }
    }
</script>

<style>
  .order-table{
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
    padding-left: 20%;
  }
</style>
