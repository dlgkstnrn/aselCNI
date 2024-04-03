/*
$(document).ready(function() {
    var isLoaded = false; // 데이터가 이미 로딩되었는지 여부를 체크하는 플래그

    $('#BigType').on('focus', function() {
        // 데이터가 이미 로딩되었다면, 추가 로딩을 방지
        if (!isLoaded) {
            $.ajax({
                type: 'GET',
                url: '/modalBig',
                success: function(data) {
					console.log(data);
                    $('#BigType').empty(); // 대분류 셀렉트 박스 비우기
                    $.each(data, function(index, item) {
                        $('#BigType').append($('<option>', {
                            value: item.BIG_NO,
                            text: item.BIG_CONTENT
                        }));
                    });
                    isLoaded = true; // 데이터 로딩 완료 플래그 설정
                },
                error: function() {
                    console.log('Error occurred while loading BigType.');
                }
            });
        }
    });
});
*/

//중분류애들 => 대분류 선택시 값 넘어가는것 + 중분류
$('#BigType').on('change',(event) => {
	console.log(event.target.value);
	const bigType = event.target.value;
	if(bigType==''){
		alert("대분휴 선택해");
		return;
	}
	$.ajax({
		type: 'GET',
		url: '/modalMid',
		data: {
			big_no: bigType
		},
		success: (rsp)=>{
			console.log(rsp);
			$('#midType').empty();
			rsp.forEach((item)=>{
				$('#midType').append(
					`<option value="${item.mid_no}">${item.mid_content}</option>`
				);
			})
			$('#midType').attr('bigNo',rsp[0].big_no);
		}
		
	})
})

//소분류애들 => 중분류 선택시 값 넘어가는것 + 소분류
$('#midType').on('change',(event) => {
	console.log(event.target.value);
	const mid = event.target;
	const mid_no = mid.value;
	//주석처리한게 진형님 코드
	const big_no = mid.getAttribute('bigNo');
	console.log('big_no:',big_no);
    //const big_no = $('#midType').find(':selected').data('big-no');
    
	if(mid_no==null||mid_no==''){
		alert("중분류 선택해");
		return;
	}
	$.ajax({
		type: 'GET',
		url: '/modalSml',
		data: {
			mid_no,
			big_no
		},
		success: (rsp)=>{
			console.log(rsp);
			$('#smlType').empty();
			rsp.forEach((item)=>{
				$('#smlType').append(
					`<option value="${item.sml_no}" data-mid-no="${item.mid_no}" data-big-no="${item.big_no}">${item.sml_content}</option>`
				)
			})
			$('#smlType').attr('bigNo',rsp[0].big_no);
			$('#smlType').attr('midNo',rsp[0].mid_no);
			/*
	컨트롤러에서 받아온 소분류 것 들 smlTypeList ===> 
[	$('#smlType').attr('bigNo',rsp[0].big_no);는 맨 윗줄에 해당하는 sml_no와 mid_no를 가져온거임(박력분)
	CSG_TB_TYPE_SML(sml_no=1, mid_no=3, big_no=1, sml_content=박력분), 
	CSG_TB_TYPE_SML(sml_no=2, mid_no=3, big_no=1, sml_content=중력분), 
	CSG_TB_TYPE_SML(sml_no=3, mid_no=3, big_no=1, sml_content=강력분)
]

			
			*/
			
			
			
			
		}
		
	})
})