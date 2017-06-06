#!/bin/python
import bottle as bottle
from bottle import *
import urlparse # if we're pre-2.6, this will not include parse_qs
USER_IN=""

try:
            from urlparse import parse_qs
except ImportError: # old version, grab it from cgi
            from cgi import parse_qs
            urlparse.parse_qs = parse_qs
#Static
@route('/<filename:path>')
def send_static(filename):
    return static_file(filename, root='static/')

#Template
@route('/',method=["GET","POST"])
def post_home():
    if request.method== "GET":
        USER_IN=request.query.get("USER_IN")
        print(USER_IN)
        return template('index.tpl')
    else:
        USER_IN=request.query.get("USER_IN")
        print(USER_IN)  
@get("/GID")
def get_gid():
    USER_IN=request.query.get("USER_IN")
    gid=""
    # Name groupname for easier handling
    groupname=USER_IN
    User_list=[]
    #if groupname is first field in Groups file, pull GID from it
    for i in open('Files/Groups'):
            if USER_IN == i.split(":",3)[0]:
                gid=i.split(":",3)[2]
    #check Passwd for user name, if GID matchs pgroup GID then add user to userList
    for i in open('Files/Passwd'):
            if gid == i.split(":",5)[3]:
                User_list.append(i.split(":",5)[0])

    if not gid:
            return template("nogid.tpl",USER_IN=USER_IN)
    else:
            return template('accounts.tpl', User_list=User_list)
@get("/end")
def post_gid():
        renewList=[]
        unknownList=[]
        closeList=[]
        deleteList=[]
        queryvars = parse_qs(request.query_string)
        print type(queryvars)
        for htmlvar in queryvars:
                htmlvalue=queryvars.get(htmlvar)[0]
                print htmlvalue
                if htmlvar.endswith("radio"):
                    if htmlvalue == "known":
                        print(htmlvar.split("radio",1)[0] + " is renew")
                        renewList.append(htmlvar.split("radio",1)[0])
                        #print("This is where you do things with confirmed accounts")
                    elif htmlvalue == "unknown":
                        print(htmlvar.split("radio",1)[0] + "is unknown")
                        unknownList.append(htmlvar.split("radio",1)[0])
                       # print("This is where you do things with unknown accounts")
		    elif htmlvalue == "close":
                        print(htmlvar.split("radio",1)[0] + "is closed")
                        closeList.append(htmlvar.split("radio",1)[0])
                       # print("This is where you do things with unknown accounts")

                elif htmlvar.endswith("check"):
                        print("Deletion of " + htmlvar.split("check",1)[0] + " is confirmed")
                        deleteList.append(htmlvar.split("check",1)[0])
                       #print("This is where you do things with deleted accounts")
                else: #ignore the 'submit'
                    pass
        for i in deleteList:
                if i in closeList:
                        closeList.remove(i)
        #Do things with your csvs using these lists, confirmedList unknownList deleteList
        print "RENEW LIST " + str(renewList)
        print "UNKNOWN LIST " + str(unknownList)
        print "DELETE LIST " + str(deleteList)
     	print "CLOSE LIST" + str(closeList)
        return template('final.tpl', renewList=renewList, unknownList=unknownList, deleteList=deleteList, closeList=closeList)
run(host='localhost', port=8081, debug=True)
