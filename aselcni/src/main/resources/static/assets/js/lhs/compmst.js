const extenReg = /.+\.(jpeg|jpg|png)/;

$("#comp_file").change(function(event){
	console.log($(this).val());
	if($(this).val().match(extenReg)){
		console.log("dddd");
		if(this.files[0]){
			let reader = new FileReader();
			reader.onload = function(event){
				document.getElementById('pic_preview').src = event.target.result;
			};
			reader.readAsDataURL(this.files[0]);
		}else{
			alert("파일선택해주세요");
			document.getElementById('joinPicture').src = "";
		}
	}else{
		alert('이미지파일을 선택해주세요');
		this.value='';
	}
})