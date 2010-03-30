2
<cfoutput>
<cfinclude template="inc/html_head.cfm" />

<cfinclude template="inc/header.cfm" />	
	
	
	<table id="content" cellpadding="0" cellspacing="0">
		
		<tr>
			<td valign="top">
				<!--- - - - - - - - - - - - - - - - --->
				<!--- L E F T   N A V I G A T I O N --->
				<!--- - - - - - - - - - - - - - - - --->
				<cfinclude template="inc/inc_navLeft.cfm">
			</td>
		
		
			<td>
				<!--- B R E A D C R U M B S --->
				#renderer.dspCrumbListLinks("crumbList","&nbsp;&raquo;&nbsp;")#
				
				
				
				<div id="contentbody">
					
					<h1 class="pageTitle">#request.contentBean.getTitle()#</h1>
					#renderer.dspObjects(1)#
					#renderer.dspBody(body=request.contentBean.getbody(),pageTitle="",crumbList=0,showMetaImage=0)#
					<!--- #renderer.dspBody(body=request.contentBean.getbody(),pageTitle=request.contentBean.getTitle(),crumbList=0,showMetaImage=0)# --->

					<!--- <cfset variables.MiddleContentObject=renderer.dspObjects(2) />
					<cfif len(variables.MiddleContentObject)>
							<div style="border:1px solid;width:250px;padding:10px;margin:0 auto;font-size:80%;">
							<h1>Extra Information</h1>
							#variables.MiddleContentObject#
							</div>
					</cfif> --->
					
					<!--- <cfset variables.BottomContentObject=renderer.dspObjects(3) />
					<cfif len(variables.BottomContentObject)>
						<h2>More Information...</h2>
						#variables.BottomContentObject#
					</cfif> --->
					
					#renderer.dspObjects(2)#
					#renderer.dspObjects(3)#
					
				</div>
				
				<div style="clear: both;"></div>
				
			</td>
			<!--- <td id="contentright">
				<!--- Right Column --->
				
			</td> --->
		</tr>
		
	</table>
	
	
	
	
	
<cfinclude template="inc/footer.cfm" />

</cfoutput>