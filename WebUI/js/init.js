/// <reference path="jquery.min.js" />

$(function () {
    //初始化左侧功能树（不同用户显示的树是不同的）
    initLogin();
});
function initLogin() {
    $('#treeLeft').tree({    //初始化左侧功能树（不同用户显示的树是不同的）
        method: 'GET',
        url: 'ashx/bg_menu.ashx?action=getUserMenu',
        lines: true,
        onClick: function (node) {    //点击左侧的tree节点  打开右侧tabs显示内容
            if (node.attributes) {
                addTab(node.text, node.attributes.url, node.iconCls);
            }
        },
    });
}