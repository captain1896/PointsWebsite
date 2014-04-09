package com.buzzinate.bshare.points.action.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.ExceptionHandler;
import com.buzzinate.bshare.points.bean.Merchant;
import com.buzzinate.bshare.points.bean.PointsProduct;
import com.buzzinate.bshare.points.bean.ProductCategory;
import com.buzzinate.bshare.points.bean.enums.PointsStatModule;
import com.buzzinate.bshare.points.service.MerchantService;
import com.buzzinate.bshare.points.service.PointsOperateHisService;
import com.buzzinate.bshare.points.service.PointsProductService;
import com.buzzinate.bshare.points.service.ProductCategoryService;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.Pagination;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ModelDriven;

/**
 * Product Manage Action(It's Just an Exercise!~)
 * 
 * @author Lucas
 * @since 2012-10-10 10:24
 */
@Controller
@Scope("request")
public class LucasProductManageAction extends BaseAction implements
		ModelDriven<PointsProduct> {

	private static final long serialVersionUID = 4351301391343825289L;

	private static final Pattern IS_NUMERIC = Pattern.compile("[0-9]+");// 该正则表达式用来判断字符串是否全部是数字

	private static final String DEFAULT_PAGE_NO = "1";// 默认的分页起始页

	private static final int PAGESIZE = ConfigurationReader
			.getInt("bshare.points.activities.perpage");// 分页用

	@Autowired
	private PointsProductService pointsProductService;
	@Autowired
	private MerchantService merchantService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private PointsOperateHisService operateHisService;

	private List<PointsProduct> pointsProducts;
	private PointsProduct pointsProduct = new PointsProduct();

	private ExceptionHandler handler = new ExceptionHandler(
			getText("bshare.shop.exception.productmanage.title"),
			getText("bshare.points.permission.unauthorized"), "shop");

	private String pageNo;
	private Pagination pagination;
	private String unlimited;

	@Override
	public PointsProduct getModel() {
		return pointsProduct;
	}

	public PointsProduct getPointsProduct() {
		return pointsProduct;
	}

	public void setPointsProduct(PointsProduct pointsProduct) {
		this.pointsProduct = pointsProduct;
	}

	public ExceptionHandler getHandler() {
		return handler;
	}

	public void setHandler(ExceptionHandler handler) {
		this.handler = handler;
	}

	public String getPageNo() {	
		if(pageNo == null || pageNo.isEmpty() || !IS_NUMERIC.matcher(pageNo).matches()){
			pageNo = DEFAULT_PAGE_NO ;
		}
		return pageNo;
	}

	public void setPageNo(String pageNo) {
		this.pageNo = pageNo;
	}

	public Pagination getPagination() {
		return pagination;
	}

	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}

	public String getUnlimited() {
		return unlimited;
	}

	public void setUnlimited(String unlimited) {
		this.unlimited = unlimited;
	}

	public List<PointsProduct> getPointsProducts() {
		return pointsProducts;
	}

	public void setPointsProducts(List<PointsProduct> pointsProducts) {
		this.pointsProducts = pointsProducts;
	}

	@Override
	public String execute() throws Exception {
		if (!loginHelper.isLoginAsAdmin()) {
			addActionError(getText("bshare.points.permission.authorized"));
			return Action.ERROR;
		}

		long count = pointsProductService.getCount();
		pagination = new Pagination(Integer.valueOf(getPageNo()), count,
				PAGESIZE);
		pointsProducts = pointsProductService.getPagination(pagination);

		return SUCCESS;
	}
	
	public String add(){
		String result = SUCCESS ;
		if(!loginHelper.isLoginAsAdmin()){
			addActionError("bshare.points.permission.unauthorized");
			return Action.ERROR ;
		}
		
		getMerchantSelector();
		getCategorySelector();
		return result ;
	}

	private void getCategorySelector() {
		List<ProductCategory> categorys = productCategoryService.getAll() ;
		Map<String,String> categoryMap = new HashMap<String,String>();
		for(ProductCategory pc : categorys){
			categoryMap.put(String.valueOf(pc.getId()), pc.getName()) ;
		}
		request.setAttribute("categorySelector",categoryMap) ;
	}

	private void getMerchantSelector() {
		List<Merchant> merchants = merchantService.getAll() ;
		Map<String,String> merchantMap = new HashMap<String,String>() ;
		for(Merchant mer : merchants){
			merchantMap.put(String.valueOf(mer.getId()), String.valueOf(mer.getName()));
		}
		request.setAttribute("merchantSelector", merchantMap) ;
		
	}
	
	public String create() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        pointsProduct.setInsertTime(new Date());
        if ("true".equals(unlimited)) {
            pointsProduct.setStoreNum(-1);
        }
        pointsProductService.save(pointsProduct);
        operateHisService.createAdd(PointsStatModule.POINTAS_PRODUCT, pointsProduct.getId());
        return SUCCESS;
    }
	
	public String delete() {
        if (loginHelper.isLoggedIn() && loginHelper.isLoginAsPointsAdmin() && pointsProduct.getId() > 0) {
            pointsProduct = pointsProductService.getProductById(pointsProduct.getId());
            if (pointsProduct != null) {
                pointsProductService.remove(pointsProduct.getId());
                operateHisService.createDelete(PointsStatModule.POINTAS_PRODUCT, pointsProduct.getId());
                addActionMessage(getText("bshare.points.common.delete.success"));
                return Action.SUCCESS;
            }
        }
        addActionMessage(getText("bshare.points.operation.unauthorized"));
        return Action.ERROR;
    }
	
	public String edit() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        pointsProduct = pointsProductService.getProductById(pointsProduct.getId());
        if (pointsProduct != null) {
            getMerchantSelector();
            getCategorySelector();
            return SUCCESS;
        }
        addActionMessage(getText("bshare.points.operation.unauthorized"));
        return Action.ERROR;
    }
	
	/**
	 * update points products:Execution flow:1.permission validation 2.get points product 3.get pointsProduct 4.encapsulate the pp object of type PointsProduct 5.update the target product 6.
	 * @return
	 */
	public String update() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        PointsProduct pp = pointsProductService.getProductById(pointsProduct.getId());
        if (pp != null) {
            pp.setBrand(pointsProduct.getBrand());
            pp.setCurrentPoints(pointsProduct.getCurrentPoints());
            pp.setDesc(pointsProduct.getDesc());
            pp.setDescUrl(pointsProduct.getDescUrl());
            pp.setInitialPoints(pointsProduct.getInitialPoints());
            pp.setMerchantId(pointsProduct.getMerchantId());
            pp.setName(pointsProduct.getName());
            if (StringUtils.isNotEmpty(pointsProduct.getPic())) {
                pp.setPic(pointsProduct.getPic());
            }
            pp.setPriceMarket(pointsProduct.getPriceMarket());
            if ("true".equals(unlimited)) {
                pp.setStoreNum(-1);
            } else {
                pp.setStoreNum(pointsProduct.getStoreNum());
            }
            pp.setProdCate(pointsProduct.getProdCate());
            pp.setProductStatus(pointsProduct.getProductStatus());
            pp.setTags(pointsProduct.getTags());
            pointsProductService.update(pp);
            operateHisService.createModify(PointsStatModule.POINTAS_PRODUCT, pp.getId());
            return SUCCESS;
        }
        addActionMessage(getText("bshare.points.operation.unauthorized"));
        return Action.ERROR;
    }
	
}
