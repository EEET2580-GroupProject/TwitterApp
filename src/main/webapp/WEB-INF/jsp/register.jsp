
<!DOCTYPE html>

<html lang="en">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<head>
	<title>Register</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer">
	<meta charset="utf-8">
	<meta name='author' content='Minh'>
	<meta name="description" content="Register page">

	<script>
		let pw_val = true;
		let check_len_pw = true;
		let check_len_fname = true;
		let check_len_lname = true;

		// check password
		function check_pass() {
			document.querySelector("#password").style.borderBottom = "solid 1px #ccc";

			let input_pass = document.getElementById("password").value;
			let confirm_pass = document.getElementById("password-confirm").value;

			let pattern = /^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(.{8,20})$/

			// Check password with regrex
			if(input_pass != "") {
				let valid = pattern.test(input_pass);
				if(valid){
					document.querySelector("#check-valid-pass").innerHTML = "Your Password is valid";
				}else{

					document.querySelector("#check-valid-pass").innerHTML = "Must contain at least 1 lower case letter, 1 upper case letter, 1 digit, and  8 to 20 characters";
				}
			}

			// if rechecking is wrong
			if(input_pass != "" && confirm_pass != ""){
				if(input_pass === confirm_pass){
					document.getElementById("check-password").innerHTML = "Password matches!";
					pw_val = true;
				} else if(input_pass !== confirm_pass) {
					document.getElementById("check-password").innerHTML = "Password doesn't match. Try again.";
					pw_val = false;
				}
			}
		}

		function check_confirm_pass(){
			document.querySelector("#password-confirm").style.borderBottom = "solid 1px #ccc";

			let input_pass = document.getElementById("password").value;
			let confirm_pass = document.getElementById("password-confirm").value;

			// if rechecking is wrong
			if(input_pass != "" && confirm_pass != ""){
				if(input_pass === confirm_pass){
					document.getElementById("check-password").innerHTML = "Password matches!";
					pw_val = true;
				} else if(input_pass !== confirm_pass) {
					document.getElementById("check-password").innerHTML = "Password doesn't match. Try again.";
					pw_val = false;
				}
			}
		}

		// check first name(length)
		function check_fname() {
			document.querySelector("#first-name").style.borderBottom = "solid 1px #ccc";

			let input_fname = document.getElementById("first-name").value;
			let len_fname = document.getElementById("first-name").value.length;

			if(input_fname != "") {
				if(len_fname < 2 || len_fname > 20) {
					document.getElementById("check-fname").innerHTML = "First name must be from 2 to 20 characters.";
					check_len_fname = false;
				} else {
					document.getElementById("check-fname").innerHTML = "Perfect!";
					check_len_fname = true;
				}
			}
		}

		// check last name(length)
		function check_lname() {
			document.querySelector("#last-name").style.borderBottom = "solid 1px #ccc";

			let input_lname = document.getElementById("last-name").value;
			let len_lname = document.getElementById("last-name").value.length;

			if(input_lname != "") {
				if(len_lname < 2 || len_lname > 20) {
					document.getElementById("check-lname").innerHTML = "Last name must be from 2 to 20 characters.";
					check_len_lname = false;
				} else {
					document.getElementById("check-lname").innerHTML = "Perfect!";
					check_len_lname = true;
				}
			}
		}
		function check_file_extention(){
			let valid_extension = [""]
			let image = document.querySelector("#image").value;
			console.log(image.split('.').pop());
		}

		function check_email(){
			document.querySelector("#email-add").style.borderBottom = "solid 1px #ccc";

			let input_email = document.querySelector("#email-add").value;
			//Aligned with RFC 5322
			let pattern = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])")
			// email with regrex
			if(input_email != ""){
				let valid = pattern.test(input_email);
				if(valid){
					document.querySelector("#check_email").innerHTML = "All good to go!";
				}else{
					document.querySelector("#check_email").innerHTML = "Your email is not quite right";
				}
			}
		}


		// if there are any blanks or any invalid information, register will be rejected.
		async function check_signup(event) {
			let input_email = document.getElementById("email-add").value;
			let input_pass = document.getElementById("password").value;
			let confirm_pass =document.getElementById("password-confirm").value;
			let input_fname = document.getElementById("first-name").value;
			let input_lname = document.getElementById("last-name").value;

			if(!input_email || !input_pass ||!confirm_pass || !input_fname || !input_lname) {
				event.preventDefault();
				alert("Fail to register. \nPlease fill in the blanks.");
				if(!input_email){
					document.querySelector("#email-add").style.borderBottom = "solid 1px red";
				}
				if(!input_pass){
					document.querySelector("#password").style.borderBottom = "solid 1px red";
				}
				if(!confirm_pass){
					document.querySelector("#password-confirm").style.borderBottom = "solid 1px red";
				}
				if(!input_fname){
					document.querySelector("#first-name").style.borderBottom = "solid 1px red";
				}
				if(!input_lname){
					document.querySelector("#last-name").style.borderBottom = "solid 1px red";
				}
			}
		}
	</script>
	<style>
		.form-box{
			width: fit-content;
			margin: auto;
			text-align: center;
			border: solid 1px black;
			border-radius: 10px;
			padding: 10px;
			background-color: #5e6982;
			color: #F0E5CF;
		}
		.row{
			width: 100%;
			margin: auto;
		}
		.input-box{
			width: 100%;
		}
		.input-field{
			width: 80%;
		}
		.main-content{
			background-color: #ae8968;
			height: 75vh;
			padding-top: 15vh;
		}
		#to-login{
			color: rgb(46, 197, 184);
		}
	</style>
</head>
<body>
<header>
	<jsp:include page="../statichtml/header.jsp"/>
</header>
<main>
	<div class="main-content">
		<div class="form-box">
			<h2 id="signup_text">Sign Up</h2>
			<form:form method="post" action="/registeruser"  modelAttribute="newuser"> <!-- modelAttribute enable data binding through Spring MVC
				This modelAttribute need default object so the form can render correctly\
				path: is for data binding-->
				<div><label>Email</label></div> <div><form:input path="email" type="text" /> <br/> <form:errors path="email" cssClass="error"/></div>
				<div><label>Username</label></div> <div><form:input path="username" type="text" /> <br/> <form:errors path="username" cssClass="error"/></div>
				<div><label>Password</label></div> <div><form:input path="password" type="password" /> <br/> <form:errors path="password" cssClass="error"/></div>
				<div><label>First Name</label></div> <div><form:input path="firstName" type="text" /></div>
				<div><label>Last Name</label></div> <div><form:input path="lastName" type="text" /></div>
				<div><label>Gender</label></div>
				<form:select path = "gender" items="${returnGenderList}"/>
				<input type="submit" value="Submit" id="submit">
			</form:form>
			<h3>${warning}</h3>
		</div>
	</div>
</main>
<!--footer-->
<footer>

</footer>
</body>