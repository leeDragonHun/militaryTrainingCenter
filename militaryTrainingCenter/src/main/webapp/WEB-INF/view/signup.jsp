<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	이력서나 프로젝트Readme에 기술을 적는 란이 항상 있는데 흔하게 AJAX와 JSON등과 같은 것을 기재한다. 
	그런데 그게 뭔지도 모르고 써넣기만 하면 질문이 들어왔을 때 꿀먹은 벙어리가 될 것 같았다.
	평생을 해도 그 기술을 마스터 할 수 없지만 기본 개념은 알아야 한다. 
	예를들어 파싱에 대해 기초적인 것을 물어봤을 때 제대로 대답을 못 하면 우리 과정에서 주력으로 배운 JAVA에 대한 기초도 의심이 갈 것이다. ('아니 이 기술 썼다며...?' 라는 생각)
	
	지금 할 것은 이거다. '데이터 요청 -> AJax API <-REST API (어노테이션@RestController)'

	1. 서버(지금 쓰는 것으로 말해보자면 apache사의 tomcat) : 클라이언트가 JSP페이지를 요청하면 톰캣 서버는 jsp파일을 서블릿으로 변환한다. 
	이 과정에서 jsp파일 내의 자바 코드가 실행된다. 변환된 서블릿은 자바 클래스로 컴파일 된다. 컴파일된 서블릿이 실행되고, 자바코드가 수행된다.
	서블릿은 실행 결과를 HTML 형식으로 생성한다. 생성된 HTML을 클라이언트로 전송한다. 
	  * 서블릿이란? 자바 웹 애플리케이션에서 동적인 웹 페이지를 생성하기 위한 자바 클래스이다. 클라이언트가 서버에 요청을 보내면, 서블릿 컨테이너(톰캣)는 이 요청을 받아 해당 요청을 처리할 서블릿을 호출한다.
	  쉡게 말해 서블릿은 클라이언트의 요청을 처리하고 응답을 생성하는 자바 프로그램인 것이다.
	
	2. 클라이언트(지금 쓰는 건 Chrome이라는 브라우저) : 위의 HTML을 해석한다. 그리고 다른 자원들과 결합하여 최종 웹페이지를 '렌더링'한다.
	  * 렌더링이란? 브라우저가 HTML, CSS 파일을 해석하고 이를 시각적으로 표시하는 과정이다.(JavaScript도 해석한다.)
	    
	    렌더링이라는 것을 할 때에 '해석'을 한다고 했다.
	    HTML에 대한 해석을 하고서는 DOM(Document Object Model)이라는 트리를 만든다. 이것은 웹페이지의 구조와 내용을 나타내는 트리구조이다. 
	    개발공부를 처음 접할 때 유튜브 등에서 '프론트엔드와 백엔드' 설명을 찾아보았다면 HTML은 '틀, 뼈대'이다 라는 말을 많이 들어보았을 것이다.
	    CSS에 대한 해석을 하고서는 CSSOM(CSS Object Model)트리를 생성한다. 이는 스타일 정보를 포함한다.
	    
    3. JavaScript : 이렇게 만들어진 DOM과 CSSOM을 조작하거나 업데이트한다. 그리고 사용자와의 상호작용을 처리하여 동적인 콘텐츠를 로드하는 역할이다.
    				HTML하고 CSS가 정적이라면 이 파싱된 것을 가지고 클라이언트의 조작에 맞추어 상호작용을 해서 브라우저에 보여줄 결과를 다르게 만드는 JavaScript는 동적이라고 할 수 있다.
	  * 파싱이란? 데이터를 특정한 구조로 분석하고 해석하는 과정이다.    
	    
	    렌더링에 관한 얘기를 하면 파싱했다. 파싱한다. 하는데 HTML파싱은 앞서말한 DOM을 형성하는 것이고, CSS파싱은 SSCOM을 형성하는 것,
	    JavaScript의 파싱은 DOM과 SSCOM 등을 읽어들여 이를 이해하고 실행할 준비를 하는 것이다.
	    브라우저는 이렇게 준비된 자바스크립트 코드를 최종 실행하여 화면에 최종적인 모습을 나타낸다.
	    공부할 때 어원으로 보면 1차원적으로 이해하기 편한 것 같다. 파싱은 parsing. pars에서 유래하여 부분, 조각을 의미한다. 
	    데이터를 더 작은 부분으로 나누고, 이를 분석하여 구조적 관계를 파악하고, 이해 및 변환하는 과정으로 해석된다.
	    
	4. 이번 과제의 동작 알고리즘을 표현하자면 다음과 같다. '데이터 요청 -> AJax API <-REST API (어노테이션@RestController)'
	
	먼저 클라이언트가 데이터를 요청한다. 처음 웹 페이지에 접속할 때 요청될 수도 있는 것이고, 클릭같은 이벤트로 요청할 수도 있는 것이다.
	데이터를 요청할 때 AJAX를 사용하여 주로 JSON 형식으로 비동기적으로 서버에 요청을 보낸다고 한다. 갑자기 모르는 말이 우수수 나왔다.
	  * AJAX : Asynchronous JavaScript and XML의 줄임말이다. 비동기식 자바스크립트와 XML의 약자이다. 페이지를 새로 고침 하지 않고서도 서버와 통신할 수 있게 해준다.
	  * 비동기식 : 영어로는 Asynchronous. (확실히 영단어를 많이 알면 개발공부에 용이하다.) 컴퓨팅에서 두 개 이상의 작업이 서로 독립적으로 실행되며, 한 작업이 다른 작업의 완료를 기다리지 않는다는 의미이다.
	  동기식과 비교하여 더 쉽게 말해보자면 손님A가 주문하면, 그 주문을 받고 요리사가 요리를 만들고 손님 A가 음식을 받는다, 이게 완료된 후에 그다음 B손님이 주문하고 요리사가...
	  비동기식은 손님 A가 주문하면 홀직원이 주문을 받아 요리사가 요리를 하는 동안에 손님 B의 주문도 받을 수 있고 B의 요리도 동시에 준비될 수 있다. 이게 비동기 식이다.
	  * XML : XML은 데이터를 정의하는 규칙을 제공하는 마크업 언어페이지다. 우리가 사용하는 마이바티스도 .xml파일을 쓴다.
	    초기에는 xml페이지로 데이터를 전달했기에 AJAX라는 단어에 xml이 들어간것이고 요즘은 주로 JSON방식으로 데이터를 전달한다.
	  * JSON : 데이터를 표현하기 위한 특정한 형식이다. (JavaScript Object Notation) 얘는 데이터를 저장하거나 전송하기 위한 경량의 데이터형식으로 사람이 읽/쓰기도 현하고 기계가 분석/생성하기도 편하다.
	  간단하고 명확한 이 JSON 문법을 가지고 클라이언트가 데이터를 서버에 보내고 서버는 데이터를 클라이언트에게 반환한다.
	  {
		  "name": "John Doe",
		  "age": 30,
		  "email": "john.doe@example.com",
		  "friends": ["Jane", "Mark", "Emily"],
		  "address": {
			  "street": "123 Main St",
			  "city": "Anytown"
		  }
	  } 이런식으로 쓰인다. 객체는 중괄호'{}'로 둘러 싸이고, 배열은 대괄호 '[]'로 둘러 쌓인다.
	  
	  5. REST API : REST아키텍처 스타일을 따르는 API라는데. 우리가 쓸 어노테이션 RestController도 REST API중 하나이다. 이 방식을 이해하면 편하다.
	  이미 알고쓰던 @Controller는 전통적인 MVC 패턴에서 사용되어 View를 반환하거나 데이터를 제어한다. 
	  @RestController는 웹 서비스에서 JSON 또는 XML을 직접 반환하여 클라이언트와의 상호 작용을 한다.
	  브라우저에서 와닿기로는 새로운 페이지로 넘어가는 대신, 현재 페이지에서 비동기적으로 데이터를 요청하고 받을 수 있다는 것이다.
	  주요 포인트는 비동기식 데이터 요청! 데이터 반환 형식 JSON으로 동적페이지 업데이트! 페이지의 이동이 없다! 정도가 되겠다.
	  
	  ★ 위의 내용을 보고 이해한 내용을 바탕으로 아래의 한줄 설명을 다시 생각해보고 넘어가야겠다.
	      '데이터 요청 -> AJax API <-REST API (어노테이션@RestController)'
-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>입교신청</title>
    <!-- jquery CDN -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script>
	//웹페이지가 다 로드된 후에 작업하겠다는 코드.
	$(document).ready(function() {
		// 화면이 처음 로드 되면 군번란에 커서가 가게.
		// 앞으로 #방식의 아이디를 확인하며 코드를 칠텐데, 스크롤을 왔다갔다 하기 불편하다면 ctrl+shift+'{' or '-' 이 단축키를 이용해 현재페이지의 화면 분할을 할 수 있다.
		$('#armyNumber').focus();
		
		// 입교신청 버튼을 눌렀을 때의 유효성 검사
		$('#signupBtn').click(function(){
			// 군번 중복조회 검수 받았는지 유효성검사		
			if($('#hiddenArmyNumber').val().length < 1){ // 장교군번 8자리, 부사관 9, 용사 11
				$('#armyNumberMsg').text('중복조회를 통해 군번을 검수해 주십시오.');  
				$('#armyNumber').focus();
				return;
			}else{
				$('#armyNumberMsg').text('');  
			}
			
			// 비밀번호 4자리 이상 유효성 검사
			if($('#password').val().length < 4 ){
				$('#passwordMsg').text('비밀번호를 4자리 이상 입력해주십시오.');
				$('#password').focus();
				return;
			}else{
				$('#passwordMsg').text('');
			}
			
			// 비밀번호 확인란이 비밀번호와 다를 때에 대한 유효성 검사
			if($('#passwordCheck').val() != $('#password').val()){
				$('#passwordCheckMsg').text('비밀번호가 다릅니다. 다시 확인해 주십시오.');
				$('#passwordCheck').focus();
				return;
			}else{
				$('#passwordCheckMsg').text('');
			}
			
			// 계급 유효성 검사
			if($('#militaryRank').val().length < 2){
				$('#militaryRankMsg').text('계급을 기재해 주십시오.');
				$('#militaryRank').focus();
				return;
			}else{
				$('#militaryRankMsg').text('');
			}
			
			// 이름 유효서 검사
			if($('#name').val().length<2){
				$('#nameMsg').text('이름을 명확히 기재해 주십시오.');
				$('#name').focus();
				return;
			}else{
				$('#nameMsg').text('');
			}
			
			// return;을 한번도 만나지 않으면(모든 유효성 검사에 else이면), 드디어 값을 보낸다.
            $.ajax({
                url: '/militaryTrainingCenter/signup',
                method: 'POST',
				// serialize()는 jQuery에서 제공하는 메서드이다. html 폼 요소를 문자열로 직렬화하여 서버에 전송한다. 우리가 원래 하던 submit기능과 비슷하다.
				// (#signup은 form태그의 id임)
                data: $('#signup').serialize(),
                success: function(response) {
                    // 서버로 부터 받은 response라는 값이 문자열 success와 완전히 동일한지 본다.
                    // Controller에서 회원가입 성공시 int값이 0보다 큰걸 반환하면 success라는 String을 반환하게 해놓았기 때문이다.
                    // 즉 이 if문은 회원가입 성공/실패 분기문이다.
                	if (response === "success") {
                        // 이 코드는 현재 브라우저 창의 URL을 변형하는 것이다.
                        // 원래 회원가입 폼의 유효성검사를 지나 submit되게 하는 거였는데, 회원가입이 완료되면 훈련소페이지로 넘어가게 하기 위해 이방법을 써봤다. 
                		window.location.href = '/militaryTrainingCenter/training.html';
                    } else {
                        alert('입교 신청에 실패하였습니다. 다시 시도해 주십시오.');
                    }
                },
                // 아래 코드는 AJAX 요청이 실패한다면 실행이 된다. 실패이유를 console에 찍어주어 고장배제를 할것이다.
                // 여기에서 모르는 단어가 많이 나오는데... 먼저 xhr은 XMLHttpRequest라는 것의 객체로 서버와의 상호작용을 가능하게 한다. 여기에 요청상태, 응답데이터, 상태 코드가 다 담겨있다.
                // 예를들어 바로 지금 쓰이는 status는 HTTP 상태 코드를 반환해주어 요청이 왜 실패했는가를 내가 알 수 있다. 
                // error은 에러 자체가 무슨 오류인지 오류의 종류를 설명한다. 이것들을 최종 콘솔에 담아서 확인하려는 것이다.
                error: function(xhr, status, error) {
                    console.error('Error:', status, error);
                }
            });
		})
	});
    </script>
</head>
<body>
	<h1>입교신청</h1>
	<table>
		<!-- 일부러 form밖으로 빼서 중복확인이 완료되면 form안에 hidden으로 들어가게 할 것이다. -->
		<tr>
			<td>
				군번
			</td>
			<td>
				<input type="text" name="armyNumber" id="armyNumber" class="btn btn-outline-success">
				<button type="button" id="armyNumberCheckBtn" class="btn btn-outline-success">중복검사</button>
				<span id="armyNumberMsg"></span>
			</td>
		</tr>
		
		<form method="post" id="signup" action="/militaryTrainingCenter/signup">
		<input type="hidden" name="hiddenArmyNumber" id="hiddenArmyNumber">
		<tr>
			<td>
				비밀번호
			</td>
			<td>
				<input type="password" name="password" id="password" class="btn btn-outline-success">
				<span id="passwordMsg"></span>
			</td>
		</tr>
		<tr>
			<td>
				비밀번호확인
			</td>
			<td>
				<input type="password" name="passwordCheck" id="passwordCheck" class="btn btn-outline-success">
				<span id="passwordCheckMsg"></span>
			</td>
		</tr>
		<tr>
			<td>
				계급
			</td>
			<td>
				<input type="text" name="militaryRank" id="militaryRank" class="btn btn-outline-success">
				<span id="militaryRankMsg"></span>
			</td>
		</tr>
		<tr>
			<td>
				이름
			</td>
			<td>
				<input type="text" name="name" id="name" class="btn btn-outline-success">
				<span id="nameMsg"></span>
			</td>
		</tr>
		<tr>
			<td>
				<button type="button" id="signupBtn" class="btn btn-outline-success">입교신청</button>
			</td>
			<td>
			</td>
		</tr>
	</table>
	</form>
	
	<script>
		// 군번 유효성검사 + 군번 중복조회
		// 사용가능한 군번 -> readonly처리
		// 이미 가입된 군번 -> alert 창 띄운 후 군번 input에 focus
		$('#armyNumberCheckBtn').click(function(){
			// 군번이 빈칸으로 중복조회를 누르면 나오는 메세지
			if($('#armyNumber').val()==''){
				alert('군번을 입력 하시고 중복확인을 눌러 주십시오.');
				$('#armyNumber').focus();
				return;
			
			// 군번이 8자리 미만인데 중복조회를 눌렀을 때의 메세지
			}else if($('#armyNumber').val().length < 8){ 
				$('#armyNumberMsg').text('군번을 8자리 이상 입력해주십시오.');  
				$('#armyNumber').focus();
				return;
			
			// 군번 중복조회를 통과하면 hidden에 군번 넣기
			}else{
				$('#armyNumberMsg').text('입교 가능합니다.'); 
				$('#hiddenArmyNumber').val($('#armyNumber').val());
			}
			
			// input type hidden에 잘 들어갔나 디버깅
			console.log('hiddenArmyNumber : ',$('#hiddenArmyNumber').val());
			
			// '데이터 요청 -> AJax API <-REST API'
			$.ajax({
			    // 클라이언트가 이 URL로 요청을 보내면 서버에서 해당 URL을 처리하는 로직이 실행된다.
			    // 일반적으로 서버는 이 URL을 받아서 클라이언트가 전송한 데이터를 처리하고, 그에 대한 응답을 반환한다.
				url:'/militaryTrainingCenter/armyNumberCheck',
				// HTTP 요청 메서드로, 이 경우 POST 방식을 사용하여 서버에 데이터를 전송하는 것임.
				method:'post',
				// 요청 시 함께 서버에 전송할 데이터임. 여기서는 armyNumber라는 키에 해당하는 값으로(이 키는 지금 내가 정한거다), '#armyNumber'라는 HTML 요소에 있는 값을 사용.. 즉, 사용자가 입력한 id 값을 서버로 전송함.
				data : {'armyNumber':$('#armyNumber').val()},
				// AJAX 요청이 성공했을 때 실행될 콜백 함수임. 서버로부터의 응답 데이터가 매개변수 json으로 전달된다.
				// json방식으로 많이 주고 받고 하다보니 매개변수 이름을 json이라고 정했을뿐이다.
				success:function(json){
					console.log('json : ',json);
					if(json == 0) {
						// #armtNumber 인 html요소에 readonly요소를 주고 true로 설정한다.
						$('#armyNumber').prop('readonly', true);
					} else {
						alert('이미 가입하셨던 군번입니다. 교육사령부 인사처에 문의하세요.');
						$('#armyNumber').focus();
					}
				}
			})
		})
	</script>
</body>
</html>