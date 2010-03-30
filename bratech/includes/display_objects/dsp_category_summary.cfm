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

<cfparam name="useRss" default="false">
<cfquery datasource="#application.configBean.getDatasource()#" username="#application.configBean.getDBUsername()#" password="#application.configBean.getDBPassword()#" name="rsSection">select contentid,filename,menutitle,target,restricted,restrictgroups,type,sortBy,sortDirection from tcontent where siteid='#request.siteid#' and contentid='#arguments.objectid#' and approved=1 and active=1 and display=1</cfquery>
<cfif rsSection.recordcount>
<cfsilent>
<cfif rsSection.type neq "Calendar">
<cfset today=now() />
<cfelse>
<cfset today=createDate(request.year,request.month,1) />
</cfif>
<cfset rs=application.contentGateway.getKidsCategorySummary(request.siteid,arguments.objectid,request.relatedID,today,rsSection.type)>
</cfsilent>
<cfif rs.recordcount>
<cfset rbFactory=getSite().getRBFactory() />
<cfoutput>
<div class="svCatSummary svIndex">
<#getHeaderTag('subHead1')#>#rbFactory.getKey('list.categories')#</#getHeaderTag('subHead1')#>
<ul class="navSecondary"><cfloop query="rs">
	<cfset class=iif(rs.currentrow eq 1,de('first'),de(''))>
		<li class="#class#<cfif listFind(request.categoryID,rs.categoryID)> current</cfif>"><a href="#application.configBean.getContext()##getURLStem(request.siteid,rsSection.filename)#?categoryID=#rs.categoryID#&relatedID=#HTMLEditFormat(request.relatedID)#">#rs.name# (#rs.count#)</a><cfif useRss><a class="rss" href="#application.configBean.getContext()#/tasks/feed/index.cfm?siteid=#request.siteid#&contentID=#rsSection.contentid#&categoryID=#rs.categoryID#" <cfif listFind(request.categoryID,rs.categoryID)>class="current"</cfif>>RSS</a></cfif></li>
	</cfloop>
	<li class="last"><a href="#application.configBean.getContext()##getURLStem(request.siteid,rsSection.filename)#?relatedID=#HTMLEditFormat(request.relatedID)#">View All</a><cfif useRss><a class="rss" href="#application.configBean.getContext()#/tasks/feed/index.cfm?siteid=#request.siteid#&contentID=#rsSection.contentid#">RSS</a></cfif></li>
</ul>
</div>
</cfoutput>
</cfif></cfif>