<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — Employee Management System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: linear-gradient(135deg, #0f0f1a 0%, #1a1a2e 50%, #16213e 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-wrapper {
            display: flex;
            width: 900px;
            max-width: 95vw;
            min-height: 520px;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 25px 60px rgba(0,0,0,0.5);
        }

        /* Left panel */
        .left-panel {
            flex: 1;
            background: linear-gradient(160deg, #1F4E79, #2E75B6, #1a7a4a);
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: white;
        }

        .brand-icon { font-size: 52px; margin-bottom: 20px; }
        .brand-name { font-family: 'Syne', sans-serif; font-size: 32px; font-weight: 800; }
        .brand-sub  { font-size: 14px; opacity: 0.75; margin-top: 4px; margin-bottom: 32px; letter-spacing: 1px; text-transform: uppercase; }

        .feature { display: flex; align-items: center; gap: 12px; margin-bottom: 16px; font-size: 14px; opacity: 0.9; }
        .feature-icon { font-size: 18px; }

        /* Right panel */
        .right-panel {
            flex: 1;
            background: #ffffff;
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .right-panel h2 {
            font-family: 'Syne', sans-serif;
            font-size: 26px;
            font-weight: 700;
            color: #1F4E79;
            margin-bottom: 6px;
        }

        .right-panel p.sub {
            font-size: 13px;
            color: #888;
            margin-bottom: 28px;
        }

        .error-box {
            background: #fff0f0;
            border-left: 4px solid #e74c3c;
            color: #c0392b;
            padding: 12px 16px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 13px;
            font-weight: 500;
            color: #444;
            margin-bottom: 6px;
        }

        input[type=text], input[type=password] {
            width: 100%;
            padding: 12px 16px;
            border: 1.5px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            font-family: 'DM Sans', sans-serif;
            color: #333;
            margin-bottom: 18px;
            transition: border-color 0.2s;
            outline: none;
        }

        input:focus { border-color: #2E75B6; }

        .btn-login {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg, #1F4E79, #2E75B6);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-family: 'Syne', sans-serif;
            font-weight: 600;
            cursor: pointer;
            letter-spacing: 0.5px;
            transition: opacity 0.2s;
        }

        .btn-login:hover { opacity: 0.9; }

        .hint {
            margin-top: 24px;
            padding: 14px 16px;
            background: #f0f7ff;
            border-radius: 8px;
            font-size: 12px;
            color: #555;
            line-height: 1.8;
        }

        .hint strong { color: #1F4E79; }

        @media (max-width: 640px) {
            .left-panel { display: none; }
            .right-panel { padding: 40px 28px; }
        }
    </style>
</head>
<body>
<div class="login-wrapper">

    <!-- Left Branding Panel -->
    <div class="left-panel">
        <div class="brand-icon">⚡</div>
        <div class="brand-name">EMS</div>
        <div class="brand-sub">Employee Management System</div>

        <div class="feature"><span class="feature-icon">👥</span> Manage Employees & Departments</div>
        <div class="feature"><span class="feature-icon">📊</span> View Salary Reports</div>
        <div class="feature"><span class="feature-icon">🔒</span> Secure Role-based Access</div>
        <div class="feature"><span class="feature-icon">⚙️</span> Built with Java + JDBC + MySQL</div>
    </div>

    <!-- Right Login Form -->
    <div class="right-panel">
        <h2>Welcome Back 👋</h2>
        <p class="sub">Sign in to your EMS account</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-box">⚠️ <%= request.getAttribute("error") %></div>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/auth/login">
            <label for="username">Username</label>
            <input type="text" id="username" name="username"
                   placeholder="Enter your username"
                   value="<%= request.getAttribute("enteredUsername") != null ? request.getAttribute("enteredUsername") : "" %>"
                   required autofocus>

            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   placeholder="Enter your password"
                   required>

            <button type="submit" class="btn-login">Sign In →</button>
        </form>

    </div>

</div>
</body>
</html>
