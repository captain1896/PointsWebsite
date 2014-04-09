package com.buzzinate.bshare.points.action.shop.order;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.bean.PointsUserAccount;
import com.buzzinate.bshare.points.bean.enums.PointsCategory;
import com.buzzinate.bshare.points.service.PointsUserAccountService;
import com.buzzinate.bshare.points.service.exchange.PointsExchangeTaoBao;
import com.buzzinate.common.util.JsonResults;

/**
 * this order Action for all kind of points
 * @author james.chen
 * @since 2012-7-20
 */
@Controller
@Scope("request")
public class PointsOrderAction extends AbstractOrderAction {
   
    private static final long serialVersionUID = 6303916493999732383L;

    @Autowired
    private PointsUserAccountService accountService;
    
    //user account value for points exchanges
    private PointsUserAccount userAccount;

    
    /*fill order information
     * if the order product is points, need to store extra points account name
     * @see com.buzzinate.bshare.points.action.shop.OrderAction#fillOthers()
     */
    @Override
    public void fillOthers() {
        if (isPoints()) {
            userAccount = userAccount == null ? new PointsUserAccount() : userAccount;
            userAccount.setPointsCate(PointsCategory.valueOf(order.getProductId()));
            userAccount.setUserId(getCurrentUserId());
            order.setOtherInfo(userAccount.getAccountName());
            order.setOrderPoints((product == null ? 0 : product.getCurrentPoints()) * order.getProdNum());
        }
    }

    // store information
    /* for point order ,we need to store the exchange user account
     * @see com.buzzinate.bshare.points.action.shop.OrderAction#storeOthers()
     */
    @Override
    public void storeOthers() {
        if (isPoints()) {
            accountService.storeUserAccount(userAccount);
        }
    }
    
    /* when validate Others
     * @see com.buzzinate.bshare.points.action.shop.OrderAction#validateOthers()
     */
    @Override
    public String validateOthers() {
        if (isPoints() && (userAccount == null || StringUtils.isBlank(userAccount.getAccountName()))) {
            return getText("bshare.shop.pointsorder.nouseraccount");
        }
        return "";
    }
    @Override
    public String orderProductJs() {
        super.orderProductJs();
        handlerOrder();
        if (PointsExchangeTaoBao.USER_NOT_EXIST.equals(order.getOutPointsTradNo())) {
            results.addContent(
                    "message",
                    getText("bshare.shop.order.points.points.exchange.user_no_exists", new String[] {product
                            .getMerchant().getName() }));
            results.fail();
            accountService.delete(userAccount);
        } else if (!StringUtils.isNumeric(order.getOutPointsTradNo().trim())) {
            results.fail();
        }
        return JsonResults.JSON_RESULT_NAME;
    }
    @Override
    public String orderConfirm() {
        return SUCCESS;
    }
    
    /* (non-Javadoc)
     * @see com.buzzinate.bshare.points.action.shop.order.OrderAction#handlerOrder()
     */
    @Override
    public void handlerOrder() {
        orderService.order(order, pointsUser, product);
        if (isPoints()) {
            orderService.exchangePoints(order);
            order = orderService.getOrderByNo(order.getOrderNo());
        }
    }
    
    //to judge process product is Points product
    private boolean isPoints() {
        return PointsCategory.isPointsCategory(order.getProductId());
    }

    public PointsUserAccount getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(PointsUserAccount userAccount) {
        this.userAccount = userAccount;
    }
}
