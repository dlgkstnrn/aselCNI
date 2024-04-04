function submitFormWithSave() {
    // "저장" 버튼 클릭 시의 동작
    // 예를 들어, 폼 데이터를 서버의 특정 엔드포인트로 전송
    document.getElementById('purchaseItem2').action = 'purchaseSave';
    document.getElementById('purchaseItem2').submit();
}

function submitFormWithCancel() {
    // "취소" 버튼 클릭 시의 동작
    // 예를 들어, 사용자를 이전 페이지로 리다이렉트
    location.href='purchase';
}