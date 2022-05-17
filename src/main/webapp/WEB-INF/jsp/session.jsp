<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Personal CV</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer">
    <meta charset="utf-8">
    <meta name='author' content='Minh'>
    <meta name="description" content="This is my a website for showcasing my skills">
    <style>
        body{
            -ms-overflow-style: none;
            scrollbar-width: none;
            overflow-y: scroll;
            margin:0px;
            padding: 0px;;
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body::-webkit-scrollbar{
            display: none;
        }
        #welcome-cover{
            text-align: center;
            background-color: rgb(242, 221, 193);
            position: relative;
            background-repeat: no-repeat;
            background-position: center center;
            background-size: cover;
            height: 90vh;
        }
        .image-welcome-cover{
            position: absolute;
            margin:auto;
            mix-blend-mode: darken;
        }
        #sherlock{
            width: 500px;
            bottom: 0;
            left:0;
            right:0;
        }
        #hat{
            width: 150px;
            top: 10px;
            left:0;
            right:0;

        }
        #gun{
            width: 200px;
            top: 30vh;
            left: 10%;
        }
        #magnifier{
            width: 120px;
            top: 30vh;
            right:10%;
            transform: rotate(-20deg);
        }
        #text-welcome-cover{
            position: relative;
            top: 150px;

            font-style: italic;
            font-weight: 200;
            font-size: 48px;
        }
        .icon-container{
            background-color: white;
            position: relative;
            top: 180px;
            margin-right: 10px;
            border-radius: 15px;
        }
        .icons{
            width: 60px;
            display: block;
            padding-top: 10px;
            padding-bottom: 10px;
            padding-left: 5px;
            padding-right: 5px;
        }
        #reddit-icon, #google-icon, #crypto-icon{
            padding-top: 4px;
            padding-bottom: 4px;
        }
        #logo-container{
            display: inline-block;
        }
        .logo{
            position: relative;
            top:10px;
            width: 60px;
            mix-blend-mode: darken;
        }
        #logo2{
            width: 100px;
        }
        #nav-bar{
            position: relative;
            display: inline-block;
            bottom:10px;
            margin-left:10%;
            margin-right: auto;
        }
        .nav-items{
            margin-left: 100px;
        }
        li{
            display: inline-block;
        }
        ul{
            margin:0px;
            padding: 0px;
        }
        header{
            background-color: rgb(254, 242, 227);
            height: 80px;

        }
        #header-container{
            height: 80px;
            white-space: nowrap;
            overflow: hidden;
        }
        #login-link a{
            font-size: 25px;
        }
        a{
            text-decoration: none;
            color: black;
            font-size: 20px;
        }
        #user-icon{
            font-size: 30px;
            margin-right: 10px;
        }
    </style>
    <script>

    </script>
</head>
<body>
<header>
    <div id="header-container">
        <div id="logo-container"><img id="logo" class="logo" src="images/Logo/Tau.png" alt="Logo">
            <img id="logo2" class="logo" src="images/Logo/logo2.png" alt="logo2"></div>
        <div id="nav-bar">
            <nav>
                <ul id="nav-list">

                    <li class="nav-items"><a href="">Workspace</a></li>
                    <li class="nav-items"><a href="">Contact</a></li>
                    <li class="nav-items"><a href="">About</a></li>
                    <li id="login-link" class="nav-items">WELCOME ${username}<i id="user-icon" class="fa-solid fa-circle-user"></i><a href="/logout">Logout</a></li>
                </ul>
            </nav>
        </div>
    </div>
</header>
<main>
    <section id="welcome-cover">

        <div id="text-welcome-cover"><span>PICK YOUR POISION</span></div>
        <img id="sherlock" class="image-welcome-cover" src="images/background/Sherlock.png" alt="Sherlock Holmes">
        <img id="hat" class= "image-welcome-cover" src="images/background/Hat.png" alt="Hat">
        <img id="gun" class= "image-welcome-cover" src="images/background/Gun.png" alt="Gun">
        <img id="magnifier" class= "image-welcome-cover" src="images/background/magnifier.png" alt="Magnifier">

        <div >
            <nav>
                <ul>
                    <li class="icon-container"><a href="/twitter">
                        <div><img id = "twiter-icon"class="icons" src="images/Icons/Twitter.png" alt="Twitter icon"></div>
                    </a></li>
                    <li class="icon-container"><a href="/reddit">
                        <div><img id = "reddit-icon"class ="icons" src="images/Icons/Reddit.jpg" alt="Twitter icon"></div>
                    </a></li>
                    <li class="icon-container"><a href="">
                        <div><img id = "google-icon" class ="icons" src="images/Icons/Google.png" alt="Twitter icon"></div>
                    </a></li>
                    <li class="icon-container"><a href="">
                        <div><img id = "crypto-icon" class ="icons" src="images/Icons/btg.png" alt="Twitter icon"></div>
                    </a></li>
                </ul>
            </nav>
        </div>
    </section>
</main>

<footer>
    <div>All right reserved 2022</div>
    <div id="footer-container">
        <nav>
            <ul id="contact-list">
                <li class="contact-items"><a href="">Facebook</a></li>
                <li class="contact-items"><a href="">Instagram</a></li>
                <li class="contact-items"><a href="">Git</a></li>
            </ul>
        </nav>
    </div>
</footer>
</body>

</html>