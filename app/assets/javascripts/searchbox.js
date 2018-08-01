function FindUsers() {

    var input, filter, ul, li, a, i;
    input = document.getElementById('invited');
    filter = input.value.toUpperCase();
    ul = document.getElementById('list');
    li = ul.getElementsByTagName('li');


    for (i = 0; i < li.length; i++) {
        a = li[i].getElementsByTagName("a")[0];
        if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = "";
            $(li[i]).addClass('user-group-list-elem');
        } else {
            li[i].style.display = "none";
            $(li[i]).removeClass('user-group-list-elem');
        }
    }
    if ($('.user-group-list-elem').length == 0){
      $("#empty-message").html("Ooops we can't find what you're looking for...");
    } else {
      $("#empty-message").html("");
    }
}
