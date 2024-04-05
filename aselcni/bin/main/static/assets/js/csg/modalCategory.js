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
            big_no: big_no

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
                <td>${item.cust_cd}</td>
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
        const selectedItem = {
            item_cd: row.find('td:nth-child(2)').text(),
            item_nm: row.find('td:nth-child(3)').text(),
            item_spec: row.find('td:nth-child(4)').text(),
            item_unit: row.find('td:nth-child(5)').text(),
            item_cost: row.find('td:nth-child(6)').text().replace('원', ''),
        };
        tempItems[itemCd] = selectedItem; // 객체에 아이템 추가/업데이트
    });
    // 'jajeInputBody'에 항목들을 추가
    updateJajeInputBody();   	// 테이블 업데이트 함수 호출

}

// 'jajeInputBody'에 항목들을 추가하는 새로운 함수
function updateJajeInputBody() {
    const jajeInputBody = $('#jajeInputBody');

    Object.values(tempItems).forEach((item, index) => {
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
        const itemCost = $this.data('item-cost'); // 단가 가져오기
        const qty = $this.val(); // 입력된 수량 가져오기
        const purcCost = itemCost * qty; // 공급가액 계산

        // 공급가액을 현재 행의 'purc-cost' 클래스를 가진 td에 업데이트
        $this.closest('tr').find('.purc-cost').text(`${purcCost}원`);
    });
});


/*
// 모달에서 '저장' 버튼 클릭 시 이벤트 리스너 설정
$('#modalSaveButton').on('click', function(event) {
    onSaveModal(); // 저장 버튼 클릭 시 함수 실행
});

// 다른 폼의 테이블을 업데이트하는 함수
function updateFormTable() {
    const tableBody = $('#jajeinsertTable tbody');
    tableBody.empty(); // 기존 내용을 비우기

    // 임시 배열에 저장된 아이템으로 테이블 행 생성
    tempItems.forEach(function(item, index) {
        const row = `
            <tr>
                <td>${index + 1}</td>
                <td>${item.item_cd}</td>
                <td>${item.item_nm}</td>
                <td>${item.item_spec}</td>
                <td>${item.item_unit}</td>
                <td>${item.item_qty}</td>
                <td>${item.item_cost}</td>
                <td>${item.purc_cost}</td>
            </tr>
        `;
        tableBody.append(row);
    });
}


// '저장' 버튼 클릭 이벤트 핸들러
$('#modalSaveButton').on('click', function() {
	console.log('저장버튼 클릭됨');
	
    const checkedItems = $('#jajeTable tbody input[type="checkbox"]:checked');
    
    // 선택된 항목들을 기반으로 새로운 테이블 행 생성
    checkedItems.each(function() {
        const row = $(this).closest('tr');
        const itemData = {
            cust_cd: row.find('td:nth-child(2)').text(),
            item_nm: row.find('td:nth-child(3)').text(),
            item_spec: row.find('td:nth-child(4)').text(),
            item_unit: row.find('td:nth-child(5)').text(),
            qty: row.find('td:nth-child(6)').text().replace('개', ''),
            item_cost: row.find('td:nth-child(7)').text().replace('원', ''),
            purc_cost: row.find('td:nth-child(8)').text().replace('원', '')
        };

        // 전역 변수에 데이터 저장 (예시)
        jajeData[itemData.cust_cd] = itemData;
        
        // 새로운 테이블에 선택된 항목 추가
        $('#newTable tbody').append(`
            <tr>
                <td>${itemData.cust_cd}</td>
                <td>${itemData.item_nm}</td>
                <td>${itemData.item_spec}</td>
                <td>${itemData.item_unit}</td>
                <td>${itemData.qty}</td>
                <td>${itemData.item_cost}</td>
                <td>${itemData.purc_cost}</td>
            </tr>
        `);
    });

    // 필요한 경우 추가 작업 수행
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