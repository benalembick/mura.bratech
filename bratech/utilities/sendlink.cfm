<!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. �See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. �If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes
the preparation of a derivative work based on Mura CMS. Thus, the terms and 	
conditions of the GNU General Public License version 2 (�GPL�) cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission
to combine Mura CMS with programs or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, �the copyright holders of Mura CMS grant you permission
to combine Mura CMS �with independent software modules that communicate with Mura CMS solely
through modules packaged as Mura CMS plugins and deployed through the Mura CMS plugin installation API,
provided that these modules (a) may only modify the �/trunk/www/plugins/ directory through the Mura CMS
plugin installation API, (b) must not alter any default objects in the Mura CMS database
and (c) must not alter any files in the following directories except in cases where the code contains
a separately distributed license.

/trunk/www/admin/
/trunk/www/tasks/
/trunk/www/config/
/trunk/www/requirements/mura/

You may copy and distribute such a combined work under the terms of GPL for Mura CMS, provided that you include
the source code of that other code when and as the GNU GPL requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception
for your modified version; it is your choice whether to do so, or to make such modified version available under
the GNU General Public License version 2 �without this exception. �You may, if you choose, apply this exception
to your own modified versions of Mura CMS.
--->

<cfsilent>
<cfparam name="form.ccself" default=0>
<cfif form.sendto2 neq ''><cfset form.sendto1=listappend(form.sendto1,form.sendto2)></cfif>
<cfif form.sendto3 neq ''><cfset form.sendto1=listappend(form.sendto1,form.sendto3)></cfif>
<cfif form.ccself><cfset form.sendto1=listappend(form.sendto1,form.email)></cfif>
<cfset newline=Chr(13) & Chr(10)>
<cfset site = application.settingsManager.getSite(request.siteID) />
<cfset success=true/>
<cftry>
<cfsavecontent variable="notifyText"><cfoutput>
<cfif form.comments neq ''>
#form.comments##newline##newline#</cfif>
#form.fname# #form.lname# would like to share this article with you. Just click the link below to view the selection.

#link#

If the link doesn't work, copy and paste the full URL of the link (with no line breaks or carriage returns) into your browser's address field and hit Enter.
</cfoutput></cfsavecontent>
<cfset email=application.serviceFactory.getBean('mailer') />
<cfset email.sendText(notifyText,
				form.sendto1,
				form.email,
				site.getSite(),
				request.siteid,
				form.email) />
<cfcatch>
<cfset success=false/>
</cfcatch>
</cftry>
</cfsilent>
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>#application.settingsManager.getSite(request.siteID).getSite()# - Send to a Friend</title>
<link rel="stylesheet" href="#application.configBean.getContext()#/#request.siteid#/css/style.css" type="text/css" media="all" />
</head>

<body id="svSendToFriend">
<cfif success>
<h1 class="success">Your Link Has Been Sent.</h1>   
<cfelse>
<h1 class="error">An Error has Occured, Please Check Site Settings.</h1>  
</cfif>
</body>
</html>
</cfoutput>