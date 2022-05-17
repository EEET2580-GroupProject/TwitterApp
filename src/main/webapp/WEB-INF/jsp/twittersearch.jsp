<!DOCTYPE html>
<html>
<head>
    <title>Twitter Api Test</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script>
        function changeToRecentTab(){
            document.getElementById("lookup-search-tab").style.display = "none";
            document.getElementById("advanced-search-tab").style.display = "none";
            document.getElementById("recent-search-tab").style.display = "block";
            let recentStyle = document.getElementById("recent-tweet").style;
            let lookupStyle = document.getElementById("look-up-tweet").style;
            let advancedStyle = document.getElementById("advanced-tweet").style;
            recentStyle.backgroundColor = "#525E75";
            recentStyle.color = "white";
            lookupStyle.backgroundColor = "rgba(255, 255, 255, 0.5)";
            lookupStyle.color = "black";
            advancedStyle.backgroundColor = "rgba(255, 255, 255, 0.5)";
            advancedStyle.color = "black";
        }
        function changeToLookupTab(){
            document.getElementById("lookup-search-tab").style.display = "block";
            document.getElementById("advanced-search-tab").style.display = "none";
            document.getElementById("recent-search-tab").style.display = "none";

            let recentStyle = document.getElementById("recent-tweet").style;
            let lookupStyle = document.getElementById("look-up-tweet").style;
            let advancedStyle = document.getElementById("advanced-tweet").style;
            recentStyle.backgroundColor = "rgba(255, 255, 255, 0.5)";
            recentStyle.color = "black";
            lookupStyle.backgroundColor = "#525E75";
            lookupStyle.color = "white";
            advancedStyle.backgroundColor = "rgba(255, 255, 255, 0.5)";
            advancedStyle.color = "black";
        }
        function changeToAdvancedTab(){
            document.getElementById("lookup-search-tab").style.display = "none";
            document.getElementById("advanced-search-tab").style.display = "block";
            document.getElementById("recent-search-tab").style.display = "none";
            let recentStyle = document.getElementById("recent-tweet").style;
            let lookupStyle = document.getElementById("look-up-tweet").style;
            let advancedStyle = document.getElementById("advanced-tweet").style;
            recentStyle.backgroundColor = "rgba(255, 255, 255, 0.5)";
            recentStyle.color = "black";
            lookupStyle.backgroundColor = "rgba(255, 255, 255, 0.5)";
            lookupStyle.color = "black";
            advancedStyle.backgroundColor = "#525E75";
            advancedStyle.color = "white";

        }
    </script>
    <style>
        #term-field{
            box-sizing: border-box;
            height: 35px;
            font-size: 17px;
            border: 0px;
            outline: none;
            width: calc(100% - 65px);
            margin-top: 1px;
        }
        #tag:focus{
            outline: none;
        }
        #icon{
            padding: 10px;
        }
        #button-box{
            text-align: center;
            padding-top: 10px;
        }
        #box-around-input{
            background-color: white;
            white-space:nowrap;
            border: 1px solid black;
            border-radius: 20px;
            box-sizing: border-box;
            width: 80%;
            height: 40px;
            margin-left: auto;
            margin-right: auto;
        }
        #tag{
            border-radius: 10px;
            border: solid 1px;
            display: block;
            margin-left: auto;
            margin-right: auto;
            margin-top: 10px;
        }

        #main-items{
            text-align: center;
        }
        #advanced-search-button{
            background-color: #B7CADB;
            border: solid 0px black;
        }

        #advanced-search-button:hover{
            background-color: #4B6587;
            text-decoration: white;
        }
        .button-ele{
            background-color: #FCFFE7;
            border-radius: 5px;
            border: solid 0px;
            margin-left: 15px;
            padding: 5px;
            font-style: italic;
        }
        .button-ele:hover{
            background-color: #CE9461;
        }
        #search-container{
            background-color: #F0E5CF;
            height: 100vh;
            position: relative;
        }
        #advanced-container{
            margin-top: 10px;
            width: fit-content;
            margin-left: auto;
            margin-right: auto;
        }
        #main-image{
            height: auto;
            width: 300px;
            mix-blend-mode: darken;
            border-radius: 20px;
        }
        #main-image-container{
            margin-bottom: 50px;
            width: fit-content;
            margin: auto;
        }
        #advanced-search-tab, #recent-search-tab, #lookup-search-tab{
            background-color: #C8C6C6;
            border-radius: 0px 10px 10px 10px;
            border: solid 1px black;
            width: 100%;
            margin: auto;
            height: calc(50vh - 10px);
        }
        #main-items{
            margin-top: 10px;
        }
        #tab-list{
            text-align: left;
        }
        .tabs{
            display: inline-block;
            background-color: #525E75;
            color: white;
            font-weight: bold;
            padding: 10px;
            border-radius: 5px 5px 0px 0px;
        }
        div[id="recent-tweet"], div[id="advanced-tweet"]{
            background-color: rgba(255, 255, 255, 0.5);
            color: black;
        }
        div[id="recent-tweet"]:hover, div[id="advanced-tweet"]:hover{
            background-color: #525E75;
            color: white;
        }
        #nortification{
            width: fit-content;
            margin: auto;
        }
        #tabs-container{
            width: 80%;
            margin: auto;
        }
        #query-label{
            display: block;
        }
        body{
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
    </style>
</head>
<body>
<header class="imageheader">
    <jsp:include page="../statichtml/header.jsp"/>
</header>
<main>
    <div id="search-container">
        <div id="main-image-container" class="main-ele"><img id="main-image" class="ele" src="../images/background/Waston.png" alt="Google" height="92"></div>
        <div id="tabs-container">
            <div id="tab-list">
                <div id="look-up-tweet"class="tabs" onclick="changeToLookupTab()">Look up</div>
                <div id ="recent-tweet"class="tabs" onclick="changeToRecentTab()">Recent</div>
                <div id= "advanced-tweet" class="tabs" onclick="changeToAdvancedTab()">Advanced</div>
            </div>
            <div id="lookup-search-tab">
                <div id="main-items">
                    <form id="lookup-form" method="get" action="/twitter/lookupTweet">
                        <div class="main-ele">
                            <div id="box-around-input">
                                <i id="icon" class='fa-solid fa-magnifying-glass'></i>
                                <input id="term-field" type="text" name="q-ids" placeholder="Tweet IDs">
                            </div>
                        </div>
                    </form>
                    <div>
                        <div id="button-box">

                            <button class="button-ele" form="lookup-form" >Look up tweets</button>
                        </div>
                    </div>
                </div>
                <div id="nortification">
                    <span id="query-label">${query}</span>
                    <span>${report}</span>
                </div>
            </div>

            <jsp:include page="../statichtml/recentTab.jsp"/>
            <jsp:include page= "../statichtml/advancedTab.jsp"/>

        </div>
    </div>
</main>
</body>
</html>