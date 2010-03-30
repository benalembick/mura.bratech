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
<cfset rbFactory=getSite().getRBFactory() />
</cfsilent>
<cfoutput><#getHeaderTag('headline')#>#rbFactory.getKey('search.searchresults')#</#getHeaderTag('headline')#></cfoutput>
<div id="svSearchResults">
<cfsilent>
<cfset rbFactory=getSite().getRBFactory() />
<cfparam name="rsnewsearch.recordcount" default="0"/>
<cfparam name="request.aggregation" default="false">
<cfparam name="request.searchSectionID" default="">
<cfparam name="session.rsSearch.recordcount" default=0>
<cfif (len(request.keywords) or len(request.tag) ) and isdefined('request.newSearch')>
<cfset session.aggregation=request.aggregation />
<cfset rsNewSearch=application.contentManager.getPublicSearch(request.siteid,request.keywords,request.tag,request.searchSectionID) /> 

<cfif getSite().getExtranet() eq 1>
	<cfset session.rsSearch=queryPermFilter(rsnewsearch)/>
<cfelse>
	<cfset session.rsSearch=rsnewsearch/>
</cfif>

<cfelseif request.keywords eq '' and isdefined('request.newSearch')>
<cfset session.rsSearch=newResultQuery()/>
</cfif>

<cfset TotalRecords=session.rsSearch.RecordCount>
<cfset RecordsPerPage=10> 
<cfset NumberOfPages=Ceiling(TotalRecords/RecordsPerPage)>
<cfset CurrentPageNumber=Ceiling(request.StartRow/RecordsPerPage)> 
<cfset next=evaluate((request.startrow+recordsperpage))	>
<cfset previous=evaluate((request.startrow-recordsperpage))	>
<cfset through=iif(totalRecords lt next,totalrecords,next-1)> 

<cfset iterator=application.serviceFactory.getBean("contentIterator")>
<cfset iterator.setQuery(session.rsSearch,RecordsPerPage)>
<cfset iterator.setStartRow(event.getValue("startrow"))>

<cfif len(request.searchSectionID)>
<cfset sectionBean=application.contentManager.getActiveContent(request.searchSectionID,request.siteid) />
</cfif>	
</cfsilent>

<cfoutput>
	<cfset args=arrayNew(1)>
	<cfset args[1]=session.rsSearch.recordcount>
	<cfif len(request.tag)>
		<cfset args[2]=htmlEditFormat(request.tag)>
		<cfif len(request.searchSectionID)>
			<cfset args[3]=htmlEditFormat(sectionBean.getTitle())>
			<p>#rbFactory.getResourceBundle().messageFormat(rbFactory.getKey('search.searchtagsection'),args)#</p>
		<cfelse>
			<p>#rbFactory.getResourceBundle().messageFormat(rbFactory.getKey('search.searchtag'),args)#</p>
		</cfif>
	<cfelse>
		<cfset args[2]=htmlEditFormat(request.keywords)>
		<cfif len(request.searchSectionID)>
			<cfset args[3]=htmlEditFormat(sectionBean.getTitle())>
	 		<p>#rbFactory.getResourceBundle().messageFormat(rbFactory.getKey('search.searchkeywordsection'),args)#</p>
		<cfelse>
			<p>#rbFactory.getResourceBundle().messageFormat(rbFactory.getKey('search.searchkeyword'),args)#</p>
		</cfif>
	</cfif>
</cfoutput>
<cfif totalrecords>
<cfoutput>
	<div class="moreResults top">
		<ul>
		<li class="resultsFound">#rbFactory.getKey('search.displaying')#: #request.startrow# - #through# #rbFactory.getKey('search.of')# #session.rsSearch.recordcount#</li>
		<cfif previous gte 1>
		<li class="navPrev"><a href="?startrow=#previous#&display=search&keywords=#HTMLEditFormat(request.keywords)#&searchSectionID=#HTMLEditFormat(request.searchSectionID)#&tag=#HTMLEditFormat(request.tag)#">&laquo;#rbFactory.getKey('search.prev')#</a></li>
		</cfif>
		<cfif session.rsSearch.recordcount gt 0 and  through lt session.rsSearch.recordcount>
		<li class="navNext"><a href="?startrow=#next#&display=search&keywords=#HTMLEditFormat(request.keywords)#&searchSectionID=#HTMLEditFormat(request.searchSectionID)#&tag=#HTMLEditFormat(request.tag)#">#rbFactory.getKey('search.next')#&raquo;</a></li>
		</cfif>
		</ul>
		</div>
</cfoutput>
		<dl id="svPortal" class="svIndex">
		<cfloop condition="iterator.hasNext()">
		<cfsilent> 
		<cfset class=iif(session.rsSearch.currentrow eq 1,de('first'),de(iif(session.rsSearch.currentrow eq session.rsSearch.recordcount,de('last'),de(''))))>
		<cfset item=iterator.next()>
		<cfset link=addlink(item.getValue('type'),item.getValue('filename'),item.getValue('menutitle'),item.getValue('target'),item.getValue('targetparams'),item.getValue('contentid'),item.getValue('siteid'),'?keywords=#request.keywords#',application.configBean.getContext(),application.configBean.getStub(),application.configBean.getIndexFile())>
		<cfset class=""/>
				<cfif not iterator.hasPrevious()> 
					<cfset class=listAppend(class,"first"," ")/> 
				</cfif>
				<cfif not iterator.hasNext()> 
					<cfset class=listAppend(class,"last"," ")/> 
				</cfif>
		</cfsilent>
		<cfoutput>
		<dt class="#class#">#iterator.getRecordIndex()#. #link#</dt>
	 	<cfif len(item.getValue('summary'))><dd class="#class#">#setDynamicContent(item.getValue('summary'),request.keywords)#</dd></cfif>
		<cfif len(item.getValue('tags'))><dd class="#class#"><cfmodule template="nav/dsp_tag_line.cfm"  tags="#item.getValue('tags')#"></dd></cfif>
		</cfoutput>
		</cfloop>
		</dl>
	<cfoutput>
	<div class="moreResults bottom">
		<ul>
		<li class="resultsFound">#rbFactory.getKey('search.displaying')#: #request.startrow# - #through# #rbFactory.getKey('search.of')# #session.rsSearch.recordcount#</li>
		<cfif previous gte 1>
		<li class="navPrev"><a href="?startrow=#previous#&display=search&keywords=#HTMLEditFormat(request.keywords)#&searchSectionID=#HTMLEditFormat(request.searchSectionID)#&tag=#HTMLEditFormat(request.tag)#">&laquo;#rbFactory.getKey('search.prev')#</a></li>
		</cfif>
		<cfif session.rsSearch.recordcount gt 0 and  through lt session.rsSearch.recordcount>
		<li class="navNext"><a href="?startrow=#next#&display=search&keywords=#HTMLEditFormat(request.keywords)#&searchSectionID=#HTMLEditFormat(request.searchSectionID)#&tag=#HTMLEditFormat(request.tag)#">#rbFactory.getKey('search.next')#&raquo;</a></li>
		</cfif></ul></div>
	</cfoutput>
	</cfif>	
	
	<cfoutput>
<form id="svSearchAgain" name="searchFrm" action="" method="get">
<p>#rbFactory.getKey('search.didnotfind')#</p>
#rbFactory.getKey('search.search')#: <input type="text" name="keywords" value="#HTMLEditFormat(request.keywords)#" /><input name="newSearch" value="true" type="hidden"/><input name="nocache" value="1" type="hidden"/><input name="searchSectionID" value="#HTMLEditFormat(request.searchSectionID)#" type="hidden"/>  <input name="display" value="search" type="hidden"/><input type="submit" class="submit" value="#htmlEditFormat(rbFactory.getKey('search.go'))#" alt="submit" /><!--- <input type="image" class="submit" src="/default/images/btn_search.gif" alt="submit" /> ---></form>
</cfoutput></div>