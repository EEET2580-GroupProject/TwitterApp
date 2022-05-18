<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <style>
        #login-container{
            width: fit-content;
            margin: auto;
            text-align: center;
            border: solid 1px black;
            border-radius: 10px;
            padding: 10px;
            background-color: #5e6982;
            color: #F0E5CF;
            height: 30vh;
        }
        main{
            background-color: #ae8968;
            height: 75vh;
            padding-top: 15vh;
        }
    </style>
</head>
<body>
<header id="home" class="header">
    <jsp:include page="../statichtml/header.jsp"/>
</header>
<main>
    <div id="login-container">
        <h1>A Request Took took long, Please try again in few minutes</h1>
        <a href="/twitter">Back to Twitter Search</a>
    </div>
</main>

<footer class="footer">

</footer>

</body>
</html>