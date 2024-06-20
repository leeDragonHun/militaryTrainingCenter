<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>militaryTrainingCenter</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
	<h1>Military Training Center</h1>
	
	<h2>자격인증평가 요점정리</h2><span>(준비중입니다. 현재는 전투부상자처치만 가능합니다.)</span><br><br>
	
	<table>
		<tr>
			<td>
				<select id="soldierBasicTraining" class="form-select" aria-label="Default select example">
					<option value="">===장병기본훈련 과목 선택===</option>
				</select>
			</td>
			<td>
				<select id="level" class="form-select" aria-label="Default select example">
					<option value="">===단계===</option>
				</select>
			</td>
			<td>
				<select id="process" class="form-select" aria-label="Default select example">
					<option value="">===술기===</option>
				</select>
			</td>
		</tr>
	</table>
	
	
	
	<br><br>
	<div id="details">
	
	</div>
	<div id="ment">
	
	</div>
	
	<script>
		// [장병기본훈련 과목]을 출력
		$.ajax({
			url:'/militaryTrainingCenter/soldierBasicTraining',
			method:'post',
			success:function(subjectName){ // 장병기본훈련 과목들 출력
				console.log('subjectName',subjectName);
				// 쿼리 결과 한 행 마다 select 태그안에 option 넣기
				subjectName.forEach(function(subjectName){
					// append는 추가 라는 뜻
					$('#soldierBasicTraining').append('<option value="'+subjectName+'">' +subjectName+ '</option>');
					
					// n회차 선택 시 내용 요소 지워지게.
					$('#details').empty();
					$('#ment').empty();
				})
			}
		})
		
		// 대분류[장병기본훈련 과목] 선택시 중분류 [단계] 출력
		$('#soldierBasicTraining').change(function(){
			// [장병기본훈련 과목] 미 선택시 바로 리턴으로 빠져 나옴
			if($('#soldierBasicTraining').val() == ''){
				return;
			}
			
			// 대분류[장병기본훈련 과목] 선택시 중분류 [단계] 출력
			$.ajax({
				url:'/militaryTrainingCenter/level',
				method:'post',
				// data -> 여기서 정해진 이름인 'subjectName'을 컨트롤러 메서드의 매개변수로 주는 것이다.
				data:{'subjectName' : $('#soldierBasicTraining').val()},
				success:function(level){ // [단계]을 출력
					console.log('level : ',level)
					
					// n회차 선택 시 <select>의 <option>요소를 지우기 위함.
					$('#level').empty();
					$('#process').empty();
					$('#details').empty();
					$('#ment').empty();
					
					// <select> 최상단에 위치할 내용 추가.(바로위 코드에서 지웠기 때문에 다시 추가해준것임.)
					$('#level').append('<option value="">===단계===</option>');
					$('#process').append('<option value="">===술기===</option>');
					
					// 쿼리 결과 한 행 마다 <select> 태그안에 option 넣기
					level.forEach(function(item){
						$('#level').append('<option value="' + item.levelName + '">' + item.levelName + '</option>');
					})
				}
			})
		});
		
		
		// 중분류인 [단계] 선택 시 소분류인 [술기]를 출력
		$('#level').change(function(){
			// [단계] 미 선택시 바로 리턴으로 빠져 나옴
			if($('#level').val() == ''){
				return;
			}
			
			// 중분류인 [단계] 선택 시 소분류인 [술기]를 출력
			$.ajax({
				url:'/militaryTrainingCenter/process',
				method:'post',
				data:{'levelName' : $('#level').val()},
				success:function(process){ // [술기]를 출력
					console.log('process : ', process)
					
					// n회차 선택 시 <select>의 <option>요소를 지우기 위함
					$('#process').empty();
					$('#details').empty();
					$('#ment').empty();
					
					// <select> 최상단에 위치할 내용 추가.(바로위 코드에서 지웠기 때문에 다시 추가해준것임.)
					$('#process').append('<option value="">===술기===</option>');
					
					// 쿼리 결과 한 행마다 <select> 태그안에 <option> 넣고,
					process.forEach(function(item){
						$('#process').append('<option value="' + item.processName + '">' + item.processName + '</option>');
					})
				}
			})
		})
		
		// 소분류인 [술기] 선택 시 [상세내용]을 출력
		$('#process').change(function(){
			// [술기] 미 선택시 바로 리턴으로 빠져 나옴
			if($('#process').val() == ''){
				return;
			}
			
			// 소분류인 [술기] 선택 시 [상세내용]을 출력
			$.ajax({
				url:'/militaryTrainingCenter/details',
				method:'post',
				data:{'processName' : $('#process').val()},
				success:function(details){ // [상세내용]을 출력
					console.log('details : ', details)
					
					// n회차 선택 시 요소를 지우기 위함
					$('#details').empty();
					$('#ment').empty();
					// 쿼리 결과로 나온 [상세내용을] <div> 태그 안에 넣는다.
					$('#details').append('<textarea rows="5" cols="75" class="btn btn-outline-success" readonly>'+details+'</textarea>');
					$('#ment').append('<span>Thank you for your service.</span>');
				}				
			})
		})
		
	</script>
</body>
</html>