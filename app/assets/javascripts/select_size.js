function val() {
    d = document.getElementById("select-size").value;
    d.value = '<% @roomfilter = @rooms %>';
    alert(d);
}
