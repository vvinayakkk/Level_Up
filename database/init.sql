-- Level Up Database Initialization Script
-- This script creates the necessary tables for the Level Up application

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS levelup CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE levelup;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    username VARCHAR(100) UNIQUE,
    full_name VARCHAR(255),
    avatar_url VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_username (username)
);

-- Threads table (for saved content)
CREATE TABLE IF NOT EXISTS threads (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    title VARCHAR(255) NOT NULL,
    content JSON NOT NULL,
    platform VARCHAR(50) DEFAULT 'twitter',
    tone VARCHAR(50),
    thread_length INT DEFAULT 5,
    engagement_score DECIMAL(5,2),
    is_scheduled BOOLEAN DEFAULT FALSE,
    scheduled_at TIMESTAMP NULL,
    is_published BOOLEAN DEFAULT FALSE,
    published_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_platform (platform),
    INDEX idx_scheduled_at (scheduled_at)
);

-- Analytics table
CREATE TABLE IF NOT EXISTS analytics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    thread_id INT,
    user_id INT,
    platform VARCHAR(50) NOT NULL,
    engagement_score DECIMAL(5,2),
    reach_count INT DEFAULT 0,
    impression_count INT DEFAULT 0,
    like_count INT DEFAULT 0,
    retweet_count INT DEFAULT 0,
    comment_count INT DEFAULT 0,
    share_count INT DEFAULT 0,
    click_count INT DEFAULT 0,
    sentiment_score DECIMAL(3,2),
    analyzed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (thread_id) REFERENCES threads(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_thread_id (thread_id),
    INDEX idx_user_id (user_id),
    INDEX idx_platform (platform),
    INDEX idx_analyzed_at (analyzed_at)
);

-- Content templates table
CREATE TABLE IF NOT EXISTS content_templates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    template_data JSON NOT NULL,
    is_public BOOLEAN DEFAULT FALSE,
    category VARCHAR(100),
    tags JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_category (category),
    INDEX idx_is_public (is_public)
);

-- API usage tracking
CREATE TABLE IF NOT EXISTS api_usage (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    api_name VARCHAR(100) NOT NULL,
    endpoint VARCHAR(255),
    request_count INT DEFAULT 1,
    response_time_ms INT,
    status_code INT,
    error_message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_api_name (api_name),
    INDEX idx_created_at (created_at)
);

-- User settings table
CREATE TABLE IF NOT EXISTS user_settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE,
    theme VARCHAR(20) DEFAULT 'light',
    language VARCHAR(10) DEFAULT 'en',
    timezone VARCHAR(50) DEFAULT 'UTC',
    notification_preferences JSON,
    api_preferences JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Insert default admin user (password: admin123)
INSERT IGNORE INTO users (email, password_hash, username, full_name, is_verified) 
VALUES ('admin@levelup.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4J/HS.iK2', 'admin', 'System Administrator', TRUE);

-- Insert sample content template
INSERT IGNORE INTO content_templates (user_id, name, description, template_data, is_public, category) 
VALUES (
    1, 
    'Professional Thread Template', 
    'A template for creating professional social media threads',
    '{"tone": "professional", "thread_length": 5, "structure": ["hook", "context", "insights", "examples", "call_to_action"]}',
    TRUE,
    'professional'
);

-- Create indexes for better performance
CREATE INDEX idx_threads_created_at ON threads(created_at);
CREATE INDEX idx_analytics_platform_date ON analytics(platform, analyzed_at);
CREATE INDEX idx_api_usage_date ON api_usage(created_at);

-- Insert sample data for testing
INSERT IGNORE INTO threads (user_id, title, content, platform, tone, thread_length) 
VALUES (
    1,
    'Sample AI Thread',
    '[{"tweet": "🚀 AI is revolutionizing how we work!", "order": 1}, {"tweet": "Here are 5 ways AI is changing the game...", "order": 2}]',
    'twitter',
    'professional',
    5
); 