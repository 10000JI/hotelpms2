//테이블 만들어주는 코드
let secondData;
window.addEventListener('DOMContentLoaded', event => {
    // Simple-DataTables
    // https://github.com/fiduswriter/Simple-DataTables/wiki

    const datatablesSimple = document.getElementById('datatablesSimple');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple);
    }

    //제공된 테이블이 초기화된 후 "datatable-sorter" 클래스 제거
    $(document).ready(function() {
        $('a.datatable-sorter').removeClass('datatable-sorter');
    });
});

// 전역 범위에서 selectedValues 배열 선언 및 초기화
const selectedValues = [];

window.addEventListener('DOMContentLoaded', event => {
    const checkboxes = document.querySelectorAll('input.myCheckbox');

    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', () => {
            const td = checkbox.closest('td');
            const nextColumn = td.nextElementSibling;
            const nextColumnValue = nextColumn.textContent.trim();

            if (checkbox.checked && !selectedValues.includes(nextColumnValue)) {
                selectedValues.push(nextColumnValue);
            } else if (!checkbox.checked && selectedValues.includes(nextColumnValue)) {
                const index = selectedValues.indexOf(nextColumnValue);
                selectedValues.splice(index, 1);
            }

            console.log('선택된 다음 열 값들:', selectedValues);
        });
    });
});


$(document).ready(function () {
    $('#btn-send').click(function () {
        // Get the value from the input field
        var quantity = $('#quantity').val();

        // Create a data object to send via AJAX
        var data = {
            count: quantity,
            itemIds: selectedValues // selectedValues 배열을 데이터 객체에 추가
        };

        console.log('선택된 다음 열 값들:', selectedValues);
        console.log('quantity:', quantity);
        console.log('data:', data);

        // Send the AJAX POST request
        $.ajax({
            type: 'POST',
            url: '/stock/setQuantity',
            data: {
                'quantity':quantity,
                'itemIds': selectedValues
            },
            success: function (response) {
                // Handle the response from the server
                console.log('Data sent successfully');
                location.reload();
            },
            error: function (xhr, status, error) {
                // Handle the error case
                console.log('Error:', error);
            }
        });
       alert("자동발주수량이 수정되었습니다.")
        location.reload();


    });

});

window.addEventListener('DOMContentLoaded', event => {
    const orderStatusRows = document.querySelectorAll("tr");

    orderStatusRows.forEach(row => {
        row.addEventListener('click', () => {
            secondData = row.cells[1].textContent.trim();
            console.log('클릭된 tr의 두 번째 데이터:', secondData);
            const fifthData = row.cells[4].textContent.trim();
            console.log('클릭된 tr의 다섯 번째 데이터:', fifthData);

            if (fifthData === '재고부족') {

                console.log('재고부족 상태로 클릭됨. itemId:', secondData);

                // AJAX POST 요청 수행
                $.ajax({
                    url: '/stock/orderStatus',
                    method: 'POST',
                    data: {
                        'itemId': secondData
                    },
                    success: function (response) {
                        // Handle the response from the server
                        console.log('Data sent successfully');
                        location.reload();
                    },
                    error: function (xhr, status, error) {
                        // Handle the error case
                        console.log('Error:', error);
                    }
                });
                 requestMessage(secondData);
                 location.reload();
            } else {
                console.log('out of stock 상태가 아닙니다.');
            }
        });
    });
});