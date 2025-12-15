package com.book_management.service;

import com.book_management.entity.Category;
import java.util.List;

public interface CategoryService {
    List<Category> getAllCategories();
    Category getCategoryById(Integer categoryId);
    boolean addCategory(Category category);
    boolean updateCategory(Category category);
    boolean deleteCategory(Integer categoryId);
    boolean hasBooks(Integer categoryId);
}