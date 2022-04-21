var option = document.getElementsByName('option');
option = [...option];
option.forEach((item) => {
    console.log(item);
    item.addEventListener('click', () => {
        if (option[0].checked && !option[1].checked) {
            document.querySelector('#optionMore').classList.remove('fade');
        } else {
            document.querySelector('#optionMore').classList.add('fade');
        }
    });
});

function changeValue(value) {
    var item = document.querySelectorAll('.list-group-item');
    var active = document.querySelectorAll('.active');
    active.forEach((get) => {
        get.classList.remove('active');
        get.classList.remove('show');
    });
    if (value.href !== null) {
        var show = document.querySelector('#' + value.href.split("#")[1]);
        if (show !== null) {
            show.classList.add('show', 'active');
            value.classList.add('active');
        } else {
            item[0].classList.add('active');
            output.querySelectorAll('.tab-pane')[0].classList.add('show', 'active');
        }
    }
}
var option = document.getElementsByName('notice');
option = [...option];
option.forEach((item) => {
    item.addEventListener('click', () => {
        if (option[0].checked) {
            document.querySelector('#deadlineAll').classList.remove('fade');
        } else {
            document.querySelector('#deadlineAll').classList.add('fade');
        }
    });
});