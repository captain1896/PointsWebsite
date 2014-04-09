package com.buzzinate.bshare.points.action.shop.order;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
/**
 * 商品兑换
 * 
 * @author james.chen
 * @since 2012-6-14
 */
@Controller
@Scope("request")
public class OrderAction extends AbstractOrderAction {
    
    private static final long serialVersionUID = 9078069561396314248L;

    /**
     * this method is to fill the other info in Order by related Product
     * for normal order only store contact address
     */
    public void fillOthers() {
        if (order.getProdNum() <= 0) {
            order.setProdNum(1);
        }
        order.setOrderPoints((product == null ? 0 : product.getCurrentPoints()) * order.getProdNum());
        order.setAddress(pointsUser);
    }
    
    /**this method is to validate other information
     * for normal order ,we will validate whether the contact is correct
     * and user must store the 
     * @return
     */
    public String validateOthers() {
        if (pointsUser == null || pointsUser.invalidContact()) {
            return getText("bshare.shop.order.contactinfo");
        }
        return super.validateOthers();
    }
    
    /**
     * need to store the information in the middle
     */
    public void storeOthers() {
        pointUserService.updatePointUserContact(pointsUser);
    }
    
    /**
     * the handler information after store Order
     */
    public void handlerOrder() {
        // generate order information
        orderService.order(order, pointsUser, product);
    }
}
