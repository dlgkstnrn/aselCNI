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

//소분류로 가져온 애들로 이제 리스트 만들어주자 ajax
// 소분류 선택 시 실행되는 이벤트 핸들러
$('#smlType').on('change', function(event) {
    const sml_no = $(this).val(); // 선택된 소분류 번호 가져오기
	const mid_no = $(this).find(':selected').data('mid-no');
    const big_no = $(this).find(':selected').data('big-no');

    if (!sml_no) {
        alert("소분류를 선택해주세요.");
        return;
    }

    // AJAX 요청을 통해 선택된 소분류에 해당하는 데이터 불러오기
    $.ajax({
        type: 'GET',
        url: '/getItemsBySmlType', // 서버의 해당 소분류 데이터를 불러오는 엔드포인트
        data: {
            sml_no: sml_no, // 전송할 데이터 (여기서는 선택된 소분류 번호)
            mid_no : mid_no,
            big_no: big_no

        },
        success: function(response) {
            // 테이블에 데이터 채우기
            fillTableWithItems(response);
            updateTable(response);
        },
        error: function() {
            alert("데이터를 불러오는데 실패했습니다.");
        }
    });
});

// 테이블에 데이터를 채우는 함수
function fillTableWithItems(items) {
    const tableBody = $('#jajeTable tbody');
    tableBody.empty(); // 테이블의 이전 내용을 비우기

    // 불러온 데이터로 테이블 행 생성
    items.forEach(function(item) {
        const row = `
            <tr>
                <td><input type="checkbox" id="itemSelect${item.cust_cd}" name="itemSelect"></td>
                <td>${item.cust_cd}</td>
                <td>${item.item_nm}</td>
                <td>${item.item_spec}</td>
                <td>${item.item_unit}</td>
                <td><input type="number" value="${item.quantity}" min="1"></td>
                <td>${item.item_cost}원</td>
            </tr>
        `;
        tableBody.append(row);
    });
}


/*
//모달에서 저장을 누르면 임시로 저장이 되고, 발주등록 폼으로 데이터를 넘기면서 table을 만들어주는 코드
let tempItems = []; // 임시 저장할 배열

// 모달에서 '저장' 버튼 클릭 시 실행되는 함수
function onSaveModal() {
    // 선택된 아이템 정보와 수량을 객체로 생성
    let selectedItem = {
        custCd: $('#custCd').val(),
        itemName: $('#itemName').val(),
        spec: $('#spec').val(),
        unit: $('#unit').val(),
        quantity: $('#quantity').val(),
        cost: $('#cost').val()
    };

    // 임시 배열에 추가
    tempItems.push(selectedItem);

    // 다른 폼의 테이블을 업데이트하는 함수 호출
    updateFormTable();
}


// 다른 폼의 테이블을 업데이트하는 함수
function updateFormTable() {
    const tableBody = $('#anotherFormTable tbody');
    tableBody.empty(); // 기존 내용을 비우기

    // 임시 배열에 저장된 아이템으로 테이블 행 생성
    tempItems.forEach(function(item, index) {
        const row = `
            <tr>
                <td>${index + 1}</td>
                <td>${item.custCd}</td>
                <td>${item.itemName}</td>
                <td>${item.spec}</td>
                <td>${item.unit}</td>
                <td>${item.quantity}</td>
                <td>${item.cost}</td>
            </tr>
        `;
        tableBody.append(row);
    });
}

// 최종 '저장' 버튼 클릭 시 서버에 데이터 전송
function onFinalSave() {
    $.ajax({
        type: 'POST',
        url: '/saveItems', // 서버의 데이터 저장 엔드포인트
        contentType: 'application/json',
        data: JSON.stringify(tempItems),
        success: function(response) {
            // 성공 처리 로직
        },
        error: function() {
            // 오류 처리 로직
        }
    });
}
*/




