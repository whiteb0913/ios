webpackJsonp([14],{P7pY:function(t,e){t.exports="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpEMDY5ODJCOUI2NjgxMUU4QTkzRDkxNUNFNEM3RTY3MiIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpEMDY5ODJCQUI2NjgxMUU4QTkzRDkxNUNFNEM3RTY3MiI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkQwNjk4MkI3QjY2ODExRThBOTNEOTE1Q0U0QzdFNjcyIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkQwNjk4MkI4QjY2ODExRThBOTNEOTE1Q0U0QzdFNjcyIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+m7e6PAAAAfJJREFUeNqsldlKw0AUhtNYl3rlghuidQFRERFcqF7o27TP1BcRRFxBVLxyKaJeqPWmDW5NG5Eu1v/AHwjjJLbGAx8zaZPzz5xz5kwkmUwaPhYF/aAbxEAElEEBWOBDXkqn00aQRTW/tYIpEActAd/mwTUoBgmYynMX2AATdO6Ae3AFLsAteOW7A2A9lUrFGxUQ56sMhzg+A7t0LiKP4AYcgX2GSb6fh8jkbwJtYJkhewaHIBewMAnLKXckNguRviCBadABSlx51WjMZEdZzmUnpk6gHYzw+bIJ565lWF2dYEgnMMixwPA0ZShTWdADH4d1Aj2c54y/W55jt04gxrkTQqDkFgvyEFUF3MRUQwh8eeYRVaDCeUcIgXaOdXWhImBz3htCwM1jEUmvqwKW5+i3/lHALXNLl+QXJinKJteU8QT3MTxZv5Oc4TihOywBJmW5xPkjwuP4CVhsaGKLYFytBo1JzhLceQ3c/dZNZRdPdDzHtj3qqRCDLXyAjXGNzuv8fRnh+pHDiOZGGwMzymVUI23Ku1mywv/ewQlCVfG7cAz2lR12Stuzctf5J++GA3AOZ28Yj9nw5E5JeHdi+sS3zF4vTjZ58eyBLbDN2832NDzbT8RsoFJq7FMlOvDrqloR0/hH04gs/KuAIiK7dr4FGABVBZAAMr8VeAAAAABJRU5ErkJggg=="},QK2f:function(t,e){},YKTJ:function(t,e,s){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var i={name:"HelloWorld",data:function(){return{msg:"Welcome to Your Vue.js App",notCheck:s("iLaJ"),checked:s("JG3o"),select:s("QF9x"),show:!1,search:"",list:[],typeList:[],typeId:"",typeName:""}},methods:{returns:function(){this.$router.push({path:"/cadresList"})},issue:function(){},isChecked:function(t){var e=this.list;e[t].checked&&e[t].station_id==this.typeId?e[t].checked=!e[t].checked:e[t].checked&&e[t].station_id!=this.typeId?(e[t].station_id=this.typeId,e[t].ucStation=this.typeName):(e[t].station_id=this.typeId,e[t].ucStation=this.typeName,e[t].checked=!e[t].checked),this.list=e},choose:function(){this.show=!this.show},confirm:function(){if(0!=this.typeList.length){var t=null;for(var e in this.typeList)if(this.typeList[e].selected){t=e;break}this.typeId=this.typeList[t].id,this.typeName=this.typeList[t].name,this.show=!1}else this.$toast("暂无可选项")},dutyType:function(t){var e=this.typeList;if(!e[t].selected)for(var s in e)e[s].selected=!1;e[t].selected=!0,this.typeList=e},getStudent:function(){var t=this;this.$toast.loading({mask:!0,message:"加载中...",duration:0}),this.$http({url:this.$api.class.getStudent},{classesId:JSON.parse(localStorage.getItem("zhxy_user")).classesId}).then(function(e){if(console.log(e),0==e.code){for(var s in e.data)e.data[s].station_id?e.data[s].checked=!0:e.data[s].checked=!1;t.list=e.data,t.$toast.clear()}else t.$toast(e.msg)},function(e){t.$toast(data.msg)})},getAllStation:function(){var t=this;this.$http({url:this.$api.class.getAllStation},{schoolId:JSON.parse(localStorage.getItem("zhxy_user")).schoolId}).then(function(e){if(console.log(e),0==e.code){for(var s in e.data)0==s?(e.data[s].selected=!0,t.typeId=e.data[s].id,t.typeName=e.data[s].name):e.data[s].selected=!1;t.typeList=e.data}})},saveOrUpdataStation:function(){var t=this,e=[],s=[];for(var i in this.list)this.list[i].checked&&(e.push(this.list[i].id),s.push(this.list[i].station_id));if(0!=e.length){var a={ids:e.toString(),stationIds:s.toString(),classesId:JSON.parse(localStorage.getItem("zhxy_user")).classesId};this.$http({url:this.$api.class.saveOrUpdataStation},a).then(function(e){console.log(e),0==e.code?(t.$toast("设置成功"),t.$router.push({path:"/cadresList"})):t.$toast(e.msg)},function(e){t.$toast(data.msg)})}else this.$toast("暂无设置项")}},created:function(){this.getStudent(),this.getAllStation()}},a={render:function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{attrs:{id:"setDu"}},[i("div",{staticClass:"loginNav"},[i("img",{staticClass:"return",attrs:{src:s("Du5+"),alt:""},on:{click:t.returns}}),t._v(" "),i("p",{staticClass:"title f30 cfff text-center"},[t._v("班干部设置")]),t._v(" "),i("span",{staticClass:"f26 cfff pr-30",staticStyle:{position:"absolute",top:"0",right:"0","line-height":"0.84rem","z-index":"99"},on:{click:t.choose}},[t._v("管理")])]),t._v(" "),i("van-popup",{attrs:{position:"top",overlay:!0},model:{value:t.show,callback:function(e){t.show=e},expression:"show"}},[i("div",{staticClass:"cfff f28 dropDown"},[i("ul",t._l(t.typeList,function(e,s){return i("li",{key:s,on:{click:function(e){t.dutyType(s)}}},[t._v("\n                    "+t._s(e.name)+"\n                    "),i("img",{style:{display:e.selected?"block":"none"},attrs:{src:t.select}})])})),t._v(" "),i("div",[i("p",{staticStyle:{"border-right":"1px solid #6671f2"},on:{click:function(e){t.show=!1}}},[t._v("取消")]),t._v(" "),i("p",{on:{click:t.confirm}},[t._v("确定")])])])]),t._v(" "),i("div",{staticClass:"content f28 c333",staticStyle:{padding:"0.84rem 0 1.7rem"}},[i("div",[i("input",{directives:[{name:"model",rawName:"v-model",value:t.search,expression:"search"}],staticClass:"f24",attrs:{type:"text",placeholder:"搜索"},domProps:{value:t.search},on:{input:function(e){e.target.composing||(t.search=e.target.value)}}}),t._v(" "),i("img",{style:{display:t.search?"none":"block"},attrs:{src:s("P7pY"),alt:""}})]),t._v(" "),i("ul",{staticClass:"pl-30"},t._l(t.list,function(e,s){return i("li",{key:s,staticClass:"b_line pr-30",on:{click:function(e){t.isChecked(s)}}},[i("img",{attrs:{src:e.checked?t.checked:t.notCheck}}),t._v(" "),i("img",{staticClass:"headPic",attrs:{src:t.$api.fileUrl+e.headImage}}),t._v(" "),i("span",[t._v(t._s(e.username))]),t._v(" "),i("span",{staticClass:"onDuty f20 cfff ml-20",style:{display:e.checked?"block":"none"}},[t._v(t._s(e.ucStation))])])}))]),t._v(" "),i("div",{staticClass:"centerBtn f26 cfff text-center",on:{click:t.saveOrUpdataStation}},[t._v("设置为班干部")])],1)},staticRenderFns:[]};var c=s("C7Lr")(i,a,!1,function(t){s("QK2f")},"data-v-28fe2e4d",null);e.default=c.exports}});
//# sourceMappingURL=14.237d56d63c8a980cd7bd.js.map