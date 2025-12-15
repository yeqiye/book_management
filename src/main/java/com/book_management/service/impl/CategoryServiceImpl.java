package com.book_management.service.impl;

import com.book_management.dao.CategoryMapper;
import com.book_management.entity.Category;
import com.book_management.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public List<Category> getAllCategories() {
        return categoryMapper.findAll();
    }

    @Override
    public Category getCategoryById(Integer categoryId) {
        return categoryMapper.findById(categoryId);
    }

    @Override
    public boolean addCategory(Category category) {
        return categoryMapper.insert(category) > 0;
    }

    @Override
    public boolean updateCategory(Category category) {
        return categoryMapper.update(category) > 0;
    }

    @Override
    public boolean deleteCategory(Integer categoryId) {
        if (categoryMapper.countBooksByCategory(categoryId) > 0) {
            return false;
        }
        return categoryMapper.delete(categoryId) > 0;
    }

    @Override
    public boolean hasBooks(Integer categoryId) {
        return categoryMapper.countBooksByCategory(categoryId) > 0;
    }
}