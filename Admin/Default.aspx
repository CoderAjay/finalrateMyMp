<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="../JS/jquery.js"></script>
<link type="text/css" rel="stylesheet" href="../CSS/Admin/adminLogin.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Welcome Admin</title>

<script >
    $(document).ready(function () {
        $("#forgot-link").click(function () {
            $("#popup-container").fadeIn(500);
        });
        $("#btnCancel").click(function () {
            $("#popup-container").fadeOut(500);
        });
        $("#popup-cross").click(function () {
            $("#popup-container").fadeOut(500);
        });

    });
</script>
</head>

<body>
	<!-- Main Container Start -->
    <div id="main-container">
    	<!-- Login Outer Start -->
    	<div id="login-outer">
            <div id="login-inner">
            	<div id="header">
                	<h2> Admin Panel Login</h2>
                </div>
                <!-- Middle Start -->
                <div id="middle">
                		<div class="div-row"></div>
                    	<div class="div-row">
                        	<div class="div-icon"><img src="../Images/admin/user.png" /></div>
                            <div class="div-text"><input class="txtBox" type="text" placeholder="username" name="userName" /></div>
                        </div>
                    	<div class="div-row"></div>
                    	<div class="div-row">
                       		<div class="div-icon"><img src="../Images/admin/password.png" /></div>
                            <div class="div-text"><input class="txtBox" type="password" placeholder="password" name="userPassword" /></div>
                        </div>
                    	<div class="div-row mg-top20">
                        	<div class="div-btn">
                            <button class="btn" type="button" >LOGIN</button>
                            </div>
                        	<div class="div-btn">
                            <button class="btn" type="button" >CANCEL</button>
                            </div>
                        </div>
                    	<div class="div-row">
                        	<div class="div-link">
                            	<a href="#" id="forgot-link">Forgot Password?</a>
                            </div>
                        </div>
			   </div>
                <!-- Middle Ends -->                
                <div id="footer">
                </div>
            </div>
        </div>
       	<!-- Login Outer Ends -->
    </div>
    <!-- Main Container Ends -->
    
    
    <!-- Forgot Pop-up Starts -->
    <div id="popup-container">
    	<div id="popup-inner">
        	<div id="top-bar">
	            <div id="forgot-label">Forgot Password ?</div>
            	<div id="popup-cross"><img src="../Images/admin/cross.png" /></div>
        	</div>
			 <!-- Forgot Pop-up Middle Starts -->
           <div id="popup-middle">
           		<div class="div-row">
                	<h3 class="mg-left10">Please enter code and reset your password...</h3>
                </div>
           		<div class="div-row mg-top10">
                	<div class="div-text mg-left100"><input class="popup-txtBox" type="text" placeholder="Code" /></div>
                </div>
           		<div class="div-row mg-top10">
                	<div class="div-text mg-left100"><input class="popup-txtBox" type="text" placeholder="New Password" /></div>
                </div>
           		<div class="div-row mg-top10">
                	<div class="div-text mg-left100"><input class="popup-txtBox" type="text" placeholder="Confirm Password" /></div>
                </div>
                <div class="div-row mg-top20">
                  	<div class="div-btn"><button class="btn" type="button" >UPDATE</button></div>
                    <div class="div-btn">
                   	    <button id="btnCancel" class="btn" type="button" >CANCEL</button></div>
            	</div>
           </div>
			<!-- Forgot Pop-up Middle Starts -->

		</div>
    </div>
    <!-- Forgot Pop-up Ends -->
</body>
</html>
