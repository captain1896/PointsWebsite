package com.buzzinate.bshare.points.bean;

import java.util.ArrayList;
import java.util.List;

import flexjson.JSON;

/**
 * Bean for storing ProductResource results
 * 
 * @author Martin
 *
 */
public class ApiProduct {
    
    public static class Entry {
        private String url;
        private String name;
        private String pic;
        private int points;
        private String price;
        
        public String getUrl() {
            return url;
        }
        public void setUrl(String url) {
            this.url = url;
        }
        public String getName() {
            return name;
        }
        public void setName(String name) {
            this.name = name;
        }
        public String getPic() {
            return pic;
        }
        public void setPic(String pic) {
            this.pic = pic;
        }
        public int getPoints() {
            return points;
        }
        public void setPoints(int points) {
            this.points = points;
        }
        public String getPrice() {
            return price;
        }
        public void setPrice(String price) {
            this.price = price;
        }

    }
    
    private List<Entry> products = new ArrayList<Entry>();
    
    public void addProductEntry(String url, String name, String pic, int points, String price) {
        Entry e = new Entry();
        e.setUrl(url);
        e.setName(name);
        e.setPic(pic);
        e.setPoints(points);
        e.setPrice(price);
        products.add(e);
    }
    
    @JSON(include = false)
    public int getEntryCount() {
        return products.size();
    }
    
    public List<Entry> getProducts() {
        return products;
    }
}