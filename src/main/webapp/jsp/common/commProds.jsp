<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<style>
    .separator { background: #dadada; }
    .container-prods .wrapper-header { position: absolute; width: 144px; height: 39px; line-height: 40px; top: -8px; left: 15px; color: #fff; text-align: center;
        background: url(${points_image_path}/header-blue-1.png) no-repeat; position:absolute !important;}
    .container-prods .text-more { text-decoration: none; margin-right: 5px; font-size: 12px; }
    .container-prods .list-products { padding: 10px; font-size: 12px; }
    .container-prods .list-products li { margin-left: 10px; list-style: none; text-align: center; }
    .container-prods .product-image { width: 150px; height: 150px; border: 1px solid #dadada; cursor: pointer; display: block; margin: 0 auto; }
    .container-prods .card-product a { text-decoration: none; }
    .container-prods .product-title { height: 24px; line-height: 24px; display: block; overflow: hidden; word-wrap: break-word; word-break:break-all;}
    .container-prods .product-summary { font-size: 12px; height: 30px; line-height: 15px; display: block; overflow: hidden; }
    .container-prods .product-points { font-size: 12px !important; }
    .container-prods .product-button { padding: 6px 50px; font-size: 12px; margin-top: 10px; }
</style>

<div class="wrapper-header heading3">推荐商品</div>
<div class="spacer10 clear"></div>
<div class="wrapper-header2">
    <a class="text-more text-blue right" href="${points_cxt_path}/shop/category/all" target="_blank">更多<span class="icon-more"></span></a>
    <div class="spacer10 clear"></div>
</div>
<ul class="list-products">
    <s:iterator value="#request.products" var="product" status="status">
    <li>
        <a class="product-image" href="${points_cxt_path}/shop/product/${product.id}" target="_blank" title="${product.name}"><img src="${product.thumbnail}" /></a>
        <div class="spacer10 clear"></div>
        <div class="card-product">
            <a href="${points_cxt_path}/shop/product/${product.id}" target="_blank" class="product-title bLinkBlue heading3" title="${product.name}">${product.name}</a>
            <div class="spacer5 clear"></div>
            <a href="${points_cxt_path}/shop/product/${product.id}" target="_blank" class="product-summary bLinkDark" title="${product.desc}">${product.desc}</a>
            <div class="spacer5 clear"></div>
            <p class="product-points heading4"><s:text name="bshare.points.need.points"><s:param value="%{#product.currentPoints}"/></s:text></p>
        </div>
        <!-- <a class="product-like bsLikeDiv" href="${main_cxt_path}"></a> -->
        <a class="product-button bButton-blue" href="${points_cxt_path}/shop/product/${product.id}" target="_blank">查看详细</a>
        <div class="spacer10 clear"></div>
        <div class="spacer1 clear separator"></div>
        <div class="spacer10 clear"></div>
    </li>
    </s:iterator>
</ul>
<div class="clear"></div>
