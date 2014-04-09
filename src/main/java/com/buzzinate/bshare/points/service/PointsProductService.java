package com.buzzinate.bshare.points.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.points.bean.PointsProduct;
import com.buzzinate.bshare.points.dao.PointsProductDao;
import com.buzzinate.bshare.points.util.CacheConstants;
import com.buzzinate.common.services.MemcachedService;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.Pagination;

/**product service class
 * which supply the required for pointProduct Object
 * 
 * @author james.chen
 * @since 2012-6-11
 */
@Service
@SuppressWarnings("unchecked")
public class PointsProductService extends MemcachedService<PointsProduct, Integer, PointsProductDao> implements
        Serializable {

    private static final long serialVersionUID = -7485138368200291517L;
    private static final String PRODUCT_MAIN_PAGE = "mainpage";
    private static final String PRODUCT_MAIN_ACTIVITY = "activity";
    private static final String CATEGORY_PRODUCT_NUM = "categorynum";
    private static final String PRODUCT_OLYMPIC = "olympic_four";
    private static final String PRODUCT_OLYMPIC_ALL = "olympicall";
    private static final String PRODUCT_ALL = "all";
    private static final String MY_PRODUCT = "my_product";
    private static final int PRODUCT_NUM_MAIN = ConfigurationReader.getInt("bshare.points.firstpage.product.num");
    
    private static final int PRODUCT_NUM_ACTIVITY = ConfigurationReader.getInt("bshare.points.activity.product.num");
    
    @Autowired
    private ProductCategoryService productCategoryService;
    @Autowired
    private MerchantService merchantService;
    @Autowired
    private PointsProductDao productDao;
    
    public PointsProductService() {
        entitiesSuffixs.add(PRODUCT_MAIN_PAGE);
        entitiesSuffixs.add(PRODUCT_MAIN_ACTIVITY);
        entitiesSuffixs.add(PRODUCT_OLYMPIC);
        entitiesSuffixs.add(PRODUCT_OLYMPIC_ALL);
        entitiesSuffixs.add(PRODUCT_ALL);
        entitySuffixs.add(CATEGORY_PRODUCT_NUM);
    }

    private List<PointsProduct> getProductOnSales(String suffix , int num) {
        Map<String, Object> params = new HashMap<String, Object>();
        if (num > 0) {
            params.put(PointsProductDao.MAXRESULT, num);
        }
        return fullProducts(getEntities(suffix, "PointsProduct.getProductsOnSale", params));
    }
    
    /**
     * get the products for Main Page
     * 
     * @return
     */
    public List<PointsProduct> getProductsMainPage() {
        return getProductOnSales(PRODUCT_MAIN_PAGE, PRODUCT_NUM_MAIN);
    }
    
    /**
     * 获取烧点商商品列表
     * @param merchantId
     * @return
     */
    public List<PointsProduct> getProductsByMerchant(int merchantId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put(PointsProductDao.MERCHANT_ID, merchantId);
        return fullProducts(getEntities(MY_PRODUCT, "PointsProduct.getProductsByMerchant", params));
    }

    /**
     * get the relate Products in Activity Page
     * 
     * @return
     */
    public List<PointsProduct> getProductsActivity() {
        return getProductOnSales(PRODUCT_MAIN_ACTIVITY, PRODUCT_NUM_ACTIVITY);
    }

    public List<PointsProduct> getProductsOnSale(int num) {
        String key = num > 0 ? PRODUCT_OLYMPIC : PRODUCT_OLYMPIC_ALL;
        return getProductOnSales(key, num);
    }
    
    //get pointProducts By primary key id
    public PointsProduct getProductById(int id) {
        PointsProduct product = (PointsProduct) get(id);
        if (product != null) {
            full(product);
        }
        return product;
    }
    // update pointProducts
    public void updateProductSell(int sellNum , int id) {
        if (productDao.updateProductSell(sellNum, id)) {
            memcachedClient.delete(getPrefix() + id);
        } else {
            throw new RuntimeException("update product error,userId=" + id);
        }
        // clear Points and clear memcached content
        PointsProduct pp = (PointsProduct) get(id);
        if (pp.getStoreNum() == 0) {
            clearOthers(id);
        }
    }
    
    /**full product list
     * @param pointsProduct
     * @return
     */
    private List<PointsProduct> fullProducts(List<PointsProduct> pointsProducts) {
        List<PointsProduct> products = new ArrayList<PointsProduct>();
        for (PointsProduct product : pointsProducts) {
            products.add(full(product));
        }
        return products;
    }
    
    /**full single product
     * @param product
     * @return
     */
    private PointsProduct full(PointsProduct product) {
        product.setProductCategory(productCategoryService.get(product.getProdCate()));
        product.setMerchant(merchantService.get(product.getMerchantId()));
        return product;
    }

    public List<PointsProduct> getAll() {
        return fullProducts(getEntities(PRODUCT_ALL, "PointsProduct.getAll", new HashMap<String, Object>()));
    }

    public void update(PointsProduct pointsProduct) {
        modify(pointsProduct);
    }


    public void delete(int id) {
        remove(id);
    }

    public void save(PointsProduct pointsProduct) {
        update(pointsProduct);
    }

    public List<PointsProduct> getPagination(Pagination pagination) {
        List<PointsProduct> products =
                productDao.getNameQueryPagination("PointsProduct.getAll", new HashMap<String, Object>(), pagination);
        return fullProducts(products);
    }

    public long getCount() {
        return productDao.getNameQueryCount("PointsProduct.getCount", new HashMap<String, Object>());
    }
    //get products by Category
    public List<PointsProduct> getProdutsByCatePagination(int categoryId , Pagination pagination) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("category", categoryId);
        return productDao.getNameQueryPagination("PointsProduct.getProductsByCategory", params, pagination);
    }
    //get count products by category
    public long getProdutsByCateCount(int categoryId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("category", categoryId);
        return productDao.getNameQueryCount("PointsProduct.getCountProductsByCategory", params);
    }
    //get CategoryNum
    public Map<Integer, Long> getCategoryNum() {
        String key = getPrefix() + CATEGORY_PRODUCT_NUM;
        Map<Integer, Long> result = (Map<Integer, Long>) memcachedClient.get(key);
        if (result == null) {
            result = productDao.getCategoryNum();
            memcachedClient.set(key, CacheConstants.EXPIRE_PRODUCT_NAME, result);
        }
        return result == null ? new HashMap<Integer, Long>() : result;
    }
    
    private Integer[] getIdsByStr(String category) {
        Integer[] categoryIds = null;
        if (StringUtils.isNotEmpty(category)) {
            try {
                String[] categorys = StringUtils.split(category, ",");
                categoryIds = new Integer[categorys.length];
                for (int i = 0; i < categorys.length; i++) {
                    categoryIds[i] = Integer.parseInt(categorys[i]);
                }
            } catch (Exception e) {
                categoryIds = null;
            }
        }
        return categoryIds;
    }

    public List<PointsProduct> getProductWithoutCategory(String category , int count , int maxCount) {
        Integer[] categoryIds = getIdsByStr(category);
        Map<String, Object> params = new HashMap<String, Object>();
        params.put(PointsProductDao.MAXRESULT, maxCount);
        String queryName = "PointsProduct.getProducts";
        if (categoryIds != null && categoryIds.length > 0) {
            params.put("categorys_list", categoryIds);
            queryName = "PointsProduct.getProductWithoutCategory";
        }
        List<PointsProduct> products = nameQuery(queryName, params);
        products = products.size() > count ? products.subList(0, count) : products;
        return fullProducts(products);
    }

    @Override
    public String getPrefix() {
        return CacheConstants.POINTSPRODUCT_NAME;
    }

    @Override
    public void init() {
        setDao(productDao);
    }
}