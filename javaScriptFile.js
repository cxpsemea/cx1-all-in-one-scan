var url = new URL(window.location.href);
var val = url.searchParams.get("val");
var json = `[{"val": "${val}"}]`;
var obj = eval(json); // The payload json=","a":alert(1),"b":" will result in an alert prompt, demonstrating XSS