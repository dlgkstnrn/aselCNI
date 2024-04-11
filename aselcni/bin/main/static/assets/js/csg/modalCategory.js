let remark ="";
let purc_emp_id ="";
let cust_cd="";
let cust_emp="";
let item_cd ="";
let qty ="";
let item_cost ="";
let purc_cost ="";
const csgPurItemList=[]
    
const dataInput = {
    remark,
    purc_emp_id,
    cust_emp,
    csgPurItemList
};


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
        let itemQty = item.item_qty !== undefined ? item.item_qty : 0;
        
        jajeInputBody.append(`
		<tr >
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
        let $this = $(this);
        let itemCost = parseFloat($this.data('item-cost')); // 단가를 숫자로 변환
        let qty = parseFloat($this.val()); // 입력된 수량을 숫자로 변환
        let purcCost = itemCost * qty; // 공급가액 계산


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


//insert를 위해서 발주등로폼에서 데이터 가져오기 맨위에 let으로 선언한 data참고하자
function sendOrderDetails() {
    // 폼에 입력된 비고 정보 가져오기
    dataInput.cust_cd=$('#supplier').val()
    dataInput.remark=$("#remark").val();
	dataInput.purc_emp_id=$("#com_manager-name").val();
	dataInput.cust_emp=$("#op_manager-name").val();

	let jajeTableBody =$("#jajeInputBody").find("tr");
	console.log("jajeTableBody", jajeTableBody);
	
	
    jajeTableBody.each(function() {
        // 각 행(td)에서 데이터 추출
        let jTableItem_cd = $(this).find('td:nth-child(2)').text();
        let jTableItemQty = $(this).find('td:nth-child(6)').find('input').val(); // input 값이므로 find('input') 추가
        let jTableItemPurc_cost = $(this).find('td:nth-child(8)').text();

        // 추출한 데이터로 객체 생성 및 csgPurItem 배열에 추가 가능함
        dataInput.csgPurItemList.push({
            item_cd: jTableItem_cd,
            qty: parseInt(jTableItemQty, 10), // 문자열을 정수로 변환
            purc_cost: parseFloat(jTableItemPurc_cost) // 문자열을 부동소수점 숫자로 변환
            // 여기서 purc_cost는 qty와 item_cost를 곱한 값이 될 수 있습니다.
            // purc_cost는 서버 측에서 계산할 수도 있으니, 클라이언트에서 전송하지 않아도 됩니다.
        });

    });


    // 발주 상세 정보를 담을 데이터 객체 초기화


    // 'jajeInputBody' 내의 각 체크박스를 확인하여 선택된 항목들을 추출
    $("#jajeInputBody input[type='checkbox']:checked").each(function() {
        const row = $(this).closest("tr"); // 해당 체크박스가 속한 행(row)
        const itemCd = row.find("td:nth-child(2)").text(); // 품목 코드
        const itemQty = parseFloat(row.find(".qty-input").val()); // 수량 (숫자로 변환)
        const itemCost = parseFloat(row.find(".qty-input").data("item-cost")); // 단가 (숫자로 변환)
        const purcCost = itemQty * itemCost; // 발주 금액 계산

    });

    // AJAX 요청으로 서버에 데이터 전송
    $.ajax({
        type: 'POST',
        url: '/submitOrderDetails', // 서버의 엔드포인트
        contentType: 'application/json', // 데이터 타입 JSON 지정
        data: JSON.stringify(dataInput), // 데이터 객체 전송
        success: function(response) {
            // 성공 처리 로직
            console.log("컨트롤러로 값이 전송되었습니다");
            window.location.href = 'purchase';
        },
        error: function(xhr, status, error) {
            // 오류 처리 로직
            console.error("전송 실패", error);
        }
    });
}


function submitFormWithCancel() {
    // "취소" 버튼 클릭 시의 동작
    // 예를 들어, 사용자를 이전 페이지로 리다이렉트
    location.href='purchase';
    
}

//발주리스트에서 삭제처리 하기(select와 update임 사실)
function deleteSelected() {
    let selectedIds = []; // 선택된 항목의 ID를 저장할 배열

    // 테이블의 모든 체크박스를 반복하여 선택된 것들의 ID를 수집합니다.
    let checkboxes = document.querySelectorAll('input[type="checkbox"]');
    checkboxes.forEach(function(checkbox) {
        if (checkbox.checked) {
            // 체크된 체크박스의 부모 행(tr)을 가져옴
            let row = checkbox.closest('tr');
            // 행에서 발주진행상태(purc_status_chk)를 가져옴
            let purcStatus = row.querySelector('td:nth-child(10)').textContent; // 발주현황 열 위치 변경에 따른 수정

            // 발주진행중인 항목만 삭제할 수 있도록 조건을 추가
            if (purcStatus.trim() === '발주진행중') {
                // 행에서 발주번호(purc_no)와 거래처 발주담당자(cust_emp)를 가져옴
                let purc_no = row.querySelector('td:nth-child(3)').textContent;
                selectedIds.push(purc_no); // 선택된 항목의 ID를 배열에 추가
            } else {
                // 발주진행중이 아닌 항목은 삭제할 수 없음을 사용자에게 알림
                alert("발주진행중인 항목만 삭제할 수 있습니다.");
                return; // 함수 종료
            }
        }
    });

    // 선택된 항목이 없는 경우에는 경고 메시지를 표시하고 함수를 종료합니다.
    if (selectedIds.length === 0) {
        alert("선택된 항목이 없습니다.");
        return; // 함수를 종료합니다.
    }

    // 선택된 항목의 ID를 하나의 문자열로 조합합니다.
    let idsString = selectedIds.join(","); // 배열을 문자열로 변환

    // 선택된 항목의 ID 문자열을 hidden input에 설정합니다.
    document.getElementById("selectedIds").value = idsString;

    // 폼을 제출합니다.
    document.getElementById("deleteForm").submit();
}

