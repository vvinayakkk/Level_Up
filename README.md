# Level Up - AI-Powered Social Media Content Platform

## 🎯 Project Overview

**Level Up** is a comprehensive AI-powered platform designed to solve the challenges of creating engaging, viral social media content through advanced technology. Our platform addresses the pain points of content creators, marketers, and social media managers by providing intelligent content generation, analytics, and optimization tools.

### 🎯 Problem Statement

Creating viral social media content is a complex challenge that requires:
- **Content Strategy**: Understanding what makes content go viral
- **Time Management**: Efficient content creation and scheduling
- **Analytics**: Measuring performance and optimizing based on data
- **Multi-Platform Management**: Coordinating content across different social networks
- **AI Integration**: Leveraging artificial intelligence for content generation and optimization

**Level Up** solves these challenges by providing an integrated platform that combines AI-powered content generation, advanced analytics, and intelligent workflow management.

## ✨ Features

### 🚀 Core Features
- **AI-Powered Content Generation**: Create viral threads using Google's Generative AI
- **Multi-Platform Support**: Twitter, LinkedIn, Instagram, and YouTube content
- **Real-time Analytics**: Track engagement, reach, and performance metrics
- **Smart Scheduling**: Intelligent content scheduling with optimal timing
- **PDF Export**: Export generated content as professional PDFs
- **Call Management**: Integrated voice call features using Bland.ai
- **YouTube Analytics**: Comprehensive YouTube channel analytics and insights

### 🎨 Advanced Features
- **Sentiment Analysis**: Analyze content tone and emotional impact
- **Viral Prediction**: Predict content virality potential
- **Content Templates**: Reusable templates for consistent branding
- **Collaborative Workflows**: Team-based content creation and approval
- **API Integration**: RESTful APIs for third-party integrations
- **Real-time Notifications**: Instant alerts for content performance

## 🛠️ Technology Stack

### 📁 Backend Technologies (by folder)

#### `server/` - Main Flask Backend
- **Flask** - Python web framework for API development
- **Google Generative AI** - Advanced content generation
- **LangChain** - AI/ML orchestration and prompt management
- **Transformers** - Natural language processing
- **TextBlob** - Sentiment analysis and text processing
- **FPDF** - PDF generation and export
- **Pillow** - Image processing and manipulation
- **Flask-CORS** - Cross-origin resource sharing

#### `anushka/` - Content Generation Service
- **Flask** - Dedicated content generation API
- **Google Generative AI** - Thread and content creation
- **LangChain** - AI prompt engineering
- **Transformers** - NLP processing for content optimization

#### `vinayak/` - Call Management Service
- **Flask** - Call management API
- **Bland.ai API** - Voice call integration
- **WebSocket** - Real-time communication
- **Audio Processing** - Call recording and analysis

#### `harshit/` - YouTube Analytics Service
- **Flask** - YouTube analytics API
- **Google OAuth** - YouTube API authentication
- **YouTube Data API** - Channel and video analytics
- **Pandas** - Data processing and analysis

#### `database/` - Data Layer
- **MySQL** - Primary database
- **Redis** - Caching and session management
- **SQLAlchemy** - ORM for database operations

### 📁 Frontend Technologies (`client/`)
- **React 19** - Modern UI framework
- **Vite** - Fast build tool and development server
- **Tailwind CSS** - Utility-first CSS framework
- **Framer Motion** - Smooth animations and transitions
- **React Router** - Client-side routing
- **Recharts** - Data visualization components
- **Leaflet** - Interactive maps integration
- **Lucide React** - Beautiful icon library
- **Axios** - HTTP client for API communication

### 📁 DevOps & Infrastructure
- **Docker** - Containerization for consistent deployment
- **Docker Compose** - Multi-service orchestration
- **Nginx** - Reverse proxy and load balancing
- **GitHub Actions** - CI/CD pipeline automation

## 🚀 Setup Instructions

### Method 1: Manual Setup (Bash Script)

#### Prerequisites
```bash
# Ensure you have the following installed:
# - Python 3.11+
# - Node.js 18+
# - Docker & Docker Compose
# - Git

# Clone the repository
git clone https://github.com/your-username/level-up.git
cd level-up
```

#### Backend Setup
```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install Python dependencies
pip install -r requirements.txt

# Set up environment variables
cp env.example .env
# Edit .env with your API keys

# Start main backend (Port 5000)
cd server
python app.py

# In new terminal - Start Anushka's backend (Port 5001)
cd anushka
python app.py

# In new terminal - Start Vinayak's backend (Port 5002)
cd vinayak
python app.py

# In new terminal - Start Harshit's backend (Port 5003)
cd harshit
python app.py
```

#### Frontend Setup
```bash
# Navigate to client directory
cd client

# Install Node.js dependencies
npm install

# Start development server
npm run dev
```

#### Database Setup
```bash
# Start MySQL database
docker run -d \
  --name levelup-mysql \
  -e MYSQL_ROOT_PASSWORD=password \
  -e MYSQL_DATABASE=levelup \
  -p 3306:3306 \
  mysql:8.0

# Initialize database schema
mysql -h localhost -P 3306 -u root -p levelup < database/init.sql
```

### Method 2: Docker Compose Setup

#### Quick Start
```bash
# Clone repository
git clone https://github.com/your-username/level-up.git
cd level-up

# Set up environment variables
cp env.example .env
# Edit .env with your API keys

# Build and start all services
docker-compose up --build -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

#### Service URLs
- **Frontend**: http://localhost:3000
- **Main Backend**: http://localhost:5000
- **Anushka Backend**: http://localhost:5001
- **Vinayak Backend**: http://localhost:5002
- **Harshit Backend**: http://localhost:5003
- **Database**: localhost:3306
- **Redis**: localhost:6379

#### Deployment Script
```bash
# Use the provided deployment script
./deploy-all.sh

# Deploy specific services
./deploy-all.sh deploy-backend anushka
./deploy-all.sh deploy-backend vinayak
./deploy-all.sh deploy-backend harshit

# Check service health
./deploy-all.sh health
```

## 📊 Mermaid Diagrams

### 1. System Architecture
```mermaid
graph TB
    subgraph "Client Layer"
        A[React Frontend<br/>Port 3000]
        B[Mobile App<br/>React Native]
    end
    
    subgraph "API Gateway"
        C[Nginx<br/>Load Balancer]
    end
    
    subgraph "Backend Services"
        D[Main Backend<br/>Flask - Port 5000]
        E[Anushka Backend<br/>Content Generation - Port 5001]
        F[Vinayak Backend<br/>Call Management - Port 5002]
        G[Harshit Backend<br/>YouTube Analytics - Port 5003]
    end
    
    subgraph "AI Services"
        H[Google Generative AI]
        I[LangChain]
        J[Transformers]
        K[TextBlob]
    end
    
    subgraph "External APIs"
        L[Bland.ai API]
        M[YouTube Data API]
        N[Twitter API]
        O[LinkedIn API]
    end
    
    subgraph "Data Layer"
        P[MySQL Database]
        Q[Redis Cache]
        R[File Storage]
    end
    
    A --> C
    B --> C
    C --> D
    C --> E
    C --> F
    C --> G
    
    D --> H
    D --> I
    D --> J
    D --> K
    
    E --> H
    E --> I
    
    F --> L
    
    G --> M
    
    D --> P
    E --> P
    F --> P
    G --> P
    
    D --> Q
    E --> Q
    F --> Q
    G --> Q
```

### 2. API Flow (Frontend → Backend)
```mermaid
sequenceDiagram
    participant U as User
    participant F as React Frontend
    participant N as Nginx Gateway
    participant M as Main Backend
    participant A as Anushka Backend
    participant V as Vinayak Backend
    participant H as Harshit Backend
    participant AI as AI Services
    participant DB as Database
    
    U->>F: Submit content request
    F->>N: POST /api/generate
    N->>M: Route to main backend
    M->>AI: Process with Gemini AI
    AI->>M: Return generated content
    M->>DB: Save thread data
    M->>N: Return JSON response
    N->>F: Forward response
    F->>U: Display results
    
    U->>F: Request call management
    F->>N: POST /api/call
    N->>V: Route to Vinayak backend
    V->>L: Bland.ai API call
    L->>V: Return call data
    V->>N: Return response
    N->>F: Forward response
    F->>U: Show call status
    
    U->>F: Request YouTube analytics
    F->>N: GET /api/youtube/analytics
    N->>H: Route to Harshit backend
    H->>M: YouTube Data API
    M->>H: Return analytics
    H->>N: Return response
    N->>F: Forward response
    F->>U: Display analytics
```

### 3. User Authentication State Machine
```mermaid
stateDiagram-v2
    [*] --> Unauthenticated
    Unauthenticated --> LoginForm: User clicks login
    LoginForm --> Validating: Submit credentials
    Validating --> Authenticated: Valid credentials
    Validating --> LoginForm: Invalid credentials
    Authenticated --> Dashboard: Redirect to dashboard
    Dashboard --> Profile: User clicks profile
    Dashboard --> ContentCreation: User creates content
    Dashboard --> Analytics: User views analytics
    Dashboard --> Settings: User accesses settings
    Profile --> Dashboard: Return to dashboard
    ContentCreation --> Dashboard: Save content
    Analytics --> Dashboard: Return to dashboard
    Settings --> Dashboard: Save settings
    Dashboard --> Logout: User logs out
    Logout --> Unauthenticated: Clear session
    Authenticated --> Unauthenticated: Session expired
```

### 4. Content Creation Workflow State Machine
```mermaid
stateDiagram-v2
    [*] --> ContentIdeation
    ContentIdeation --> TopicSelection: Choose topic
    TopicSelection --> ToneSelection: Select tone
    ToneSelection --> LengthSelection: Set thread length
    LengthSelection --> AIGeneration: Generate with AI
    AIGeneration --> ContentReview: Review generated content
    ContentReview --> ContentEditing: Edit if needed
    ContentReview --> ContentApproved: Approve content
    ContentEditing --> ContentReview: Submit edits
    ContentApproved --> Scheduling: Schedule publication
    ContentApproved --> ImmediatePublish: Publish now
    Scheduling --> Scheduled: Content scheduled
    ImmediatePublish --> Published: Content published
    Scheduled --> Published: Time to publish
    Published --> Analytics: Track performance
    Analytics --> ContentOptimization: Optimize based on data
    ContentOptimization --> ContentIdeation: Create new content
```

### 5. Database ER Diagram
```mermaid
erDiagram
    USERS {
        int id PK
        string email UK
        string password_hash
        string username UK
        string full_name
        string avatar_url
        boolean is_active
        boolean is_verified
        datetime created_at
        datetime updated_at
    }
    
    THREADS {
        int id PK
        int user_id FK
        string title
        json content
        string platform
        string tone
        int thread_length
        decimal engagement_score
        boolean is_scheduled
        datetime scheduled_at
        boolean is_published
        datetime published_at
        datetime created_at
        datetime updated_at
    }
    
    ANALYTICS {
        int id PK
        int thread_id FK
        int user_id FK
        string platform
        decimal engagement_score
        int reach_count
        int impression_count
        int like_count
        int retweet_count
        int comment_count
        int share_count
        int click_count
        decimal sentiment_score
        datetime analyzed_at
    }
    
    CONTENT_TEMPLATES {
        int id PK
        int user_id FK
        string name
        text description
        json template_data
        boolean is_public
        string category
        json tags
        datetime created_at
        datetime updated_at
    }
    
    API_USAGE {
        int id PK
        int user_id FK
        string api_name
        string endpoint
        int request_count
        int response_time_ms
        int status_code
        text error_message
        datetime created_at
    }
    
    USER_SETTINGS {
        int id PK
        int user_id FK
        string setting_key
        text setting_value
        datetime created_at
        datetime updated_at
    }
    
    USERS ||--o{ THREADS : creates
    USERS ||--o{ ANALYTICS : tracks
    USERS ||--o{ CONTENT_TEMPLATES : owns
    USERS ||--o{ API_USAGE : generates
    USERS ||--o{ USER_SETTINGS : has
    
    THREADS ||--o{ ANALYTICS : has
```

### 6. Deployment Flow (Local/Dev/Prod)
```mermaid
graph TB
    subgraph "Development Environment"
        A[Local Development]
        B[Feature Branch]
        C[Code Review]
    end
    
    subgraph "Testing Environment"
        D[Unit Tests]
        E[Integration Tests]
        F[E2E Tests]
    end
    
    subgraph "Staging Environment"
        G[Staging Build]
        H[Staging Deployment]
        I[QA Testing]
    end
    
    subgraph "Production Environment"
        J[Production Build]
        K[Blue-Green Deployment]
        L[Production Monitoring]
    end
    
    A --> B
    B --> C
    C --> D
    D --> E
    E --> F
    F --> G
    G --> H
    H --> I
    I --> J
    J --> K
    K --> L
    
    L --> M[Rollback if needed]
    M --> H
```

### 7. Microservice Communication
```mermaid
graph LR
    subgraph "API Gateway"
        A[Nginx Load Balancer]
    end
    
    subgraph "Backend Services"
        B[Main Backend<br/>Port 5000]
        C[Anushka Backend<br/>Port 5001]
        D[Vinayak Backend<br/>Port 5002]
        E[Harshit Backend<br/>Port 5003]
    end
    
    subgraph "Shared Services"
        F[MySQL Database]
        G[Redis Cache]
        H[File Storage]
    end
    
    subgraph "External Services"
        I[Google Generative AI]
        J[Bland.ai API]
        K[YouTube Data API]
        L[Social Media APIs]
    end
    
    A --> B
    A --> C
    A --> D
    A --> E
    
    B --> F
    C --> F
    D --> F
    E --> F
    
    B --> G
    C --> G
    D --> G
    E --> G
    
    B --> I
    C --> I
    D --> J
    E --> K
    
    B --> L
    C --> L
    D --> L
    E --> L
```

### 8. CI/CD Pipeline Overview
```mermaid
graph LR
    subgraph "Source Control"
        A[GitHub Repository]
        B[Feature Branches]
        C[Main Branch]
    end
    
    subgraph "CI Pipeline"
        D[Code Push]
        E[Lint & Format]
        F[Unit Tests]
        G[Integration Tests]
        H[Security Scan]
        I[Build Images]
    end
    
    subgraph "CD Pipeline"
        J[Deploy to Staging]
        K[Automated Tests]
        L[Manual QA]
        M[Deploy to Production]
        N[Health Checks]
        O[Monitoring]
    end
    
    A --> D
    B --> D
    C --> D
    
    D --> E
    E --> F
    F --> G
    G --> H
    H --> I
    
    I --> J
    J --> K
    K --> L
    L --> M
    M --> N
    N --> O
    
    O --> P[Rollback if needed]
    P --> J
```

## 🔧 Environment Configuration

### Required Environment Variables
```env
# Flask Configuration
FLASK_ENV=development
FLASK_DEBUG=1
FLASK_APP=app.py

# API Keys
GEMINI_API_KEY=your_gemini_api_key
COMPOSIO_API_KEY=your_composio_api_key
SERP_API_KEY=your_serp_api_key
EMAIL_PASSWORD=your_email_password
BLAND_API_KEY=your_bland_api_key

# Database Configuration
DATABASE_URL=mysql://user:password@db/levelup
REDIS_URL=redis://localhost:6379

# Frontend Configuration
REACT_APP_API_URL=http://localhost:5000
REACT_APP_ANUSHKA_API_URL=http://localhost:5001
REACT_APP_VINAYAK_API_URL=http://localhost:5002
REACT_APP_HARSHIT_API_URL=http://localhost:5003
```

## 📡 API Documentation

### Content Generation Endpoints
```bash
# Generate viral thread
POST /api/generate
{
  "topic": "AI in Healthcare",
  "tone": "professional",
  "thread_length": 5
}

# Analyze tweet metrics
POST /api/analyze
{
  "tweet_text": "Your tweet content",
  "platform": "twitter"
}

# Export thread as PDF
POST /api/export_pdf
{
  "thread_data": [...],
  "filename": "my_thread.pdf"
}
```

### Call Management Endpoints
```bash
# Initiate call
POST /api/call/initiate
{
  "phone_number": "+1234567890",
  "message": "Hello from Level Up"
}

# Get call status
GET /api/call/status/{call_id}
```

### YouTube Analytics Endpoints
```bash
# Get channel analytics
GET /api/youtube/analytics
{
  "channel_id": "your_channel_id",
  "date_range": "last_30_days"
}

# Get video performance
GET /api/youtube/video/{video_id}
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines
- Follow PEP 8 for Python code
- Use ESLint for JavaScript/React code
- Write tests for new features
- Update documentation for API changes
- Use conventional commit messages

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Create an issue in the GitHub repository
- Contact the development team
- Check the documentation wiki

---

**Built with ❤️ by the Level Up Team** 