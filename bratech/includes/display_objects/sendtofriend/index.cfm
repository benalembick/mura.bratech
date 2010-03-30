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
<cfscript>
	if (NOT IsDefined("request"))
	 request=structNew();
	StructAppend(request, url, "no");
	StructAppend(request, form, "no");
</cfscript>
<cfset rbFactory=application.settingsManager.getSite(request.siteid).getRBFactory() />
</cfsilent>
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

<title>#application.settingsManager.getSite(request.siteID).getSite()# - #rbFactory.getKey('stf.sendtoafriend')#</title>

<link rel="stylesheet" href="#application.settingsManager.getSite(request.siteid).getAssetPath()#/css/style.css" type="text/css" media="all" />
</head>

<body id="svSendToFriend">

<cfform name="sendtofriend" method="post" action="sendlink.cfm">
<fieldset>
<legend>#rbFactory.getKey('stf.sendtoafriend')#</legend>
<input type="hidden" name="link" value="#HTMLEditFormat(url.link)#">
<ol>
<li class="req"><label>#rbFactory.getKey('stf.fname')#<ins> (#rbFactory.getKey('stf.required')#)</ins></label><cfinput type="text"  name="fname" required="yes" message="#rbFactory.getKey('stf.fnamerequired')#" size="20" maxlength="16" value="" class="text"></li>
<li class="req"><label>#rbFactory.getKey('stf.lname')#<ins> (#rbFactory.getKey('stf.required')#)</ins></label><cfinput type="text" name="lname" message="#rbFactory.getKey('stf.lnamerequired')#" required="yes" size="20" maxlength="16" value="" class="text" /></li>
<li class="req"><label>#rbFactory.getKey('stf.email')#<ins> (#rbFactory.getKey('stf.required')#)</ins></label><cfinput type="text" name="email" message="#rbFactory.getKey('stf.emailrequired')#"  required="yes" size="20" maxlength="47" value="" class="text" /></li>
<li><label>#rbFactory.getKey('stf.copyme')#</label><input type="checkbox" name="ccself" value="1"></li>
<li><label>#rbFactory.getKey('stf.recipientaddresses')#</label>
	<ul class="multiInputs">
	<li><span class="req"><cfinput type="text" name="sendto1" size="20" required="yes" message="#rbFactory.getKey('stf.recipientrequired')#" maxlength="47" value="" class="text" /><ins> (#rbFactory.getKey('stf.required')#)</ins></span></li>
	<li><input type="text" name="sendto2" size="20" maxlength="47" value="" class="text" /></li>
	<li><input type="text" name="sendto3" size="20" maxlength="47" value="" class="text" /></li>
	</ul>
</li>
<li><label>#rbFactory.getKey('stf.message')#</label><textarea rows="3" name="comments" cols="35"></textarea></li>
</ol>
<input type="hidden" name="siteID" value="#HTMLEditFormat(request.siteID)#"/>
</fieldset>
<div class="buttons"><input type="submit" name="btn_submit" value="#htmlEditFormat(rbFactory.getKey('stf.send'))#" alt="send" class="submit"></div>
</cfform>
<script type="text/javascript"><!-- document.sendtofriend.fname.focus(); // --></script>

</body>
</html>
</cfoutput>