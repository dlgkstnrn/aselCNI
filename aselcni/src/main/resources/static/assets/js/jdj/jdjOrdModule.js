// null여부 확인
// export function isNotNull(key){
//	console.log("isNotNull check")
//	return $(`#${key}`).val() != null && $(`#${key}`).val() !== "";
//}
let order_item_cd
window.isNotNull = function(key) {
    console.log("isNotNull check");
    return $(`#${key}`).val() != null && $(`#${key}`).val() !== "";
};
