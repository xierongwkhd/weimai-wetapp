<template>
  <div id="user-manage">
    <!--搜索-->
    <div class="top">
      <el-col :span="12">
        <el-input placeholder="请输入内容" v-model="input" class="input-with-select" style="width: 100%">
          <el-button slot="append" icon="el-icon-search" @click="search">搜索</el-button>
        </el-input>
      </el-col>
      <el-col :span="2" :offset="1">
        <el-button type="primary" size="small" @click="addAdmin">添加管理员</el-button>
      </el-col>
    </div>
    <!--表格-->
    <div class="user-table">
      <el-table border :data="tableData">
        <el-table-column label="用户 ID" align="center" width="80" prop="id"></el-table-column>
        <el-table-column
          label="用户名"
          align="center"
          width="300"
          prop="name"
        ></el-table-column>
        <el-table-column label="账号" align="center" width="150" prop="username"></el-table-column>
        <el-table-column label="密码" align="center" width="150" prop="password"></el-table-column>
        <el-table-column label="所属影院" align="center" show-overflow-tooltip prop="cinemaNm"></el-table-column>
        <el-table-column align="center" width="200" label="操作">
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
        :page-count="total"
      ></el-pagination>
    </div>

    <!--修改管理员信息-->
    <div>
      <el-dialog
        :title="dialogTitle"
        :visible.sync="dialogFormVisible"
        :modal-append-to-body="false"
        v-if="dialogFormVisible"
        :showClose="false"
      >
        <el-form :label-position="labelPosition" :rules="rules" label-width="80px" :model="userInfo">
            <el-form-item label="用户名" prop="name">
              <el-col :span="16">
                <el-input v-model="userInfo.name"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="账号" prop="username">
              <el-col :span="16">
                <el-input v-model="userInfo.username"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="密码" prop="password">
              <el-col :span="16">
                <el-input v-model="userInfo.password"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="所属角色" prop="roleId">
            <el-col :span="18">
              <el-select v-model="userInfo.roleId" placeholder="请选择角色" style="width: 100%">
                <el-option v-for="(item,index) in roleList" :key="index" :label="item.name" :value="item.id"></el-option>
              </el-select>
            </el-col>
          </el-form-item>
          <el-form-item label="所属影院" prop="cineamId">
            <el-col :span="18">
              <el-select v-model="userInfo.cineamId" placeholder="请选择影院" style="width: 100%">
                <el-option v-for="(item,index) in cinemaList" :key="index" :label="item.nm" :value="item.id"></el-option>
              </el-select>
            </el-col>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="cancel">取 消</el-button>
          <el-button type="primary" @click="manageUserInfo()">确 定</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>
<script>
import {
  getCurrentPageAdmin,
  updateAdminInfo,
  getOptions3
} from "../../../api/index";
import { MessageBox, Message } from "element-ui";
export default {
  name: "AdminManage",
  data() {
    return {
      tableData: [],
      total: 0,
      currentPage: 1,
      userInfo: {},
      dialogFormVisible: false,
      dialogTitle: "",
      labelPosition: "right",
      input: "",
      searchInput: "",
      cinemaList: [],
      roleList: [],
      rules: {
        name: [
            { required: true, message: '用户名不能为空', trigger: 'change' },
        ],
        username: [
            { required: true, message: '账号不能为空', trigger: 'change' },
        ],
        password: [
            { required: true, message: '密码不能为空', trigger: 'change' },
        ],
        roleId: [
            { required: true, message: '角色不能为空', trigger: 'change' },
        ],
      },
    };
  },
  created() {
    this.loadCurrentPageUser(this.currentPage, 8, "");
  },
  methods: {
    async loadCurrentPageUser(currentPage, pageSize, input) {
      let json = await getCurrentPageAdmin(currentPage, pageSize, input);
      if (json.state === 200) {
        this.tableData = json.data.beanList;
        this.total = json.data.tr;
      }
    },
    async handleEdit(index, row) {
        this.loadOptions();
        this.dialogTitle = '编辑管理员信息';
        this.userInfo = row;
        this.dialogFormVisible = true;
        console.log(index, row);
    },
    async loadOptions(){
        let json = await getOptions3();
        if (json.state===200){
            this.roleList = json.data.roles;
          this.cinemaList = json.data.cinemas;
        }
    },
    async manageUserInfo(){
        if (this.userInfo.username && this.userInfo.password && this.userInfo.roleId){
            let json = await updateAdminInfo(this.userInfo.id,this.userInfo.name,this.userInfo.username,this.userInfo.password,this.userInfo.roleId,this.userInfo.cineamId);
            if (json.state===200){
                this.dialogFormVisible = false;
                this.loadCurrentPageUser(this.currentPage,8,this.searchInput);
                Message.success('修改管理员信息成功！');
            } else{
                Message.error(json.message);
            }
        } else{
            Message.error('请完成必填内容！');
        }
    },
    async currentChange(currentPage) {
      this.currentPage = currentPage;
      this.loadCurrentPageUser(this.currentPage, 8, this.searchInput);
    },
    cancel() {
      this.loadCurrentPageUser(this.currentPage, 8, this.searchInput);
      this.dialogFormVisible = false;
    },
    addAdmin(){
        this.loadOptions();
        this.hallInfo = {};
        this.dialogFormVisible = true;
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