package com.buzzinate.bshare.points.api;

import java.util.List;

import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.buzzinate.bshare.points.bean.ApiProduct;
import com.buzzinate.bshare.points.bean.PointsProduct;
import com.buzzinate.bshare.points.service.PointsProductService;
import com.buzzinate.common.util.ConfigurationReader;

import flexjson.JSONSerializer;

/**
 * Handles API requests for get points products.
 * Must pass in bShare user name and password to use this!
 * 
 * Format:
 *         http://<POINTS_HOST/CXT_PATH>/api/getProduct.json[&count=<count>][$category=<category>]
 * 
 * gets the products
 * 
 * Optional: 
 *         count (the number of articles to return, max 50)
 *         category (don't display this categorys)
 * 
 * Returns:
 *         A list of statistics in JSON format with root element "products".
 *         The list has properties "url", "name", "pic", "points", "price".
 *         For example:
 *           {"products":[
 *              {"name":"商品1","pic":"http://repo.bshare.cn/pointsImage/source/V/VO1legaysFDujwHE.jpg","points":2000,"price":"1000.00","url":"http://points.bshare.local/bshare_points/shop/product/1"}
 *              ,{"name":"商品2","pic":"http://repo.bshare.cn/pointsImage/source/W/WS7aWAA8NnJVFC2f.jpg","points":10000,"price":"200.00","url":"http://points.bshare.local/bshare_points/shop/product/2"}]
 *           }
 * 
 * Defaults:
 *         count: 20
 * 
 * @author Martin
 *
 */
// PATH!!! remember to use an extension, or struts will filter it!
@Path("getProducts.json")
@Component
@XmlRootElement
@Scope("request")
public class ProductResource {
    
    private static final int DEFAULT_NUM_PRODUCTS = 20;
    private static final int MAX_NUM_PRODUCTS = 50;
    
    private static final String URL_BASE = ConfigurationReader.getString("bshare.points.server") + "/shop/product/";
    
    @Autowired
    private PointsProductService pointProductService;
    
    @DefaultValue("") @QueryParam("category")
    private String category = "";
    @DefaultValue("20") @QueryParam("count") 
    private int count = DEFAULT_NUM_PRODUCTS;
    
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getMethod() {
        
        if (count > MAX_NUM_PRODUCTS) {
            count = MAX_NUM_PRODUCTS;
        }
        
        List<PointsProduct> products = pointProductService.getProductWithoutCategory(StringUtils.trim(category), 
                count, MAX_NUM_PRODUCTS);

        return getProductsData(products);
    }
    
    /**
     * Converts products data to JSON format
     * 
     * @param type
     * @param shares
     * @return
     */
    private String getProductsData(List<PointsProduct> products) {
        JSONSerializer serializer = new JSONSerializer().exclude("*.class");
        return serializer.deepSerialize(convertSharingList(products));
    }

    /**
     * Converts a List of GlobalShare objects to a List [ApiProduct]
     * 
     * @param type
     * @param shares
     * @return
     */
    private ApiProduct convertSharingList(List<PointsProduct> products) {
        int num = 0;
        ApiProduct as = new ApiProduct();
        if (products == null) return as;
        for (PointsProduct ps : products) {
            as.addProductEntry(getProductUrl(ps.getId()), ps.getName(), ps.getPicUrl(), ps.getCurrentPoints(), 
                    ps.getPriceMarketValue());
            num++;
            if (num >= count) {
                break;
            }
        }
        return as;
    }
    
    private String getProductUrl(int id) {
        return URL_BASE + id;
    }
}