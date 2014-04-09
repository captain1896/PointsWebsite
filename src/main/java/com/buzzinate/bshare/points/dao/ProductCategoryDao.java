package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.ProductCategory;
import com.buzzinate.common.dao.PointsDaoBase;

/**
 * Product category Dao
 * 
 * @author martin
 *
 */
@Repository
@SuppressWarnings("unchecked")
@Transactional(value = "points", readOnly = true)
public class ProductCategoryDao extends PointsDaoBase<ProductCategory, Integer> implements Serializable {
    
    private static final long serialVersionUID = 2961126815733581710L;

    public ProductCategoryDao() {
        super(ProductCategory.class, "id");
    }
    
    public List<ProductCategory> getAll() {
        Query query = getSession().getNamedQuery("productCategory.getAll");
        return (List<ProductCategory>) query.list();
    }
    
    public ProductCategory getByName(String name) {
        Criteria category = getSession().createCriteria(ProductCategory.class);
        category.add(Restrictions.or(Restrictions.eq("name", name), Restrictions.eq("nameEn", name)));
        List<ProductCategory> cates = category.list();
        return cates.size() > 0 ? cates.get(0) : new ProductCategory();
    }
    
}
