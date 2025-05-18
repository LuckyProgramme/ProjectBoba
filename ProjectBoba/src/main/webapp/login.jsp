<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SmartPOS - Login</title>
    <link rel="stylesheet" href="styles.css"/>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        display: grid;
        grid-template-columns: 1fr 1fr;
        min-height: 100vh;
        margin: 0;
        background: var(--bg-light);
      }

      .login-image {
        background: linear-gradient(
          135deg,
          var(--primary-color),
          var(--secondary-color)
        );
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2rem;
        position: relative;
        overflow: hidden;
      }

      .login-image::before {
        content: "";
        position: absolute;
        width: 200%;
        height: 200%;
        background: url('data:image/svg+xml,<svg width="60" height="60" viewBox="0 0 60 60" xmlns="http://www.w3.org/2000/svg"><path d="M0 0h60v60H0z" fill="none"/><path d="M30 30m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" fill="rgba(255,255,255,0.1)"/></svg>');
        opacity: 0.1;
        animation: slide 20s linear infinite;
      }

      @keyframes slide {
        from {
          transform: translateX(-50%) translateY(0);
        }
        to {
          transform: translateX(0) translateY(-50%);
        }
      }

      .login-content {
        display: flex;
        flex-direction: column;
        justify-content: center;
        padding: 4rem;
        animation: fadeIn 0.5s ease-out;
      }

      .login-header {
        text-align: center;
        margin-bottom: 3rem;
      }

      .login-header img {
        width: 64px;
        height: 64px;
        margin-bottom: 1rem;
      }

      .login-header h1 {
        color: var(--text-dark);
        font-size: 2rem;
        margin-bottom: 0.5rem;
      }

      .login-header p {
        color: var(--text-light);
      }

      .form-group {
        margin-bottom: 1.5rem;
      }

      .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        color: var(--text-dark);
        font-weight: 500;
      }

      .form-group input {
        width: 100%;
        padding: 0.75rem 1rem;
        border: 2px solid var(--border-color);
        border-radius: var(--radius);
        font-size: 1rem;
        transition: all 0.3s ease;
      }

      .form-group input:focus {
        outline: none;
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(255, 202, 64, 0.1);
      }

      .remember-forgot {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
      }

      .remember-me {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: var(--text-light);
      }

      .forgot-password {
        color: var(--secondary-color);
        text-decoration: none;
        font-weight: 500;
      }

      .forgot-password:hover {
        text-decoration: underline;
      }

      .login-btn {
        width: 100%;
        padding: 0.875rem;
        background: var(--primary-color);
        color: var(--text-dark);
        border: none;
        border-radius: var(--radius);
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-bottom: 1.5rem;
      }

      .login-btn:hover {
        background: #e6b639;
      }

      .social-login {
        text-align: center;
      }

      .social-login p {
        color: var(--text-light);
        margin-bottom: 1rem;
        position: relative;
      }

      .social-login p::before,
      .social-login p::after {
        content: "";
        position: absolute;
        top: 50%;
        width: 45%;
        height: 1px;
        background: var(--border-color);
      }

      .social-login p::before {
        left: 0;
      }
      .social-login p::after {
        right: 0;
      }

      .social-buttons {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 1rem;
      }

      .social-btn {
        padding: 0.75rem;
        border: 2px solid var(--border-color);
        border-radius: var(--radius);
        background: var(--white);
        color: var(--text-dark);
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
      }

      .social-btn:hover {
        border-color: var(--text-dark);
      }

      .social-btn i {
        font-size: 1.25rem;
      }

      @media (max-width: 768px) {
        body {
          grid-template-columns: 1fr;
        }

        .login-image {
          display: none;
        }

        .login-content {
          padding: 2rem;
        }
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
    </style>
  </head>
<body>
    <div class="login-image">
      <img
        src="assets/logo.svg"
        alt="SmartPOS"
        style="width: 200px; height: 200px; position: relative; z-index: 1"
      />
    </div>

    <div class="login-content">
      <div class="login-header">
        <img src="assets/logo.svg" alt="SmartPOS" />
        <h1>Welcome Back!</h1>
        <p>Please enter your credentials to continue</p>
      </div>

  <form class="loginForm" action="ProcessLogIn" method="get">
        <div class="form-group">
          <label for="salesId">Username</label>
    	  <input type="text" name="admin_name" placeholder="Admin" required />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <div class="password-wrapper" style="position: relative">
            <input type="password"
              id="password"
              name="password"
              required
              style="padding-right: 2.5rem"
            />
            <span
              id="togglePassword"
              style="
                position: absolute;
                right: 1rem;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: #aaa;
              "
            >
              <i class="fa fa-eye" id="eyeIcon"></i>
            </span>
          </div>
        </div>

        <div class="remember-forgot">
          <label class="remember-me">
            <input type="checkbox" id="remember" />
            <span>Remember me</span>
          </label>
          <a href="#" class="forgot-password">Forgot password?</a>
        </div>

        <button type="submit" class="login-btn">Sign In</button>
      </form>
    </div>

    <script>
      function socialLogin(provider) {
        // Demo social login
        alert(`${provider} login is not implemented in this demo`);
      }

      // Show/hide password functionality
      const passwordInput = document.getElementById("password");
      const togglePassword = document.getElementById("togglePassword");
      const eyeIcon = document.getElementById("eyeIcon");

      togglePassword.addEventListener("click", function () {
        const type = passwordInput.type === "password" ? "text" : "password";
        passwordInput.type = type;
        eyeIcon.classList.toggle("fa-eye");
        eyeIcon.classList.toggle("fa-eye-slash");
      });

    </script>
  </body>
</html>
