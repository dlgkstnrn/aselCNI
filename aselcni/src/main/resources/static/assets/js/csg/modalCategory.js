//대분류애들 선택시에 Cust_cd 가지고 넘어가는 aajx
let custCd = ""; // 전역 변수로 custCd 값을 저장

$(document).ready(function() {
    $('#supplier').on('change', function() {
        custCd = $(this).val(); // 선택된 매입처의 cust_cd 값

        // AJAX 요청 시작
        $.ajax({
            type: 'GET',
            url: '/modalBig', // 대분류 데이터를 조회하는 서버의 URL
            data: { cust_cd: custCd }, // 서버에 전송할 데이터
            success: function(response) {
                // 성공 시 처리 로직
                console.log(response);
                // 예: 대분류 선택을 위한 <select> 태그에 조회된 데이터를 기반으로 옵션 추가
                $('#BigType').empty().append('<option selected="selected" value="">대분류 선택</option>');
                $.each(response, function(i, item) {
                    $('#BigType').append($('<option>', { 
                        value: item.big_no,
                        text : item.big_content 
                    }));
                });
                
                // 매입처 선택 후 비활성화
                $('#supplier').prop('disabled', true);
            },
            error: function(xhr, status, error) {
                // 오류 시 처리 로직
                console.error("Error: " + error);
                alert("대분류 데이터 조회에 실패했습니다.");
            }
        });
        // AJAX 요청 끝
    });
});
/*
//발주등록폼에서 발주담당자를 보여주자 
$(document).ready(function() {
    $('#supplier').on('change', function() {
        var custCd = $(this).val(); // 선택된 매입처의 cust_cd 값

        // 거래처 담당자 정보 조회를 위한 AJAX 요청
        $.ajax({
            type: 'GET',
            url: '/getPurchaseManager', // 거래처 담당자 정보를 조회하는 서버의 URL
            data: { cust_cd: custCd }, // 서버에 전송할 데이터
            success: function(response) {
                // 성공 시 처리 로직
                // 거래처 담당자 정보를 입력 필드에 반영
                $('#manager-name').val(response.CUST_EMP);
            },
            error: function(xhr, status, error) {
                // 오류 시 처리 로직
                console.error("Error: " + error);
                alert("거래처 담당자 정보 조회에 실패했습니다.");
            }
        });
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
			big_no: bigType,
			cust_cd: custCd
		},
		success: (rsp)=>{
			console.log(rsp);
			$('#midType').empty();
			$('#midType').append(
					`<option value="">"중분류를 선택해주세요"</option>`
				);
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
	console.log('mid_no:',mid_no);

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
			big_no,
			cust_cd: custCd
		},
		success: (rsp)=>{
			console.log(rsp);
			$('#smlType').empty();
			$('#smlType').append(
					'<option value="">"소분류룰 선택하세요"</option>'
				)
			rsp.forEach((item)=>{
				$('#smlType').append(
					`<option value="${item.sml_no}" data-mid-no="${item.mid_no}" data-big-no="${item.big_no}">${item.sml_content}</option>`
				)
			})
			$('#smlType').attr('bigNo',rsp[0].big_no);
			$('#smlType').attr('midNo',rsp[0].mid_no);
		}
		
	})
})

//소분류로 가져온 애들로 이제 리스트 만들어주자 ajax
// 소분류 선택 시 실행되는 이벤트 핸들러
let jajeData = {};
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
            big_no: big_no,
			cust_cd: custCd

        },
        success: function(response) {
            if(response == 0) {
				alert('조회가능한 데이터가 없습니다.');
				return;
			}
            
            // 테이블에 데이터 채우기
            fillTableWithItems(response);
        },
        error: function() {
            alert("데이터를 불러오는데 실패했습니다.");
        }
    });
});

// 모달 안의 테이블에 데이터를 채우는 함수
function fillTableWithItems(items) {
    const tableBody = $('#jajeTable tbody');
    tableBody.empty(); // 테이블의 이전 내용을 비우기

    // 불러온 데이터로 테이블 행 생성
    items.forEach(function(item) {
        const row = `
            <tr>
                <td><input type="checkbox" id="itemSelect${item.cust_cd}" name="itemSelect"></td>
                <td>${item.item_cd}</td>
                <td>${item.item_nm}</td>
                <td>${item.item_spec}</td>
                <td>${item.item_unit}</td>
                <td>${item.item_cost}원</td>
            </tr>
        `;
        
        
        tableBody.append(row);
    });
}



//모달에서 저장을 누르면 임시로 저장이 되고, 발주등록 폼으로 데이터를 넘기면서 table을 만들어주는 코드
$(document).ready(function() {
    // '저장' 버튼 클릭 이벤트 리스너 설정
    $('#modalSaveButton').on('click', onSaveModal);
    
});


let tempItems = {}; // 임시 저장할 배열

// 체크박스 선택된 아이템만 가져오는 함수
function onSaveModal() {

    const selectedCheckboxes = $('#jajeTable tbody input[type="checkbox"]:checked');

    selectedCheckboxes.each(function() {
        const row = $(this).closest('tr');
        const itemCd = row.find('td:nth-child(2)').text(); // 품목 코드를 키로 사용

        // tempItems에 해당 itemCd가 존재하지 않는 경우에만 추가
        if (!tempItems[itemCd]) {
            const selectedItem = {
                item_cd: row.find('td:nth-child(2)').text(),
                item_nm: row.find('td:nth-child(3)').text(),
                item_spec: row.find('td:nth-child(4)').text(),
                item_unit: row.find('td:nth-child(5)').text(),
                item_cost: row.find('td:nth-child(6)').text().replace('원', ''),
            };
            tempItems[itemCd] = selectedItem; // 객체에 아이템 추가

            // 항목 추가 후 체크 해제
            $(this).prop('checked', false);
        }
    });
    
    // 'jajeInputBody'에 항목들을 추가
    updateJajeInputBody();   	// 테이블 업데이트 함수 호출

}

//발주등록폼에서 'jajeInputBody'에 항목들을 추가하는 새로운 함수 
function updateJajeInputBody() {
    const jajeInputBody = $('#jajeInputBody');
    jajeInputBody.empty(); // 기존 항목들을 비우고 새로 시작 ==> 중복값을 방지하기위해서. 2개들어가는것을 방지
    

    Object.values(tempItems).forEach((item, index) => {
		// item.item_qty가 undefined인 경우 기본값으로 0을 설정
        const itemQty = item.item_qty !== undefined ? item.item_qty : 0;
        
        jajeInputBody.append(`
		<tr>
		    <td><input type="checkbox"></td>
		    <td>${item.item_cd}</td>
		    <td>${item.item_nm}</td>
		    <td>${item.item_spec}</td>
		    <td>${item.item_unit}</td>
		    <td><input type="number" class="qty-input" value="${item.item_qty}" data-item-cost="${item.item_cost}" min="0"></td>
		    <td>${item.item_cost}원</td>
		    <td class="purc-cost">${item.item_qty * item.item_cost}원</td>
		</tr>
        `);
    });
}

//발주등록 폼에서 input에 입력한 숫자 * 금액 ==> 발주금액이 나오게 되는부분
$(document).ready(function() {
    // 수량 입력 필드의 값이 변경될 때마다 실행되는 이벤트 리스너
    $(document).on('input', '.qty-input', function() {
        const $this = $(this);
        const itemCost = parseFloat($this.data('item-cost')); // 단가를 숫자로 변환
        const qty = parseFloat($this.val()); // 입력된 수량을 숫자로 변환
        const purcCost = itemCost * qty; // 공급가액 계산


        // 공급가액이 유효한 숫자가 아니면 0으로 설정 NaN원으로 나오는것떄문에 0원으로 해주자
        if (isNaN(purcCost)) {
            purcCost = 0;
        }
        // 공급가액을 현재 행의 'purc-cost' 클래스를 가진 td에 업데이트
        $this.closest('tr').find('.purc-cost').text(`${purcCost}원`);
        
        //총 합계 업데이트
        updateTotalAmount();
    });
    
     // 총 합계를 계산하고 업데이트하는 함수
    function updateTotalAmount() {
        let total = 0; // 총합계 초기화
        // 각 행의 공급가액을 더함
        $('.purc-cost').each(function() {
            const amountText = $(this).text().replace('원', ''); // '원' 문자 제거
            const amount = parseFloat(amountText);
            if (!isNaN(amount)) { // 숫자인 경우에만 더함
                total += amount;
            }
        });

        // 총합계를 'totalAmount' id를 가진 div에 표시
        $('#totalAmount').text(`총합계: ${total}원`);
    }
});

/*
//발주등록 폼에서 input에 입력한 숫자 * 금액 ==> 발주금액이 나오게 되는부분
$(document).ready(function() {
    // 수량 입력 필드의 값이 변경될 때마다 실행되는 이벤트 리스너
    $(document).on('input', '.qty-input', function() {
        const $this = $(this);
        const itemCost = $this.data('item-cost'); // 단가 가져오기
        const qty = $this.val(); // 입력된 수량 가져오기
        const purcCost = itemCost * qty; // 공급가액 계산

        // 공급가액을 현재 행의 'purc-cost' 클래스를 가진 td에 업데이트
        $this.closest('tr').find('.purc-cost').text(`${purcCost}원`);
        
        //총 합계 업데이트
        updateTotalAmount();
    });
    
     // 총 합계를 계산하고 업데이트하는 함수
    function updateTotalAmount() {
        let total = 0; // 총합계 초기화
        // 각 행의 공급가액을 더함
        $('.purc-cost').each(function() {
            const amountText = $(this).text().replace('원', ''); // '원' 문자 제거
            const amount = parseFloat(amountText);
            if (!isNaN(amount)) { // 숫자인 경우에만 더함
                total += amount;
            }
        });

        // 총합계를 'totalAmount' id를 가진 div에 표시
        $('#totalAmount').text(`총합계: ${total}원`);
    }
});
*/



/*
// 최종 '저장' 버튼 클릭 시 서버에 데이터 전송
function onFinalSave() {
    $.ajax({
        type: 'POST',
        url: '/saveItems', // 서버의 데이터 저장 엔드포인트
        contentType: 'application/json',
        data: JSON.stringify(tempItems),
        success: function(response) {
            // 성공 처리 로직
            updateFormTable(response);
        },
        error: function() {
            // 오류 처리 로직
        }
    });
}
*/