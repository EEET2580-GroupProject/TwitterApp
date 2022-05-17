
<style>
    body{
        -ms-overflow-style: none;
        scrollbar-width: none;
        overflow-y: scroll;
        margin:0px;
        padding: 0px;;
        font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    body::-webkit-scrollbar {
        display: none;
    }
    #logo-container{
        display: inline-block;
    }
    .logo{
        top:10px;
        width: 60px;
        mix-blend-mode: darken;
    }
    #logo2{
        width: 100px;
    }
    #nav-bar{
        display: inline-block;
        bottom:10px;
        margin-left:10%;
        margin-right: auto;
        margin-top: 20px;
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
<div id="header-container">
            <div id="logo-container"><img id="logo" class="logo" src="../images/Logo/Tau.png" alt="Logo">
                <img id="logo2" class="logo" src="../images/Logo/logo2.png" alt="logo2"></div>
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
</div>