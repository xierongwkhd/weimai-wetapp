<template>
  <div id="user-manage">
    <!--搜索-->
    <div class="top">
      <el-col :span="12">
        <el-input
          placeholder="请输入内容"
          v-model="input"
          class="input-with-select"
          clearable
          style="width: 100%"
        >
          <el-button slot="append" icon="el-icon-search" @click="search">搜索</el-button>
        </el-input>
      </el-col>
    </div>
    <!--表格-->
    <div class="user-table">
      <el-table border :data="tableData">
        <el-table-column label="用户 ID" align="center" width="100" prop="id"></el-table-column>
        <el-table-column
          label="用户名"
          align="center"
          width="120"
          show-overflow-tooltip
          prop="nickName"
        ></el-table-column>
        <el-table-column label="性别" align="center" width="60" prop="gender"></el-table-column>
        <el-table-column label="OpenId" show-overflow-tooltip prop="openId"></el-table-column>
        <el-table-column label="最近登录" align="center" width="400" prop="lastLogin"></el-table-column>
        <el-table-column label="是否禁用" align="center" width="60" prop="isBanned" :formatter="formatBoolean"></el-table-column>
        <el-table-column align="center" width="200" label="操作">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">禁止/解禁</el-button>
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
        :page-count="total"
      ></el-pagination>
    </div>
  </div>
</template>
<script>
import {
  getCurrentPageUser,
  updateUserInfo
} from "../../../api/index";
import { MessageBox, Message } from "element-ui";
import {banUserById} from "../../../api/index";
export default {
  name: "UserManage",
  data() {
    let checkName = (rule, value, callback) => {
      if (!value) {
        callback(new Error("用户名不能为空！"));
      } else {
        callback();
      }
    };
    let checkPhone = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入手机号码"));
      } else {
        if (/^1[3|4|5|6|7|8][0-9]{9}$/.test(value)) {
          callback();
        } else {
          callback(new Error("请输入正确格式的手机号码"));
        }
      }
    };
    let checkPassword = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入密码"));
      } else {
        callback();
      }
    };
    return {
      //服务器地址
      server: "http://localhost:8080",
      tableData: [],
      total: 0,
      currentPage: 1,
      userInfo: {},
      dialogFormVisible: false,
      dialogTitle: "",
      labelPosition: "right",
      input: "",
      searchInput: "",
      rules: {
        user_name: [
          { required: true, message: "请输入用户名", trigger: "blur" }
        ],
        phone: [
          { required: true, message: "请输入手机号码", trigger: "blur" },
          { validator: checkPhone, trigger: "blur" }
        ],
        password: [{ required: true, message: "请输入密码", trigger: "blur" }]
      },
      pickerBirthday: {
        disabledDate(time) {
          return time.getTime() > Date.now();
        }
      }
    };
  },
  created() {
    this.loadCurrentPageUser(this.currentPage, 8, "");
  },
  methods: {
    async loadCurrentPageUser(currentPage, pageSize, input) {
      let json = await getCurrentPageUser(currentPage, pageSize, input);
      if (json.state === 200) {
        this.tableData = json.data.beanList;
        this.total = json.data.tr;
      }
    },
    async handleEdit(index, row) {
      MessageBox.confirm('此操作可能禁用该用户, 是否继续？','提示').then(async (value)=>{
        if (value==='confirm'){
          let json = await banUserById(row.id);
          if (json.state===200){
            this.loadCurrentPageUser(this.currentPage,8,this.searchInput);
            Message.success('更改成功');
          }
        }
      });
    },
    async currentChange(currentPage) {
      this.currentPage = currentPage;
      this.loadCurrentPageUser(this.currentPage, 8, this.searchInput);
    },
    formatBoolean: function (row, column, cellValue) {
      var ret = ''  //你想在页面展示的值
      if (cellValue) {
        ret = "是"  //根据自己的需求设定
      } else {
        ret = "否"
      }
      return ret;
    },
    cancel() {
      this.loadCurrentPageUser(this.currentPage, 8, this.searchInput);
      this.dialogFormVisible = false;
    },
    //搜索用户
    search() {
      this.searchInput = this.input;
      this.loadCurrentPageUser(1, 8, this.searchInput);
    },
  }
};
</script>

<style scoped>
.user-table {
  width: 90%;
  min-width: 900px;
  margin: 0 auto;
  margin-bottom: 30px;
}
.top {
  display: flex;
  justify-content: center;
  align-items: center;
  /* padding: 30px 0; */
  margin-bottom: 30px;
}
.block {
  text-align: center;
}
.el-dialog__header {
  text-align: center;
}
.el-dialog__body .el-form-item {
  padding-left: 20%;
}
</style>
