<!doctype html>

<script language="javascript">
function checkRadio(id){

//Checks if radio button is clicked, radio buttons are named <user>del,<user>close,<user>unk, and user<renew>
//<user>hide is a div used to conceal the checkbox, if close account is checked, it is revealed, else it is hidden and unchecked


   var delstr=id.concat("del");
   var renewstr=id.concat("renew");
   var closestr=id.concat("close");
   var unkstr=id.concat("unk");
   var hidestr=id.concat("hide");
//   var renewbutton=document.getElementById(renewstr);
   var delbutton=document.getElementById(delstr);
   var closebutton=document.getElementById(closestr);
//   var unkbutton=document.getElementById(unkstr);
   var divbox=document.getElementById(hidestr);
    if (closebutton.checked) {
        divbox.style.display='inline';
        }
    else{
        divbox.style.display='none';
        delbutton.checked = false;
        }
}
</script>
<html>
 <head>
  <link rel="stylesheet" type="text/css" href="/css/css.css"/>
 </head>
 <body>
  <div class="main">
   <div class="sub_input">
     <div class="header">
      <h1>Known Accounts</h1>
     </div>
     <form method="get" action="/end">
       <div class="mass">
         <div class="users">
           <h2>Accounts Attached to GID</h2>
           % x=0
           % for i in User_list:
          <!-- % radioname = "User" + str(x) -->
           %user=User_list[x]
           {{User_list[x]}}
           %dofunc="checkRadio("+'"' + user + '"' +")"
           <input type="radio" id={{user}}renew name={{user}}radio value="known" onclick={{dofunc}}>Renew Account
           <input type="radio" id={{user}}close name={{user}}radio value="close" onclick={{dofunc}} >Close Account
	   <input type="radio" id={{user}}unk name={{user}}radio value="unknown" onclick={{dofunc}} >Unknown account
          <span id={{user}}hide style="display: none"><input type="checkbox" id={{user}}del name={{user}}check value="delete">Delete Account</span>
           <br><br>
           % x+=1
           % end
           <input type="submit" name=submit>
         </div>
     </form>
   </div>
 </div>
 </body>
</html>
