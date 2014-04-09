package com.buzzinate.bshare.points.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.Merchant;
import com.buzzinate.bshare.points.bean.enums.PointsStatModule;
import com.buzzinate.bshare.points.dao.MerchantDao;
import com.buzzinate.bshare.points.util.CacheConstants;
import com.buzzinate.bshare.user.bean.Role;
import com.buzzinate.bshare.user.bean.UserType;
import com.buzzinate.bshare.user.service.UserRoleServices;
import com.buzzinate.common.memcached.MemcachedClientAdapter;

/**
 * Merchant Service
 * 
 * @author Martin
 * 
 */
@Service
public class MerchantService {

    //private static Log log = LogFactory.getLog(MerchantService.class);

    @Autowired
    private MerchantDao merchantDao;
    @Autowired
    private MemcachedClientAdapter memcachedClient;
    @Autowired
    private UserRoleServices userRoleServices;
    @Autowired
    private PointsOperateHisService operateHisService;

    @SuppressWarnings("unchecked")
    public List<Merchant> getAll() {
        List<Merchant> merchants = (List<Merchant>) memcachedClient.get(CacheConstants.MERCHANT);
        if (merchants == null) {
            merchants = merchantDao.getAll();
            memcachedClient.set(CacheConstants.MERCHANT, CacheConstants.EXPIRE_MERCHANT, merchants);
        }
        return merchants;
    }

    public void delete(Merchant merchant) {
        operateHisService.createDelete(PointsStatModule.MERCHANT, merchant.getId());
        merchantDao.delete(merchant.getId());
        memcachedClient.delete(CacheConstants.MERCHANT + merchant.getId());
        memcachedClient.delete(CacheConstants.MERCHANT);
        String roleName = Role.parseRoleName(UserType.USERTYPE_CODE_POINTS_MERCHANT);
        userRoleServices.removeRoleFromUser(merchant.getUserId(), roleName);
    }

    public Merchant getMerchantByEmail(String email) {
        return merchantDao.getMerchantByEmail(email);
    }

    public int create(Merchant merchant) {
        String roleName = Role.parseRoleName(UserType.USERTYPE_CODE_POINTS_MERCHANT);
        userRoleServices.addRoleToUser(merchant.getUserId(), roleName);
        memcachedClient.delete(CacheConstants.MERCHANT);
        int recordId = merchantDao.create(merchant);
        operateHisService.createAdd(PointsStatModule.MERCHANT, recordId);
        return recordId;
    }

    public Merchant get(int id) {
        String key = CacheConstants.MERCHANT + id;
        Merchant merchant = (Merchant) memcachedClient.get(key);
        if (merchant == null) {
            merchant = merchantDao.read(id);
            if (merchant != null) {
                memcachedClient.set(key, CacheConstants.EXPIRE_MERCHANT, merchant);
            }
        }
        return merchant;
    }

    @Transactional(value = "points", readOnly = false)
    public void update(Merchant merchant) {
        merchantDao.update(merchant);
        operateHisService.createModify(PointsStatModule.MERCHANT, merchant.getId());
        memcachedClient.delete(CacheConstants.MERCHANT + merchant.getId());
        memcachedClient.delete(CacheConstants.MERCHANT);
    }

}
