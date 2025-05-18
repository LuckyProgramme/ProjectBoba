<%@ page language="java" contentType="text/html; charset=UTF-8"

  pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Milk Tea</title>
     <link rel="stylesheet" href="styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
   <style> 
          .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 1.5rem;
            box-shadow: var(--shadow);
            animation: fadeIn 0.5s ease-out;
        }

        .stat-card h3 {
            color: var(--text-light);
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .stat-card .value {
            color: var(--text-dark);
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .stat-card .trend {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
        }

        .trend.up { color: #48BB78; }
        .trend.down { color: #E53E3E; }

        .categories {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .category-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 1.5rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            animation: fadeIn 0.5s ease-out;
        }

        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
        }

        .category-card.active {
            background: var(--primary-color);
        }

        .category-card i {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .category-card.active i {
            color: var(--text-dark);
        }

        .category-card h3 {
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }

        .category-card p {
            color: var(--text-light);
            font-size: 0.875rem;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .product-card {
            background: var(--white);
            border-radius: var(--radius);
            overflow: hidden;
            transition: all 0.3s ease;
            animation: fadeIn 0.5s ease-out;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: var (--shadow);
        }
        .product-image {
            width: 100%;
            height: 160px;
            object-fit: cover;
        }
        .product-info {
            padding: 1rem;
        }

        .product-info h3 {
            color: var(--text-dark);
            margin-bottom: 0.5rem;
            font-size: 1rem;
        }

        .product-info .price {
            color: var(--secondary-color);
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .product-actions {
            display: flex;
            gap: 0.5rem;
        }

        .search-bar {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .search-input {
            flex: 1;
            padding: 0.75rem 1rem;
            border: 2px solid var(--border-color);
            border-radius: var(--radius);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(255, 202, 64, 0.1);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 1024px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
   </style>
</head>
<body>
    <div class="sidebar">
       <div class="logo">
            <img src="Images/tea.png" alt="Milk Tea">
            <span>Boba Moo</span>
        </div>

        <nav class="nav-menu">
            <a href="dashb.jsp" class="nav-link active">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <a href="order.jsp" class="nav-link">
                <i class="fas fa-utensils"></i> Order
            </a>
            <a href="queu.jsp" class="nav-link">
                <i class="fas fa-list"></i> Queue
            </a>
            <a href="payment.jsp" class="nav-link">
                <i class="fas fa-file-invoice"></i> Payment
            </a>
            <a href="#" class="nav-link">
                <i class="fas fa-cog"></i> Settings
            </a>
        </nav>

        <div class="user-profile">
            <img src="admin.png" alt="User">
            <div class="user-info">
                <h4>Admin</h4>
                <p>User Admin • Online</p>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="search-bar">
            <input type="text" class="search-input" placeholder="Search for drinks, food items...">
            <button class="btn btn-primary">
                <i class="fas fa-search"></i>
                Search
            </button>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <h3>Today's Sales</h3>
                <div class="value">₱12,845</div>
                <div class="trend up">
                    <i class="fas fa-arrow-up"></i>
                    12% from yesterday
                </div>
            </div>
            <div class="stat-card">
                <h3>Total Orders</h3>
                <div class="value">48</div>
                <div class="trend up">
                    <i class="fas fa-arrow-up"></i>
                    8% from yesterday
                </div>
            </div>
            <div class="stat-card">
                <h3>Average Order Value</h3>
                <div class="value">₱267</div>
                <div class="trend up">
                    <i class="fas fa-arrow-up"></i>
                    5% from yesterday
                </div>
            </div>
            <div class="stat-card">
                <h3>Pending Orders</h3>
                <div class="value">7</div>
                <div class="trend down">
                    <i class="fas fa-arrow-down"></i>
                    2 less than usual
                </div>
            </div>
        </div>

        <h2 style="margin-bottom: 1.5rem;">Categories</h2>
        <div class="categories">
            <div class="category-card active" onclick="filterProducts(event, 'cold-drinks')">
                <i class="fas fa-glass-whiskey"></i>
                <h3>Cold Drinks</h3>
                <p>12 items</p>
            </div>
            <div class="category-card" onclick="filterProducts(event, 'hot-drinks')">
                <i class="fas fa-mug-hot"></i>
                <h3>Hot Drinks</h3>
                <p>8 items</p>
            </div>
            <div class="category-card" onclick="filterProducts(event, 'snacks')">
                <i class="fas fa-cookie"></i>
                <h3>Snacks</h3>
                <p>15 items</p>
            </div>
            <div class="category-card" onclick="filterProducts(event, 'desserts')">
                <i class="fas fa-ice-cream"></i>
                <h3>Desserts</h3>
                <p>10 items</p>
            </div>
        </div>

        <h2 style="margin: 2rem 0 1.5rem;">Popular Items</h2>
        <div class="products-grid">
            <div class="product-card">
                <img src="Images/t1.jpg" alt="Classic Milk Tea" class="product-image">
                <div class="product-info">
                    <h3>Classic Milk Tea</h3>
                    <div class="price">₱120.00</div>
                    <div class="product-actions">
                        <button class="btn btn-primary" style="flex: 1">Add to Order</button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="Images/t2.jpg" alt="Okinawa Milk Tea" class="product-image">
                <div class="product-info">
                    <h3>Okinawa Milk Tea</h3>
                    <div class="price">₱130.00</div>
                    <div class="product-actions">
                        <button class="btn btn-primary" style="flex: 1">Add to Order</button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="Images/t3.jpg" alt="Wintermelon Milk Tea" class="product-image">
                <div class="product-info">
                    <h3>Wintermelon Milk Tea</h3>
                    <div class="price">₱125.00</div>
                    <div class="product-actions">
                        <button class="btn btn-primary" style="flex: 1">Add to Order</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>

        function filterProducts(event, category) {
            // Reset all category cards
            document.querySelectorAll('.category-card').forEach(card => {
                card.classList.remove('active');
            });

            // Activate clicked category
            event.currentTarget.classList.add('active');

            // Animate products grid (demo)
            const productsGrid = document.querySelector('.products-grid');
            productsGrid.style.opacity = '0';
            setTimeout(() => {
                productsGrid.style.opacity = '1';
            }, 300);
        }

        // Search functionality
        const searchInput = document.querySelector('.search-input');
        searchInput.addEventListener('input', (e) => {
            const searchTerm = e.target.value.toLowerCase();
            // Implement search logic here
        });

        // Optional: Logout function
       <!--   
        function logout() {
            localStorage.removeItem('isLoggedIn');
            sessionStorage.removeItem('isLoggedIn');
            window.location.href = 'login.html';
        }
        -->
    </script>
    <!-- Optional: Add a logout button somewhere in your HTML, e.g. in the sidebar or header:
    <button onclick="logout()" class="btn btn-secondary">Logout</button>
    -->
</body>
</html>


