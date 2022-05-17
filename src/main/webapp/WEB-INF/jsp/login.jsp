<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>

</head>
<body>
	<header id="home" class="header">

	</header>
	<main>
		<span>Write Login page here</span>
		<form:form action="/loginuser" method="post" modelAttribute="login">
			<label>Username</label> <form:input type="text" path="username"/><br />
			<label>Password</label> <form:input type="password" path="password"/><br />
			<input type="submit" value="Login">
		</form:form>
	</main>

	<footer class="footer">

	</footer>

</body>
</html>