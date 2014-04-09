package com.buzzinate.bshare.points.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.points.bean.ProductCategory;
import com.buzzinate.bshare.points.dao.ProductCategoryDao;
import com.buzzinate.bshare.points.util.CacheConstants;
import com.buzzinate.common.memcached.MemcachedClientAdapter;

/**
 * Product category Service
 * 
 * @author Martin
 * 
 */
@Service
public class ProductCategoryService {

    //private static Log log = LogFactory.getLog(ProductCategoryService.class);

    @Autowired
    private ProductCategoryDao productCategoryDao;
    @Autowired
    private PointsProductService productService;
    
    @Autowired
    private MemcachedClientAdapter memcachedClient;

    @SuppressWarnings("unchecked")
    public List<ProductCategory> getAll() {
        List<ProductCategory> categorys = (List<ProductCategory>) memcachedClient.get(CacheConstants.PRODUCT_CATEGORY);
        if (categorys == null) {
            categorys = productCategoryDao.getAll();
            memcachedClient.set(CacheConstants.PRODUCT_CATEGORY, CacheConstants.EXPIRE_PRODUCT_CATEGORY, categorys);
        }
        if (categorys != null) {
            Map<Integer, Long> resultMap = productService.getCategoryNum();
            for (ProductCategory cate : categorys) {
                if (resultMap.containsKey(cate.getId())) {
                    cate.setProdNum(resultMap.get(cate.getId()));
                } else {
                    cate.setProdNum(0);
                }
            }
        }
        return categorys;
    }
    
    /**return all product Category with Product
     * @return
     */
    public List<ProductCategory> getAllWithProduct() {
        List<ProductCategory> all = getAll();
        List<ProductCategory> withProduct = new ArrayList<ProductCategory>();
        for (ProductCategory cate : all) {
            if (cate.getProdNum() > 0) {
                withProduct.add(cate);
            }
        }
        return withProduct;
    }

    public ProductCategory get(int id) {
        String key = CacheConstants.PRODUCT_CATEGORY + id;
        ProductCategory pc = (ProductCategory) memcachedClient.get(key);
        if (pc == null) {
            pc = productCategoryDao.read(id);
            if (pc != null) {
                memcachedClient.set(key, CacheConstants.EXPIRE_PRODUCT_CATEGORY, pc);
            }
        }
        return pc;
    }
    
    public ProductCategory getCategoryByName(String name) {
        String key = CacheConstants.PRODUCT_CATEGORY + name;
        ProductCategory pc = (ProductCategory) memcachedClient.get(key);
        if (pc == null) {
            if (ProductCategory.ALL.getNameEn().equals(name)) {
                pc = ProductCategory.ALL;
            } else {
                pc = productCategoryDao.getByName(name);
            }
            if (pc != null) {
                memcachedClient.set(key, CacheConstants.EXPIRE_PRODUCT_CATEGORY, pc);
            }
        }
        return pc;
    }
    
}
