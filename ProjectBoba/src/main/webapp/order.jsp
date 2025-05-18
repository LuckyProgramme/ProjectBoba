<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartPOS - Order</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
   <style>
        /* Your existing global styles (if any) */

        body {
            display: flex;
        }

        .sidebar {
            width: 250px;
            flex-shrink: 0;
        }

        .main-content {
            flex-grow: 1;
            margin: 1rem; /* Added margin for overall spacing */
        }

       .order-container {
        display: flex; /* Change to flexbox */
        margin-left: 220px; /* Width of the sidebar */
        gap: 2rem;
        height: calc(100vh - 2rem);
        margin-top: 1rem;
        margin-bottom: 1rem;
    }
        .menu-section {
        flex: 1; /* Allow it to grow and take remaining space */
        overflow-y: auto;
        padding-right: 1rem;
        min-width: calc(100% - 320px - 2rem); /* Ensure it doesn't get too small */
    }
        .cart-section {
            background: var(--white);
            border-radius: var(--radius);
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            box-shadow: var(--shadow);
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .menu-item {
            background: var(--white);
            border-radius: var(--radius);
            overflow: hidden;
            transition: all 0.3s ease;
            animation: fadeIn 0.5s ease-out;
        }

        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
        }

        .menu-item img {
            width: 100%;
            height: 160px;
            object-fit: cover;
        }

        .menu-item-info {
            padding: 1rem;
        }

        .menu-item-info h3 {
            margin: 0 0 0.5rem;
            color: var(--text-dark);
        }

        .menu-item-info .price {
            color: var(--secondary-color);
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .cart-items {
            flex: 1;
            overflow-y: auto;
            margin: 1rem 0;
        }

        .cart-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            animation: slideIn 0.3s ease-out;
        }

        .cart-item-info {
            flex: 1;
            padding: 0 1rem;
        }

        .cart-item-info h4 {
            margin: 0 0 0.25rem;
            color: var(--text-dark);
        }

        .cart-item-info .price {
            color: var(--secondary-color);
            font-weight: 600;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .quantity-btn {
            background: var(--bg-light);
            border: none;
            border-radius: var(--radius);
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }

        .quantity-btn:hover {
            background: var(--primary-color);
        }

        .cart-summary {
            border-top: 2px solid var(--border-color);
            padding-top: 1rem;
        }

        .cart-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        .categories {
            display: flex;
            gap: 1rem;
            overflow-x: auto;
            padding-bottom: 1rem;
            margin-bottom: 1rem;
        }

        .category-btn {
            background: var(--bg-light);
            border: none;
            border-radius: var(--radius);
            padding: 0.75rem 1.5rem;
            color: var(--text-dark);
            cursor: pointer;
            transition: all 0.3s;
            white-space: nowrap;
        }

        .category-btn.active {
            background: var(--primary-color);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideIn {
            from {
                transform: translateX(-10px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        /* Mobile Styles (if you want the mobile cart behavior) */
        @media (max-width: 768px) {
             .order-container {
            margin-left: 0; /* Remove the left margin on smaller screens */
            flex-direction: column; /* Stack the items vertically */
        }
         .menu-section {
            min-width: auto; /* Allow full width on smaller screens */
        }
            .cart-section {
                position: fixed;
                bottom: 0;
                left: 0;
                right: 0;
                height: 60vh;
                margin: 0;
                border-radius: var(--radius) var(--radius) 0 0;
                z-index: 100;
                transform: translateY(calc(100% - 60px));
                transition: transform 0.3s ease;
            }

            .cart-section.expanded {
                transform: translateY(0);
            }

            .cart-header {
                cursor: pointer;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo">
            <img src="Images/tea.png" alt="SmartPOS">
            <span>Boba Moo</span>
        </div>

        <nav class="nav-menu">
            <a href="dashb.jsp" class="nav-link">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <a href="#" class="nav-link active">
                <i class="fas fa-utensils"></i> Order
            </a>
            <a href="queue.jsp" class="nav-link">
                <i class="fas fa-list"></i> Queue
            </a>
            <a href="payment.jsp" class="nav-link">
                <i class="fas fa-file-invoice"></i> Payment
            </a>
            <a href="#" class="nav-link"> <i class="fas fa-cog"></i> Settings </a>
        </nav>

        <div class="user-profile">
            <img src="Images/admin.png" alt="User">
            <div class="user-info">
                <h4>Admin</h4>
                <p>User Admin • Online</p>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="order-container">
            <div class="menu-section">
                <div class="search-bar">
                    <input type="text" class="search-input" placeholder="Search menu items...">
                    <button type="button" class="search-btn">
                        <i class="fas fa-search"></i>
                    </button>
                </div>

                <div class="categories">
                    <button class="category-btn active" onclick="filterMenu('all')">All Items</button>
                    <button class="category-btn" onclick="filterMenu('milk-tea')">Milk Tea</button>
                    <button class="category-btn" onclick="filterMenu('fruit-tea')">Fruit Tea</button>
                    <button class="category-btn" onclick="filterMenu('coffee')">Coffee</button>
                    <button class="category-btn" onclick="filterMenu('snacks')">Snacks</button>
                </div>

                <div class="menu-grid">
             
                    </div>
            </div>

            <div class="cart-section">
                <div class="cart-header">
                    <h2>Current Order</h2>
                    <p class="text-light">Table #12</p>
                </div>

                <div class="cart-items">
                    </div>

                <div class="cart-summary">
                    <div class="cart-total">
                        <span>Total</span>
                        <span class="total-amount">₱0.00</span>
                    </div>
                    <button class="btn btn-primary btn-block" onclick="proceedToPayment()">Proceed to Payment</button>
                </div>
            </div>
        </div>
    </div>

    <div id="toppingsModal" class="modal-overlay" style="display: none;">
        <div class="modal-content modal-toppings">
            <div class="modal-product-header">
                <img id="modalProductImg" src="" alt="Product" class="modal-product-img">
                <div>
                    <h3 id="modalProductName">Milk Tea</h3>
                    <div id="modalProductPrice" class="modal-product-price">₱0.00</div>
                </div>
            </div>
            <form id="toppingsForm">
                <div class="topping-row" data-topping="Boba">
                    <img src="assets/boba.png" alt="Boba" class="topping-icon">
                    <span class="topping-name">Boba</span>
                    <div class="topping-qty-controls">
                        <button type="button" class="topping-qty-btn" onclick="changeToppingQty('Boba', -1)">-</button>
                        <span id="qty-Boba">0</span>
                        <button type="button" class="topping-qty-btn" onclick="changeToppingQty('Boba', 1)">+</button>
                    </div>
                </div>
                <div class="topping-row" data-topping="Gellies">
                    <img src="assets/gellies.png" alt="Gellies" class="topping-icon">
                    <span class="topping-name">Gellies</span>
                    <div class="topping-qty-controls">
                        <button type="button" class="topping-qty-btn" onclick="changeToppingQty('Gellies', -1)">-</button>
                        <span id="qty-Gellies">0</span>
                        <button type="button" class="topping-qty-btn" onclick="changeToppingQty('Gellies', 1)">+</button>
                    </div>
                </div>
                <div class="topping-row" data-topping="Pudding">
                    <img src="assets/pudding.png" alt="Pudding" class="topping-icon">
                    <span class="topping-name">Pudding</span>
                    <div class="topping-qty-controls">
                        <button type="button" class="topping-qty-btn" onclick="changeToppingQty('Pudding', -1)">-</button>
                        <span id="qty-Pudding">0</span>
                        <button type="button" class="topping-qty-btn" onclick="changeToppingQty('Pudding', 1)">+</button>
                    </div>
                </div>
                <div class="topping-row" data-topping="Oreo">
                    <img src="assets/oreo.png" alt="Oreo" class="topping-icon">
                    <span class="topping-name">Oreo</span>
                    <div class="topping-qty-controls">
                        <button type="button" class="topping-qty-btn" onclick="changeToppingQty('Oreo', -1)">-</button>
                        <span id="qty-Oreo">0</span>
                        <button type="button" class="topping-qty-btn" onclick="changeToppingQty('Oreo', 1)">+</button>
                    </div>
                </div>
                <div class="sugar-row" style="margin-bottom: 1.2rem;">
                    <label><input type="radio" name="sugar" value="0%" required> 0%</label>
                    <label><input type="radio" name="sugar" value="25%"> 25%</label>
                    <label><input type="radio" name="sugar" value="50%" checked> 50%</label>
                    <label><input type="radio" name="sugar" value="75%"> 75%</label>
                    <label><input type="radio" name="sugar" value="100%"> 100%</label>
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeToppingsModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add to Order</button>
                </div>
            </form>
        </div>
    </div>

   <script src="menu.js">
   </script>

</body>
</html>