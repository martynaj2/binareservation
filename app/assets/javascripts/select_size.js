function selectSize() {
    var selectedIdx = document.getElementById("select-size").selectedIndex;
    var selectedSize = document.getElementById("select-size")[selectedIdx].text;
    alert(selectedSize);
}
