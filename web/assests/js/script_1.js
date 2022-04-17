$('input[type="file"]').change(function () {
    $.each(this.files, function () {
        readURL(this);
    });
});
var listFile = document.querySelector('#listFile');
var output = document.querySelector('#outputFile');
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

function readURL(file) {
    var reader = new FileReader();
    reader.onload = function (e) {
        var button = document.createElement('button');
        button.classList.add('btn-close');
        button.setAttribute('aria-label', 'Close');
        button.setAttribute('onclick', 'deleteURL(this.parentNode)');
        var num = listFile.querySelectorAll('.list-group-item').length - 2;
        var p = document.createElement('span');
        p.innerHTML = 'Bài nộp ' + num;
        var href = document.createElement('a');
        href.classList.add('list-group-item', 'd-flex', 'justify-content-between');
        href.setAttribute('data-toggle', 'list');
        href.href = '#file' + num;
        href.setAttribute('onclick', 'changeValue(this)');
        href.appendChild(p);
        href.appendChild(button);
        listFile.appendChild(href);
        var div = document.createElement('div');
        div.classList.add('tab-pane', 'fade', 'h-100');
        div.id = 'file' + num;
        if (file.name.includes('pdf')) {
            var embed = document.createElement('embed');
            embed.src = e.target.result;
            embed.type = 'application/pdf';
            div.appendChild(embed);
        } else {
            var image = document.createElement("img");
            image.src = e.target.result;
            div.appendChild(image);
        }
        output.appendChild(div);
    };
    reader.readAsDataURL(file);
}

function deleteURL(file) {
    var outputFile = document.querySelector('#' + file.href.split("#")[1]);
    output.removeChild(outputFile);
    listFile.removeChild(file);
}

function changeValue(value) {
    var item = document.querySelectorAll('.list-group-item');
    var active = document.querySelectorAll('.active');
    active.forEach((get) => {
        get.classList.remove('active');
        get.classList.remove('show');
    });
    if (value.href != null) {
        var show = document.querySelector('#' + value.href.split("#")[1]);
        if (show != null) {
            show.classList.add('show', 'active');
            value.classList.add('active');
        } else {
            item[0].classList.add('active');
            output.querySelectorAll('.tab-pane')[0].classList.add('show', 'active');
        }
    }
}