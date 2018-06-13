package com.ruanyf.houserenting.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 房源实体类
 * 
 * @author Feng
 */
public class House {

    /** 房源编号 */
    private int id;

    /** 标题 */
    private String title;
    /** 介绍 */
    private String intro;
    /** 租金 */
    private int price;

    /** 租赁方式 */
    private String rentMethod;

    /* 付款方式 */
    private int deposit;
    private int payment;

    /* 户型 */
    private int roomCount;
    private int hallCount;
    private int bathroomCount;

    /* 地址 */
    private String province;
    private String city;
    private String county;
    private String address;

    /** 面积 */
    private int area;

    /** 发布时间 */
    private Date publishTime;
    /** 状态 */
    private int status;
    /** 访问量 */
    private int visitCount;

    /** 图片 */
    private List<String> pictures = new ArrayList<String>();

    /** 发布者 */
    private User publisher;

    /**
     * 构造方法
     */
    public House() {}

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * @return the intro
     */
    public String getIntro() {
        return intro;
    }

    /**
     * @param intro the intro to set
     */
    public void setIntro(String intro) {
        this.intro = intro;
    }

    /**
     * @return the price
     */
    public int getPrice() {
        return price;
    }

    /**
     * @param price the price to set
     */
    public void setPrice(int price) {
        this.price = price;
    }

    /**
     * @return the address
     */
    public String getAddress() {
        return address;
    }

    /**
     * @param address the address to set
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * @return the publishTime
     */
    public Date getPublishTime() {
        return publishTime;
    }

    /**
     * @param publishTime the publishTime to set
     */
    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    /**
     * @return the status
     */
    public int getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(int status) {
        this.status = status;
    }

    public int getVisitCount() {
        return visitCount;
    }

    public void setVisitCount(int visitCount) {
        this.visitCount = visitCount;
    }

    /**
     * @return the pictures
     */
    public List<String> getPictures() {
        return pictures;
    }

    /**
     * @param pictures the pictures to set
     */
    public void setPictures(List<String> pictures) {
        this.pictures = pictures;
    }

    /**
     * @return the publisher
     */
    public User getPublisher() {
        return publisher;
    }

    /**
     * @param publisher the publisher to set
     */
    public void setPublisher(User publisher) {
        this.publisher = publisher;
    }

    /**
     * @return the rentMethod
     */
    public String getRentMethod() {
        return rentMethod;
    }

    /**
     * @param rentMethod the rentMethod to set
     */
    public void setRentMethod(String rentMethod) {
        this.rentMethod = rentMethod;
    }

    /**
     * @return the deposit
     */
    public int getDeposit() {
        return deposit;
    }

    /**
     * @param deposit the deposit to set
     */
    public void setDeposit(int deposit) {
        this.deposit = deposit;
    }

    /**
     * @return the payment
     */
    public int getPayment() {
        return payment;
    }

    /**
     * @param payment the payment to set
     */
    public void setPayment(int payment) {
        this.payment = payment;
    }

    /**
     * @return the roomCount
     */
    public int getRoomCount() {
        return roomCount;
    }

    /**
     * @param roomCount the roomCount to set
     */
    public void setRoomCount(int roomCount) {
        this.roomCount = roomCount;
    }

    /**
     * @return the hallCount
     */
    public int getHallCount() {
        return hallCount;
    }

    /**
     * @param hallCount the hallCount to set
     */
    public void setHallCount(int hallCount) {
        this.hallCount = hallCount;
    }

    /**
     * @return the bathroomCount
     */
    public int getBathroomCount() {
        return bathroomCount;
    }

    /**
     * @param bathroomCount the bathroomCount to set
     */
    public void setBathroomCount(int bathroomCount) {
        this.bathroomCount = bathroomCount;
    }

    /**
     * @return the province
     */
    public String getProvince() {
        return province;
    }

    /**
     * @param province the province to set
     */
    public void setProvince(String province) {
        this.province = province;
    }

    /**
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * @return the county
     */
    public String getCounty() {
        return county;
    }

    /**
     * @param county the county to set
     */
    public void setCounty(String county) {
        this.county = county;
    }

    /**
     * @return the area
     */
    public int getArea() {
        return area;
    }

    /**
     * @param area the area to set
     */
    public void setArea(int area) {
        this.area = area;
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        return "House [id=" + id + ", title=" + title + ", intro=" + intro + ", price=" + price + ", rentMethod="
                + rentMethod + ", deposit=" + deposit + ", payment=" + payment + ", roomCount=" + roomCount
                + ", hallCount=" + hallCount + ", bathroomCount=" + bathroomCount + ", province=" + province + ", city="
                + city + ", county=" + county + ", address=" + address + ", area=" + area + ", publishTime="
                + publishTime + ", status=" + status + ", visitCount=" + visitCount + ", pictures=" + pictures
                + ", publisher=" + publisher + "]";
    }

}
