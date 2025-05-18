<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SmartPOS - Queue</title>
    <link rel="stylesheet" href="styles.css" />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      .queue-container {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 2rem;
        padding: 1rem;
      }

      .queue-section {
        background: var(--white);
        border-radius: var(--radius);
        padding: 1.5rem;
        box-shadow: var(--shadow);
      }

      .queue-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
      }

      .queue-stats {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        gap: 1rem;
        margin-bottom: 2rem;
      }

      .stat-card {
        background: var(--bg-light);
        border-radius: var(--radius);
        padding: 1rem;
        text-align: center;
      }

      .stat-card h3 {
        color: var(--text-light);
        font-size: 0.875rem;
        margin-bottom: 0.5rem;
      }

      .stat-card .value {
        color: var(--text-dark);
        font-size: 1.5rem;
        font-weight: 600;
      }

      .order-card {
        background: var(--white);
        border-radius: var(--radius);
        padding: 1.5rem;
        margin-bottom: 1rem;
        box-shadow: var(--shadow);
        animation: fadeIn 0.5s ease-out;
      }

      .order-card.completed {
        opacity: 0.7;
      }

      .order-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1rem;
      }

      .order-id {
        font-weight: 600;
        color: var(--text-dark);
      }

      .order-status {
        padding: 0.25rem 0.75rem;
        border-radius: 1rem;
        font-size: 0.875rem;
        font-weight: 500;
      }

      .status-pending {
        background: var(--primary-color);
        color: var(--text-dark);
      }

      .status-processing {
        background: #48bb78;
        color: white;
      }

      .status-completed {
        background: #a0aec0;
        color: white;
      }

      .order-items {
        margin: 1rem 0;
        padding: 1rem 0;
        border-top: 1px solid var(--border-color);
        border-bottom: 1px solid var(--border-color);
      }

      .order-item {
        display: flex;
        justify-content: space-between;
        margin-bottom: 0.5rem;
        color: var(--text-dark);
      }

      .order-actions {
        display: flex;
        gap: 1rem;
      }

      .order-meta {
        display: flex;
        justify-content: space-between;
        color: var(--text-light);
        font-size: 0.875rem;
      }

      .queue-list {
        max-height: calc(100vh - 250px);
        overflow-y: auto;
        padding-right: 0.5rem;
      }

      .queue-list::-webkit-scrollbar {
        width: 6px;
      }

      .queue-list::-webkit-scrollbar-track {
        background: var(--bg-light);
        border-radius: 3px;
      }

      .queue-list::-webkit-scrollbar-thumb {
        background: var(--border-color);
        border-radius: 3px;
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

      @keyframes slideOut {
        from {
          opacity: 1;
          transform: translateX(0);
        }
        to {
          opacity: 0;
          transform: translateX(100%);
        }
      }

      @media (max-width: 768px) {
        .queue-container {
          grid-template-columns: 1fr;
        }
      }
    </style>
  </head>
  <body>
    <div class="sidebar">
      <div class="logo">
        <img src="tea.png" alt="Mliktea" />
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
        <img src="admin.png" alt="User" />
        <div class="user-info">
          <h4>Admin</h4>
          <p>User Admin • Online</p>
        </div>
      </div>
    </div>

    <div class="main-content">
      <div class="queue-container">
        <div class="queue-section">
          <div class="queue-header">
            <h2>Active Orders</h2>
            <div class="queue-stats">
              <div class="stat-card">
                <h3>Pending</h3>
                <div class="value" id="pendingCount">0</div>
              </div>
              <div class="stat-card">
                <h3>Processing</h3>
                <div class="value" id="processingCount">0</div>
              </div>
            </div>
          </div>
          <div class="queue-list" id="activeOrders"></div>
        </div>

        <div class="queue-section">
          <div class="queue-header">
            <h2>Completed Orders</h2>
            <div class="queue-stats">
              <div class="stat-card">
                <h3>Today</h3>
                <div class="value" id="completedCount">0</div>
              </div>
            </div>
          </div>
          <div class="queue-list" id="completedOrders"></div>
        </div>
      </div>
    </div>

    <script>
      // Check login status

      // Sample orders data
      let orders = [
        {
          id: "ORD001",
          status: "pending",
          items: [
            { name: "Classic Milk Tea", quantity: 2, price: 120 },
            { name: "Taro Milk Tea", quantity: 1, price: 130 },
          ],
          total: 370,
          timestamp: new Date(Date.now() - 1000 * 60 * 15).toISOString(),
          table: "12",
        },
        {
          id: "ORD002",
          status: "processing",
          items: [{ name: "Brown Sugar Milk Tea", quantity: 3, price: 140 }],
          total: 420,
          timestamp: new Date(Date.now() - 1000 * 60 * 10).toISOString(),
          table: "8",
        },
        {
          id: "ORD003",
          status: "completed",
          items: [
            { name: "Wintermelon Milk Tea", quantity: 2, price: 130 },
            { name: "Pearl Milk Tea", quantity: 1, price: 120 },
          ],
          total: 380,
          timestamp: new Date(Date.now() - 1000 * 60 * 30).toISOString(),
          table: "5",
        },
      ];

      // Initialize page
      function initializePage() {
        updateOrderCounts();
        renderOrders();
      }

      // Update order counts
      function updateOrderCounts() {
        const pendingCount = orders.filter(
          (order) => order.status === "pending"
        ).length;
        const processingCount = orders.filter(
          (order) => order.status === "processing"
        ).length;
        const completedCount = orders.filter(
          (order) => order.status === "completed"
        ).length;

        document.getElementById("pendingCount").textContent = pendingCount;
        document.getElementById("processingCount").textContent =
          processingCount;
        document.getElementById("completedCount").textContent = completedCount;
      }

      // Render orders
      function renderOrders() {
        const activeOrders = document.getElementById("activeOrders");
        const completedOrders = document.getElementById("completedOrders");

        activeOrders.innerHTML = "";
        completedOrders.innerHTML = "";

        orders.forEach((order) => {
          const orderCard = createOrderCard(order);
          if (order.status === "completed") {
            completedOrders.appendChild(orderCard);
          } else {
            activeOrders.appendChild(orderCard);
          }
        });
      }

      // Create order card
      function createOrderCard(order) {
        const card = document.createElement("div");
        card.className = `order-card${
          order.status === "completed" ? " completed" : ""
        }`;

        let statusClass = "";
        switch (order.status) {
          case "pending":
            statusClass = "status-pending";
            break;
          case "processing":
            statusClass = "status-processing";
            break;
          case "completed":
            statusClass = "status-completed";
            break;
        }

        const orderTime = new Date(order.timestamp);
        const timeString = orderTime.toLocaleTimeString("en-US", {
          hour: "numeric",
          minute: "2-digit",
          hour12: true,
        });

        card.innerHTML = `
                <div class="order-header">
                    <span class="order-id">${order.id}</span>
                    <span class="order-status ${statusClass}">${
          order.status.charAt(0).toUpperCase() + order.status.slice(1)
        }</span>
                </div>
                <div class="order-items">
                    ${order.items
                      .map(
                        (item) => `
                        <div class="order-item">
                            <span>${item.quantity}x ${item.name}</span>
                            <span>₱${(item.price * item.quantity).toFixed(
                              2
                            )}</span>
                        </div>
                    `
                      )
                      .join("")}
                </div>
                <div class="order-meta">
                    <span>Table #${order.table}</span>
                    <span>${timeString}</span>
                </div>
                ${
                  order.status !== "completed"
                    ? `
                    <div class="order-actions">
                        ${
                          order.status === "pending"
                            ? `
                            <button class="btn btn-primary" onclick="updateOrderStatus('${order.id}', 'processing')">
                                Start Processing
                            </button>
                        `
                            : ""
                        }
                        ${
                          order.status === "processing"
                            ? `
                            <button class="btn btn-primary" onclick="updateOrderStatus('${order.id}', 'completed')">
                                Mark as Completed
                            </button>
                        `
                            : ""
                        }
                        <button class="btn btn-secondary" onclick="cancelOrder('${
                          order.id
                        }')">
                            Cancel Order
                        </button>
                    </div>
                `
                    : ""
                }
            `;

        return card;
      }

      // Update order status
      function updateOrderStatus(orderId, newStatus) {
        const order = orders.find((o) => o.id === orderId);
        if (order) {
          const orderCard = document.querySelector(
            `[data-order-id="${orderId}"]`
          );
          if (orderCard) {
            orderCard.style.animation = "slideOut 0.3s ease-out";
            orderCard.addEventListener("animationend", () => {
              order.status = newStatus;
              updateOrderCounts();
              renderOrders();
            });
          } else {
            order.status = newStatus;
            updateOrderCounts();
            renderOrders();
          }
        }
      }

      // Cancel order
      function cancelOrder(orderId) {
        if (confirm("Are you sure you want to cancel this order?")) {
          orders = orders.filter((o) => o.id !== orderId);
          updateOrderCounts();
          renderOrders();
        }
      }

      // Initialize page when DOM is loaded
      document.addEventListener("DOMContentLoaded", initializePage);

      // Refresh orders periodically
      setInterval(() => {	
        // In a real application, this would fetch new orders from the server
        renderOrders();
      }, 30000);
    </script>
  </body>
</html>
    