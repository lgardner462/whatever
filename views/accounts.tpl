<!doctype html>

<script language="javascript">
function checkRadio(id){
  //  var radios = document.getElementsByName("haoyue");
   // for (var i = 0; i < radios.length; i++) {       
  //      if (radios[i].checked) {
 //           alert(radios[i].value);
//            break;
   //     }
 //   }
   var delstr=id.concat("del");
   var knostr=id.concat("kno");
   var unkstr=id.concat("unk");
   var hidestr=id.concat("hide");
   var knobutton=document.getElementById(knostr);
   var delbutton=document.getElementById(delstr);
   var unkbutton=document.getElementById(unkstr);
   var divbox=document.getElementById(hidestr);
    if (unkbutton.checked) {
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
     <form>
       % target_Groups_list = [ line for line in open('Files/Groups') if USER_IN in line]
       % target_Groups_str = ''.join(target_Groups_list)
       % Group, trash, GID, trash = target_Groups_str.split(":", 3)
       <div class="mass">
         % x = 0
         % Name = ""
         % target_Passwd_list = [ line for line in open('Files/Passwd') if GID in line ]
         % User_list = [i.split(':', 1)[0] for i in target_Passwd_list]
         % for i in User_list:
         % x+=1
         % end
         <div class="users">
           <h2>Accounts Attached to GID</h2>
           % x = 0
           % for i in User_list:
          <!-- % radioname = "User" + str(x) -->
           %user=User_list[x]
           {{User_list[x]}}
           %dofunc="checkRadio("+'"' + user + '"' +")"
           <input type="radio" id={{user}}kno name={{user}}radio value="known" onclick={{dofunc}}>Known
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