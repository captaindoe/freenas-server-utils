(function() {
  const request = new XMLHttpRequest();
  request.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      const json = JSON.parse(request.responseText);
      const html = Object
        .keys(json)
        .map(key => `<tr><td>${key}</td><td>${json[key]}</td></tr>`)
        .join("");
      document.getElementById("ipinfo").innerHTML = html; 
    }
  };
  request.open("GET", "/api/ipinfo", true);
  request.send();
})();
