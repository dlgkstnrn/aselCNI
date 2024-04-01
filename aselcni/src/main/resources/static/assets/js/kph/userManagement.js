$('#user-add').on('click', function () {  
	window.location.href = 'userAddForm';
});

$('#search-text').on('keyup', (event) => {
	if (event.keyCode === 13) {
		$('#search-btn').click();
	}
});

$("#search-btn").on("click", () => {
	const keyword = $("#search-text").val();
	const searchFilter = $(".search-filter").val();

	$(".table-nav .table tbody").empty();
	$(".table-nav .page-navigation .pagination").empty();

	$.ajax({
		type: "get",
		url: "/userSearch",
		data: {
			keyword: keyword,
			searchFilter: searchFilter,
		},
		dataType: 'json',
		success: function(response) {

			let userList = response.userList;
			let paging = response.paging;
			let num = paging.start;

			userList.forEach((user) => {
				$(".table-nav .table tbody").append(`
	                <tr>
	                    <th>${num}</th>
						<td><a class="user-id" href="userUpdateForm?user_id=${user.user_id }">${user.user_id }</a></td>
						<td>${user.user_nm }</td>
						<td>${user.user_phone }</td>
						<td>${user.user_tel }</td>
						<td>${user.user_email }</td>
						<td>${user.comm_content}</td>
						<td><button type="button" class="user-delete btn btn-danger">삭제</button></td>
	                </tr>
           	 	`);
				num = num + 1;
			});

			if (paging.startPage > paging.pageBlock) {
				$(".pagination").append(`
                	<li class="page-item"><a class="page-link" href="/userManagement?currentPage=${paging.startPage-paging.pageBlock }&keyword=${keyword}&searchFilter=${searchFilter}"><span>&laquo;</span></a></li>
            	`);
			}

			for (let i = paging.startPage; i <= paging.endPage; i++) {
				$(".pagination").append(`
                	<li class="page-item"><a class="page-link" href="/userManagement?currentPage=${i}&keyword=${keyword}&searchFilter=${searchFilter}">${i}</a></li>
            	`);
			}

			if (paging.endPage < paging.totalPage) {
				$(".pagination").append(`
                	<li class="page-item"><a class="page-link" href="/userManagement?currentPage=${paging.startPage+paging.pageBlock }&keyword=${keyword}&searchFilter=${searchFilter}"><span>&raquo;</span></a></li>
           		`);
			}
		}
	});

});


$('.table-nav').on('click', '.user-delete', function() {
	const tr = $(this).closest('tr');
	const user_id = $(tr).find('.user-id').text();
	$.ajax({
		type: "post",
		url: "/userDelete",
		data: {
			user_id: user_id
		},
		success: function (response) {
			window.location.reload(true);
		}
	});
});