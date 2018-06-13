package com.ruanyf.houserenting.entity;

import java.util.List;

/**
 * 用于分页参数封装的Bean
 * @author Feng
 */
public class PageBean<T> {

	private int currentPage;	// 当前页码
	private int pageSize;	// 每页记录数
	private int totalPage;	// 总页数
	private int totalCount;	// 总记录数
	private List<T> list;	// 每页显示的数据

	/**
	 * 默认构造方法
	 */
	public PageBean() {
	}

	
	/**
	 * 带参数构造方法
	 * @param currentPage
	 * @param pageSize
	 * @param totalPage
	 * @param totalCount
	 * @param list
	 */
	public PageBean(int currentPage, int pageSize, int totalPage, int totalCount, List<T> list) {
		super();
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalPage = totalPage;
		this.totalCount = totalCount;
		this.list = list;
	}


	/**
	 * @return the currentPage
	 */
	public int getCurrentPage() {
		return currentPage;
	}
	/**
	 * @param currentPage the currentPage to set
	 */
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	/**
	 * @return the pageSize
	 */
	public int getPageSize() {
		return pageSize;
	}
	/**
	 * @param pageSize the pageSize to set
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	/**
	 * @return the totalPage
	 */
	public int getTotalPage() {
		return totalPage;
	}
	/**
	 * @param totalPage the totalPage to set
	 */
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	/**
	 * @return the totalCount
	 */
	public int getTotalCount() {
		return totalCount;
	}
	/**
	 * @param totalCount the totalCount to set
	 */
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	/**
	 * @return the list
	 */
	public List<T> getList() {
		return list;
	}
	/**
	 * @param list the list to set
	 */
	public void setList(List<T> list) {
		this.list = list;
	}

}
