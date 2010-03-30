<!---<cfoutput>
<cfinclude template="inc/html_head.cfm" />
<body id="#renderer.gettopid()#" class="home">
<div id="container" class="#renderer.CreateCSSid(request.contentBean.getMenuTitle())#">
	<cfinclude template="inc/header.cfm" />
	<div id="content" class="clearfix">
		<div id="primary" class="content">
			#renderer.dspBody(body=request.contentBean.getbody(),pageTitle='',crumbList=0,showMetaImage=0)#
			#renderer.dspObjects(2)#
		</div>
		<div id="right" class="sidebar">
		#renderer.dspObjects(3)#
		</div>
	</div>
	<cfinclude template="inc/footer.cfm" />
</div>
</body>
</html>
</cfoutput>--->



<cfoutput>
<cfinclude template="inc/html_head.cfm" />

<body id="#renderer.gettopid()#" class="homebratech">

<cfinclude template="inc/header.cfm" />

<div id="mainbratech">
&nbsp;
</div> 
 
<div id="contentbratech">
	<div id="leftbratech">
		<h1>STRATEGY</h1>
		<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut.</p>
		<h2><a href="##" title="Read More">&##91;More&##93;</a></h2>
	</div>
	<div id="rightbratech">
		<h1>PLANNING</h1>
		<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>
		<h2><a href="##" title="Read More">&##91;More&##93;</a></h2>
	</div>
	<div id="centerbratech" >
		<h1>MANAGEMENT</h1>
		<p>Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.</p>
		<h2><a href="##" title="Read More">&##91;More&##93;</a></h2>
	</div>
</div>
<div id="containerbratech">
  <div id="lcontain">
  	#renderer.dspObjects(1)#
  	#renderer.dspObjects(2)#
  </div>
  <div id="rcontain">
  
  	#renderer.dspBody(body=request.contentBean.getbody(),pageTitle='',crumbList=0,showMetaImage=0)#
	#renderer.dspObjects(3)#
  
  </div>
</div> 

<cfinclude template="inc/footer.cfm" />

</body>
</html>
</cfoutput>
