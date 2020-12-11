<%-- 
    Document   : index
    Created on : Dec 7, 2009, 6:49:31 PM
    Author     : nb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
         <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
         <script>
             /* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */




fetch("/NewsApp-war/directdb").then(data=>data.json()).then(data=>populate_item(data));

function populate_item(json_data){
    var top_div = document.getElementById("top");
    console.log(typeof(json_data));
for(json_elem in json_data){
        console.log(json_elem);
        console.log(todo_element(json_data[json_elem]));
        top_div.appendChild(todo_element(json_data[json_elem]));
    }
}



function todo_element(data){
    
    var id = data.uuid;
    var title = data.title;
    var body = data.body;
    
    var div_element = document.createElement("div");
    div_element.setAttribute("id",id);
    
    var title_element = document.createElement("h4");
    title_element.setAttribute("contenteditable","true");
    title_element.innerText = title;
    title_element.setAttribute("class","title");
    title_element.setAttribute("id",id+"_title");
    
    var body_element = document.createElement("p");
    body_element.setAttribute("contenteditable","true");
    body_element.innerText = body;
    body_element.setAttribute("class","body");
    body_element.setAttribute("id",id+"_body");
    
    var update_button = document.createElement("button");
    update_button.setAttribute("class","update_button")
    update_button.addEventListener("click", update_button_action);
    update_button.textContent="Update";
    
    var delete_button = document.createElement("button");
    delete_button.setAttribute("class","delete_button")
    delete_button.addEventListener("click", delete_button_action);
    delete_button.textContent="Delete";
    
    
    
    div_element.appendChild(title_element);
    div_element.appendChild(body_element);
    div_element.appendChild(update_button);
    div_element.appendChild(delete_button);
    
    return div_element;
}

function update_button_action(){
    //get parent node
    var edited_div = this.parentNode;
    
    //get update parameters
    var id = this.parentNode.id;
    var title = edited_div.getElementsByClassName("title")[0].innerText;
    var body = edited_div.getElementsByClassName("body")[0].innerText;
    
    //post request data
    var data_to_send = "id="+id+"&title="+title+"&body="+body;
    
    fetch("/NewsApp-war/update",{
        method : "POST",
        headers: {'Content-Type':'application/x-www-form-urlencoded'},
        body :  data_to_send
    }).then(response =>{
        if(response.status!=200){
            alert("Error");
        }
        else{
            console.log("Success");
        }
        
    })
    
}
function delete_button_action(){
    var delete_div = this.parentNode;
    
    delete_div.remove();
    var id = this.parentNode.id;
   
    var data_to_send = "id="+id;
    
    fetch("/NewsApp-war/delete",{
        method : "POST",
        headers: {'Content-Type':'application/x-www-form-urlencoded'},
        body :  data_to_send
    }).then(response =>{
        if(response.status!=200){
            alert("Error Deleting Item");
        }
        else{
            console.log("Success");
        }
        
    })
    
}

function addItem(){
    var title=document.getElementById("new_title").value;
    var body =document.getElementById("new_body").value;
    
    var data_to_send = "title="+title+"&body="+body;
    
     fetch("/NewsApp-war/PostMessage",{
        method : "POST",
        headers: {'Content-Type':'application/x-www-form-urlencoded'},
        body :  data_to_send
    }).then(response =>response.text()).then(d => {
         var top_div = document.getElementById("top");
            
            var title=document.getElementById("new_title").value;
            var body =document.getElementById("new_body").value;
            var id = d;
            console.log(id);
            
            var values ={
                id : id,
                title: title,
                body : body
            }
            top_div.appendChild(todo_element(values));
            console.log("Success Adding Item");
    })
    
    
    
    
}

             </script>

       
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Todo List</h1>    
            <input type="text" id="new_title" placeholder="TODO title">
            <input type="textbox" id="new_body" placeholder="Description">
            <button type="Submit" onclick="addItem()">Submit</button>
        <br />
        <div id="top">
            
        </div>
    </body>
</html>
