/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var top_div = document.getElementById("top");

var data = await fetch("/NewsWar-App/directdb");

if(data.ok){
    var json_data = data.json();
    for(json_elem in JSON.parse(json_data)){
        top_div.appendChild(todo_element(json_elem));
    }
}
else{
    alert("HTTP ERROR: "+data.statusCode());
}


function todo_element(data){
    var id = data.id;
    var title = data.title;
    var body = data.body;
    
    var div_element = document.createElement("div");
    div.setAttribute("id",id);
    
    var title_element = document.createElement("h4");
    var body_element = document.createElement("p");
    
    title_element.innerText = title;
    body_element.innerText = body;
    
    div_element.appendChild(title_element);
    div_element.appendChild(body_element);
    
    return div_element;
}