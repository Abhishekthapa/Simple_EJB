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
    console.log(json_data);
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
    var title = data.title + ": ";
    var body = data.body;
    
    var div_element = document.createElement("div");
    div_element.setAttribute("id",id);
    div_element.setAttribute("class", "todo_item");
    
    var title_element = document.createElement("h2");
    title_element.setAttribute("contenteditable","true");
    title_element.innerText = title;
    title_element.setAttribute("id",id+"_title");
    title_element.setAttribute("class","title m-0");
    
    var body_element = document.createElement("p");
    body_element.setAttribute("contenteditable","true");
    body_element.innerText = body;
    body_element.setAttribute("class","body m-0");
    body_element.setAttribute("id",id+"_body");
    
    
    
    var update_button = document.createElement("button");
    update_button.setAttribute("class","btns btns__update")
    update_button.addEventListener("click", update_button_action);
    update_button.textContent="Update";
    
    var update_button_wrap = document.createElement("div");
    update_button_wrap.setAttribute("class","update_button_wrap");
    update_button_wrap.appendChild(update_button);
    
    
    
    var delete_button = document.createElement("button");
    delete_button.addEventListener("click", delete_button_action);
    delete_button.textContent="X";
    delete_button.setAttribute("class","btns btns__delete");
    
    var delete_button_wrap = document.createElement("div");
    delete_button_wrap.setAttribute("class","delete_button_wrap");
    delete_button_wrap.appendChild(delete_button);
    
    var content = document.createElement("div");
    content.appendChild(title_element);    
    content.appendChild(body_element);
    
    div_element.appendChild(content);
    div_element.appendChild(update_button_wrap);
    div_element.appendChild(delete_button_wrap);
    
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
    
    delete_div.parentNode.remove();
    var id = this.parentNode.parentNode.id;
   
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

function toggle(){
    console.log('ca;;eafsd');
    
    var a_b = document.getElementById("add_b");
    
    if(a_b.innerHTML === '+'){
        a_b.innerHTML = 'x';
    }
    else{
        a_b.innerHTML = '+';
    }
    
    
    var f = document.getElementById("add_new");
    var top = document.getElementById("top");
    var c_f = f.classList;
    var c_top = top.classList;
    
    if(c_top.length ===1){
        top.classList.add("hide");
        f.classList.remove("hide");        
    }
    else{
        f.classList.add("hide");
        top.classList.remove("hide"); 
    }
    

    
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
            document.getElementById("new_title").value = '';
            document.getElementById("new_body").value = '';
            var values ={
                id : id,
                title: title,
                body : body
            }
            top_div.appendChild(todo_element(values));
            console.log("Success Adding Item");
            toggle();
            
    })
    
    
    
    
}

             </script>
         
         <style>
             *,
*::after,
a::before {
  box-sizing: border-box;
  padding: 0;
  margin: 0;
}

html {
  font-size: 62.5%;
  box-sizing: border-box;
}
body {
  line-height: 1.4;
  font-weight: 400;
  font-family: "Lato", sans-serif;
}
.header {
  height: 6rem;
  background-color: #00695c;
  font-family: "Lato", sans-serif;
  display: flex;
  align-items: center;
  font-size: 1.8rem;
}
.header__item {
  align-self: stretch;
  margin-left: 2.5rem;
  display: flex;
  align-items: center;

}
.header__item__navlink {
  text-decoration: none;
  color: #fff;
  padding: 0.5rem;
}

.header__item__navlink:hover {
  text-decoration: none;
  color: #00695c;
  background-color: #fff;
  padding: 0.5rem;
}
.header__item .header__item__navlink--active {
  color: #00695c;
  background-color: #fff;
  padding: 0.5rem;
}
.main {
  margin: 1rem 2.5rem;
  font-size: 1.6rem;
}

.form {
  /* background: linear-gradient(rgba(0,0,0,0.2),rgba(0,0,0,0.1)); */
  display:flex;
  flex-direction: column;
  align-items: center;
  animation: moveInLeft 5s;
 
}
.form__control {
  display: flex;
  flex-direction: column;
  margin: 3rem;
  
  width: 40%;
}
.form__input{
  font-size: inherit;
  font-family: inherit;
  font-weight: 400;
  outline: none ;
  border: none;
  background: none;
  border-bottom: 0.2rem solid #00695c;
}
.text_area{
      border: 0.2rem solid #00695c;
}
.btns{
  display: inline-block;
  padding: 0.25rem 1rem;
  text-decoration: none;
  font: inherit;
  border: 0.2rem solid #00695c;
  color: #00695c;
  background: white;
  border-radius: 0.3rem;
  cursor: pointer;
}
.btns:hover,
.btns:active {
  background-color: #00695c;
  color: white;
  outline: none;
}

.btns__submit{
  margin-top: 4rem;
}

.btns__update{
    color: black;
    border: 0.2rem solid #000;
}
.btns__delete{
    background-color: rgb(109, 21, 21);
    border: 1px solid rgb(85, 143, 202);
    border-radius: 0.25rem;
    color: white;
    padding: 5px 10px;
}

.btns__delete:hover{
  background-color: #ff0000;
  color: white;
  outline: none;
}

.todos{
    display: flex;
    align-items: center;
    justify-content: space-around;
    flex-direction: column;
    animation: moveInRight 5s;
}
.title{
    font-weight: bold;
}

.remove_button{
    background-color: rgb(109, 21, 21);
    border: 1px solid rgb(85, 143, 202);
    border-radius: 0.25rem;
    color: white;
    padding: 5px 10px;
}
.todo_item{
    border: 1px solid #498cb3;
    display: grid;
    grid-template-columns: 10fr 2fr 1fr;
    justify-content: space-around;
    align-items: center;
    padding: 0.5rem;
}



.hide{
    display:none;
}

@keyframes moveInLeft {
  0% {
    opacity: 0;
    transform: translateX(-10rem);
  }
  80% {
    transform: translateX(1rem);
  }

  100% {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes moveInRight {
  0% {
    opacity: 0;
    transform: translateX(10rem);
  }
  80% {
    transform: translateX(-1rem);
  }

  100% {
    opacity: 1;
    transform: translateX(0);
  }
}

         </style>

       
        <title>JSP Page</title>
    </head>
    <body>
    <nav class="header">
        <div class="header__item">
            <button class=" btns btns__new " onclick="toggle()" id="add_b">+</button>
        </div>
        
    </nav>
    <div class="main">
        <div class="form hide" id="add_new">
            <h2  class="title">Add TODO Here</h2>
      <div class="form__control">
        <label htmlFor="name">Title</label>
        <input type="text" id="new_title" class="form__input" />
      </div>
      <div class="form__control">
        <label htmlFor="name">Description</label>
        <textarea id="new_body" rows="4" cols="50" class="form__input text_area"></textarea>
      </div>

      <button class="btns btns__submit" onclick="addItem()" >Submit</button>
        </div>
        
        <div class="todos" id="top">
            <h2 class="title">TODOs List</h2>
            <div class= "todo_list">            
        </div>
        </div>
    </div>
        
<!--        <h1>Todo List</h1>    
            <input type="text" id="new_title" placeholder="TODO title">
            <input type="textbox" id="new_body" placeholder="Description">
            <button type="Submit" onclick="addItem()">Submit</button>
        <br />-->
        
    </body>
</html>
