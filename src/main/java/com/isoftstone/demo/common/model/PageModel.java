package com.isoftstone.demo.common.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class PageModel<T> implements Serializable {

	/**
	     *
	     */
	private static final long serialVersionUID = 1L;

	private int limit = 15;//每页显示条数
	private int page = 1;//当前页数
	private int records = 1;//所有记录数
	private int total = 1;//总页数
	private List<T> rows = new ArrayList<T>();

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	/**
	 * @return the page
	 */
	public int getPage() {
		if (page > total)
			page = 1;
		return page;
	}

	/**
	 * @param page
	 *            the page to set
	 */
	public void setPage(int page) {
		this.page = page;
		if (page < 1) {
			this.page = 1;
		}
	}

	/**
	 * @return the total
	 */
	public int getTotal() {
		total = (int) Math.ceil((double) records / limit);
		return total;
	}

	/**
	 * @return the records
	 */
	public int getRecords() {
		return records;
	}

	/**
	 * @param records
	 *            the records to set
	 */
	public void setRecords(int records) {
		this.records = records;
	}

	/**
	 * 是否还有下一页.
	 */
	public boolean isHasNext() {
		return (page + 1 <= this.getTotal());
	}

	/**
	 * 是否还有上一页.
	 */
	public boolean isHasPre() {
		return (page - 1 >= 1);
	}

	/**
	 * 取得下页的页号, 序号从1开始. 当前页为尾页时仍返回尾页序号.
	 */
	public int getNextPage() {
		if (isHasNext()) {
			return page + 1;
		} else {
			return page;
		}
	}

	/**
	 * 取得上页的页号, 序号从1开始. 当前页为首页时返回首页序号.
	 */
	public int getPrePage() {
		if (this.isHasPre()) {
			return page - 1;
		} else {
			return page;
		}
	}

	/**
	 * @return the rows
	 */
	public List<T> getRows() {
		return rows;
	}

	/**
	 * @param rows
	 *            the rows to set
	 */
	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public void addRow(T row) {
		if (this.rows == null)
			this.rows = new ArrayList<T>();
		this.rows.add(row);
	}
}
