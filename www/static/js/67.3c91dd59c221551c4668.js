webpackJsonp([67],{"90P1":function(e,t){},nt6X:function(e,t,s){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var c={name:"HelloWorld",data:function(){return{msg:"Welcome to Your Vue.js App",notCheck:s("iLaJ"),checked:s("JG3o"),select:s("QF9x"),show:!1,list:[{checked:!0,name:"张三丰",img:s("4T9I")},{checked:!1,name:"金毛狮王",img:s("4T9I")},{checked:!1,name:"金轮法王",img:s("4T9I")},{checked:!1,name:"杨过",img:s("4T9I")},{checked:!1,name:"小龙女",img:s("4T9I")},{checked:!1,name:"金毛狮王",img:s("4T9I")}],typeList:[{selected:!0,name:"擦黑板"},{selected:!1,name:"地面扫"},{selected:!1,name:"物品摆放"},{selected:!1,name:"倒垃圾"},{selected:!1,name:"擦黑板"},{selected:!1,name:"地面扫"}]}},methods:{returns:function(){this.$router.go(-1)},issue:function(){},isChecked:function(e){var t=this.list;if(!t[e].checked)for(var s in t)t[s].checked=!1;t[e].checked=!0,this.list=t},choose:function(){this.show=!this.show},confirm:function(){this.show=!1},dutyType:function(e){var t=this.typeList;if(!t[e].selected)for(var s in t)t[s].selected=!1;t[e].selected=!0,this.typeList=t}}},i={render:function(){var e=this,t=e.$createElement,c=e._self._c||t;return c("div",[c("div",{staticClass:"loginNav"},[c("img",{staticClass:"return",attrs:{src:s("Du5+"),alt:""},on:{click:e.returns}}),e._v(" "),c("p",{staticClass:"title f30 cfff text-center"},[e._v("值日生设置")]),e._v(" "),c("span",{staticClass:"f26 cfff pr-30",staticStyle:{position:"absolute",top:"0",right:"0","line-height":"0.84rem","z-index":"99"},on:{click:e.choose}},[e._v("管理")])]),e._v(" "),c("van-popup",{attrs:{position:"top",overlay:!0},model:{value:e.show,callback:function(t){e.show=t},expression:"show"}},[c("div",{staticClass:"cfff f28 dropDown"},[c("ul",e._l(e.typeList,function(t,s){return c("li",{key:s,on:{click:function(t){e.dutyType(s)}}},[e._v("\n                    "+e._s(t.name)+"\n                    "),c("img",{style:{display:t.selected?"block":"none"},attrs:{src:e.select}})])})),e._v(" "),c("div",[c("p",{staticStyle:{"border-right":"1px solid #6671f2"},on:{click:function(t){e.show=!1}}},[e._v("取消")]),e._v(" "),c("p",{on:{click:e.confirm}},[e._v("确定")])])])]),e._v(" "),c("div",{staticClass:"content f28 c333",staticStyle:{padding:"0.84rem 0 1.7rem"}},[c("ul",{staticClass:"pl-30"},e._l(e.list,function(t,s){return c("li",{key:s,staticClass:"b_line pr-30"},[c("img",{attrs:{src:t.checked?e.checked:e.notCheck},on:{click:function(t){e.isChecked(s)}}}),e._v(" "),c("img",{staticClass:"headPic",attrs:{src:t.img}}),e._v(" "),c("span",[e._v(e._s(t.name))]),e._v(" "),c("span",{staticClass:"onDuty f20 cfff ml-20",style:{display:t.checked?"block":"none"}},[e._v("值日生")])])}))]),e._v(" "),c("div",{staticClass:"centerBtn f26 cfff text-center",on:{click:e.issue}},[e._v("设置为值日生")])],1)},staticRenderFns:[]};var n=s("C7Lr")(c,i,!1,function(e){s("90P1")},"data-v-05b96ef2",null);t.default=n.exports}});
//# sourceMappingURL=67.3c91dd59c221551c4668.js.map