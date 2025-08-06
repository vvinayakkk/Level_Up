#!/bin/bash

# Level Up - Multi-Backend Deployment Script
# This script helps deploy all backend services (Anushka, Vinayak, Harshit) and frontend

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is installed
check_docker() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    print_success "Docker and Docker Compose are installed"
}

# Check if .env file exists
check_env() {
    if [ ! -f .env ]; then
        print_warning ".env file not found. Creating from template..."
        if [ -f env.example ]; then
            cp env.example .env
            print_warning "Please edit .env file with your actual values before continuing"
            exit 1
        else
            print_error "env.example file not found. Please create a .env file manually."
            exit 1
        fi
    fi
    print_success ".env file found"
}

# Build and start all services
deploy_all() {
    print_status "Building and starting all services..."
    
    # Stop existing containers
    docker-compose down
    
    # Build and start all services
    docker-compose up --build -d
    
    print_success "All services started successfully!"
    print_status "Frontend: http://localhost:3000"
    print_status "Main Backend: http://localhost:5000"
    print_status "Anushka Backend: http://localhost:5001"
    print_status "Vinayak Backend: http://localhost:5002"
    print_status "Harshit Backend: http://localhost:5003"
    print_status "Database: localhost:3306"
    print_status "Redis: localhost:6379"
}

# Deploy specific backend service
deploy_backend() {
    local service=$1
    local port=$2
    
    print_status "Deploying $service backend on port $port..."
    
    case $service in
        "anushka")
            docker-compose up -d anushka-backend
            ;;
        "vinayak")
            docker-compose up -d vinayak-backend
            ;;
        "harshit")
            docker-compose up -d harshit-backend
            ;;
        "main")
            docker-compose up -d backend
            ;;
        *)
            print_error "Unknown service: $service"
            print_status "Available services: main, anushka, vinayak, harshit"
            exit 1
            ;;
    esac
    
    print_success "$service backend deployed on port $port"
}

# Deploy frontend only
deploy_frontend() {
    print_status "Deploying frontend..."
    docker-compose up -d frontend
    print_success "Frontend deployed on port 3000"
}

# Show logs for specific service
logs() {
    local service=$1
    
    if [ -z "$service" ]; then
        print_status "Showing all service logs..."
        docker-compose logs -f
    else
        print_status "Showing logs for $service..."
        docker-compose logs -f $service
    fi
}

# Stop all services
stop_all() {
    print_status "Stopping all services..."
    docker-compose down
    print_success "All services stopped"
}

# Restart specific service
restart_service() {
    local service=$1
    
    if [ -z "$service" ]; then
        print_error "Please specify a service to restart"
        print_status "Available services: main, anushka, vinayak, harshit, frontend, db, redis"
        exit 1
    fi
    
    print_status "Restarting $service..."
    docker-compose restart $service
    print_success "$service restarted"
}

# Clean up
clean() {
    print_warning "This will remove all containers, images, and volumes. Are you sure? (y/N)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        print_status "Cleaning up..."
        docker-compose down -v --rmi all
        docker system prune -f
        print_success "Cleanup completed"
    else
        print_status "Cleanup cancelled"
    fi
}

# Health check for all services
health_check() {
    print_status "Checking service health..."
    
    # Check if containers are running
    if docker-compose ps | grep -q "Up"; then
        print_success "All services are running"
    else
        print_error "Some services are not running"
        docker-compose ps
        exit 1
    fi
    
    # Check frontend
    if curl -s http://localhost:3000 > /dev/null; then
        print_success "Frontend is accessible"
    else
        print_error "Frontend is not accessible"
    fi
    
    # Check main backend
    if curl -s http://localhost:5000 > /dev/null; then
        print_success "Main backend is accessible"
    else
        print_error "Main backend is not accessible"
    fi
    
    # Check Anushka's backend
    if curl -s http://localhost:5001 > /dev/null; then
        print_success "Anushka's backend is accessible"
    else
        print_error "Anushka's backend is not accessible"
    fi
    
    # Check Vinayak's backend
    if curl -s http://localhost:5002 > /dev/null; then
        print_success "Vinayak's backend is accessible"
    else
        print_error "Vinayak's backend is not accessible"
    fi
    
    # Check Harshit's backend
    if curl -s http://localhost:5003 > /dev/null; then
        print_success "Harshit's backend is accessible"
    else
        print_error "Harshit's backend is not accessible"
    fi
}

# Show service status
status() {
    print_status "Service Status:"
    docker-compose ps
    
    echo ""
    print_status "Service URLs:"
    echo "Frontend: http://localhost:3000"
    echo "Main Backend: http://localhost:5000"
    echo "Anushka Backend: http://localhost:5001"
    echo "Vinayak Backend: http://localhost:5002"
    echo "Harshit Backend: http://localhost:5003"
    echo "Database: localhost:3306"
    echo "Redis: localhost:6379"
}

# Show usage
usage() {
    echo "Usage: $0 {deploy|deploy-backend|deploy-frontend|logs|stop|restart|clean|health|status|check}"
    echo ""
    echo "Commands:"
    echo "  deploy              - Build and start all services"
    echo "  deploy-backend      - Deploy specific backend (main|anushka|vinayak|harshit)"
    echo "  deploy-frontend     - Deploy frontend only"
    echo "  logs [service]      - Show service logs (optional service name)"
    echo "  stop                - Stop all services"
    echo "  restart [service]   - Restart specific service"
    echo "  clean               - Remove all containers, images, and volumes"
    echo "  health              - Check service health"
    echo "  status              - Show service status and URLs"
    echo "  check               - Check prerequisites"
    echo ""
    echo "Examples:"
    echo "  $0 deploy-backend anushka"
    echo "  $0 logs anushka-backend"
    echo "  $0 restart vinayak-backend"
}

# Main script
case "$1" in
    deploy)
        check_docker
        check_env
        deploy_all
        ;;
    deploy-backend)
        if [ -z "$2" ]; then
            print_error "Please specify a backend service"
            print_status "Available backends: main, anushka, vinayak, harshit"
            exit 1
        fi
        check_docker
        check_env
        case $2 in
            "main") deploy_backend "main" "5000" ;;
            "anushka") deploy_backend "anushka" "5001" ;;
            "vinayak") deploy_backend "vinayak" "5002" ;;
            "harshit") deploy_backend "harshit" "5003" ;;
            *) print_error "Unknown backend: $2" ;;
        esac
        ;;
    deploy-frontend)
        check_docker
        check_env
        deploy_frontend
        ;;
    logs)
        logs "$2"
        ;;
    stop)
        stop_all
        ;;
    restart)
        restart_service "$2"
        ;;
    clean)
        clean
        ;;
    health)
        health_check
        ;;
    status)
        status
        ;;
    check)
        check_docker
        check_env
        print_success "All prerequisites are met"
        ;;
    *)
        usage
        exit 1
        ;;
esac
