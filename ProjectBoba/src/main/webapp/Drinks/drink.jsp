<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SmartPOS - Drinks</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="drinks.css">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
	<div class="dashboard">
    <!-- Sidebar -->
    <div class="sidebar">
      <div class="logo">SmartPOS</div>
      <a href="dashboard.html" class="menu-item">
        <i class="bi bi-house-door"></i> Dashboard
      </a>
      <a href="drinks.html" class="menu-item active">
        <i class="bi bi-cup-straw"></i> Drinks
      </a>
      <a href="orders.html" class="menu-item">
        <i class="bi bi-cart"></i> Orders
      </a>
      <a href="#" class="menu-item">
        <i class="bi bi-gear"></i> Settings
      </a>
      <a href="#" class="menu-item">
        <i class="bi bi-life-preserver"></i> Support
      </a>
      <div class="menu-item" style="margin-top: auto;">
        <i class="bi bi-person-circle"></i> Theresa Webb<br>
        <small>Waiter - 4h 56m</small>
      </div>
    </div>

    <!-- Main Content -->
    <div class="main">
      <!-- Header -->
      <header class="header">
        <h1>Drinks Menu</h1>
        <input type="search" placeholder="Search drinks..." class="search-bar">
      </header>

      <!-- Drinks Grid -->
      <div class="drinks-grid">
        <div class="drink-card">
          <img src="images/milk-tea.jpg" alt="Milk Tea">
          <h3>Milk Tea</h3>
          <p>$3.50</p>
        </div>
        <div class="drink-card">
          <img src="images/latte.jpg" alt="Latte">
          <h3>Latte</h3>
          <p>$4.00</p>
        </div>
        <div class="drink-card">
          <img src="images/smoothie.jpg" alt="Smoothie">
          <h3>Smoothie</h3>
          <p>$5.00</p>
        </div>
        <div class="drink-card">
          <img src="images/iced-coffee.jpg" alt="Iced Coffee">
          <h3>Iced Coffee</h3>
          <p>$3.00</p>
        </div>
      </div>
    </div>
  </div>
</body>
</html>