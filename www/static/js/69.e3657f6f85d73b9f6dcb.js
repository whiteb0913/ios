webpackJsonp([69],{"0ZNk":function(t,e){},B9Jv:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var s={name:"HelloWorld",data:function(){return{content:""}},methods:{returns:function(){this.$router.go(-1)},submit:function(){var t=this;""!=this.content?this.$http({url:this.$api.my.addFeedback},{content:this.content,origin:2,submitId:JSON.parse(localStorage.getItem("zhxy_user")).id}).then(function(e){console.log(e),0==e.code?(t.$toast("提交成功"),t.$router.push({path:"/setting"})):t.$toast("提交失败")}):this.$toast("反馈不能为空！")}}},a={render:function(){var t=this,e=t.$createElement,s=t._self._c||e;return s("div",{staticStyle:{width:"100%",overflow:"hidden",position:"relative",height:"100vh"}},[s("div",{staticClass:"loginNav"},[s("img",{staticClass:"return",attrs:{src:n("Du5+"),alt:""},on:{click:t.returns}}),t._v(" "),s("p",{staticClass:"title f30 cfff text-center"},[t._v("意见反馈")])]),t._v(" "),s("textarea",{directives:[{name:"model",rawName:"v-model",value:t.content,expression:"content"}],staticClass:"textarea f26",attrs:{name:"",id:"",placeholder:"请输入您的反馈意见，我们亲耳恭听.....",cols:"30",rows:"10"},domProps:{value:t.content},on:{input:function(e){e.target.composing||(t.content=e.target.value)}}}),t._v(" "),s("div",{staticClass:"centerBtn f26 cfff text-center",on:{click:t.submit}},[t._v("提交")])])},staticRenderFns:[]};var o=n("C7Lr")(s,a,!1,function(t){n("0ZNk")},"data-v-03a4f6f8",null);e.default=o.exports}});
//# sourceMappingURL=69.e3657f6f85d73b9f6dcb.js.map