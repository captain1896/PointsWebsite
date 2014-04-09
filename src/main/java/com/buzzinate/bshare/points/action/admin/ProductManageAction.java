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
 * 
 * Product manage action
 * 
 * @author Martin
 *
 */
@Controller
@Scope("request")
public class ProductManageAction extends BaseAction implements ModelDriven<PointsProduct> {

    private static final long serialVersionUID = -3154990147827529944L;
    
    private static final Pattern IS_NUMERIC = Pattern.compile("[0-9]+");
    private static final String DEFAULT_PAGE_NO = "1";
    private static final int PAGESIZE = ConfigurationReader.getInt("bshare.points.activities.perpage");
    
    @Autowired
    private PointsProductService pointsProductService;
    @Autowired
    private MerchantService merchantService;
    @Autowired
    private ProductCategoryService productCategoryService;
    @Autowired
    private PointsOperateHisService  operateHisService;
    
    private List<PointsProduct> pointsProducts;
    private PointsProduct pointsProduct = new PointsProduct();
    //exception handler
    private ExceptionHandler handler = new ExceptionHandler(getText("bshare.shop.exception.productmanage.title") ,
            getText("bshare.points.permission.unauthorized") , "shop");

    private String pageNo;
    private Pagination pagination;
    
    private String unlimited;

    public String execute() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        long count = pointsProductService.getCount();
        pagination = new Pagination(Integer.valueOf(getPageNo()), count, PAGESIZE);
        pointsProducts = pointsProductService.getPagination(pagination);
        return SUCCESS;
    }
    
    public String add() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        getMerchantSelector();
        getCategorySelector();
        return SUCCESS;
    }
    
    private void getCategorySelector() {
        List<ProductCategory> categorys = productCategoryService.getAll();
        Map<String, String> categoryMap = new HashMap<String, String>();
        for (ProductCategory pc : categorys) {
            categoryMap.put(String.valueOf(pc.getId()), pc.getName());
        }
        request.setAttribute("categorySelector", categoryMap);

    }

    private void getMerchantSelector() {
        List<Merchant> merchants = merchantService.getAll();
        Map<String, String> merchantMap  = new HashMap<String, String>();
        for (Merchant merchant : merchants) {
            merchantMap.put(String.valueOf(merchant.getId()), merchant.getName());
        }
        request.setAttribute("merchantSelector", merchantMap);
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
    
    // @authod Lucas
    public String deleteDemo(){
    	if(loginHelper.isLoggedIn() && loginHelper.isLoginAsPointsAdmin() && pointsProduct.getId() > 0 ){//permission validation
    		pointsProduct = pointsProductService.getProductById(pointsProduct.getId()) ;//Retrieve the wanted Product by Id
    		if(null  != pointsProduct ){ // if the retrieving result is not null 
    			pointsProductService.remove(pointsProduct.getId()) ;//delete the target 
    			operateHisService.createDelete(PointsStatModule.POINTAS_PRODUCT, pointsProduct.getId()) ;// what is this line for ?!
    			addActionMessage(getText("bshare.points.common.delete.success")) ;// what is this line for ? !
    			return Action.SUCCESS ;//return result 
    		}
    		
    	}
    	addActionMessage(getText("bshare.points.operation.unauthorized")) ;//when not permited !
    	return Action.ERROR ;
    }
    
    //@author Lucas
    public String addDemo(){
    	if(!loginHelper.isLoginAsPointsAdmin() ){
    		addActionError(getText("bshare.points.permission.unauthorized")) ;
    		return Action.ERROR ;
    	}
    	getMerchantSelector() ;
    	getCategorySelector() ;
    	return SUCCESS  ;
    }
    
    //@author Lucas
    public String editDemo(){
    	if(!loginHelper.isLoginAsPointsAdmin()){
    		addActionError(getText("bshare.points.permission.unauthorized"));
    		return Action.ERROR ;
    	}
    	
    	pointsProduct = pointsProductService.getProductById(pointsProduct.getId()) ;
    	if(null != pointsProduct){
    		getMerchantSelector() ;
    		getCategorySelector() ;
    		return SUCCESS ;
    	}
    	
    	return Action.ERROR ;
    }
    
    //@author Lucas
    public String updateDemo(){
    	if(!loginHelper.isLoginAsPointsAdmin()){
    		addActionError("bshare.points.permission.unauthorized") ;
    		return Action.ERROR ;
    	}
    	PointsProduct pp = pointsProductService.getProductById(pointsProduct.getId()) ;
    	if(null != pp){
    		pp.setBrand(pointsProduct.getBrand()) ;
    		pp.setCurrentPoints(pointsProduct.getCurrentPoints()) ;
    		pp.setDesc(pointsProduct.getDesc()) ;
    		pp.setDescUrl(pointsProduct.getDescUrl()) ;
    		pp.setInitialPoints(pointsProduct.getInitialPoints()) ;
    		pp.setMerchantId(pointsProduct.getMerchantId()) ;
    		pp.setName(pointsProduct.getName()) ;
    		if(StringUtils.isNotEmpty(pointsProduct.getPic())){
    			pp.setPic(pointsProduct.getPic());
    		}
    		pp.setPriceMarket(pointsProduct.getPriceMarket()) ;
    		if("true".equals(unlimited)){
    			pp.setStoreNum(-1) ;
    		}else{
    			pp.setStoreNum(pointsProduct.getStoreNum()) ;
    		}
    		
    		pp.setProdCate(pointsProduct.getProdCate()) ;
    		pp.setProductStatus(pointsProduct.getProductStatus()) ;
    		pp.setTags(pointsProduct.getTags()) ;
    		pointsProductService.update(pp) ;
    		operateHisService.createModify(PointsStatModule.POINTAS_PRODUCT,pp.getId());
    		return SUCCESS ;
    	}
    	addActionError(getText("bshare.points.operation.unauthorized"));
    	return SUCCESS ;
    }
    
    @Override
    public PointsProduct getModel() {
        return pointsProduct;
    }

    public List<PointsProduct> getPointsProducts() {
        return pointsProducts;
    }

    public void setPointsProducts(List<PointsProduct> pointsProducts) {
        this.pointsProducts = pointsProducts;
    }

    public PointsProduct getPointsProduct() {
        return pointsProduct;
    }

    public void setPointsProduct(PointsProduct pointsProduct) {
        this.pointsProduct = pointsProduct;
    }
    public String getPageNo() {    
        if (pageNo == null || pageNo.isEmpty() || !IS_NUMERIC.matcher(pageNo).matches()) {
            pageNo = DEFAULT_PAGE_NO;
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

    public ExceptionHandler getHandler() {
        return handler;
    }

    public void setHandler(ExceptionHandler handler) {
        this.handler = handler;
    }
    
}
