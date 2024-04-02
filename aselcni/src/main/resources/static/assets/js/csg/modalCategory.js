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
