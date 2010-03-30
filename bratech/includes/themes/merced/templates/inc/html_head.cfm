<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!--- SUGGESTED LANGUAGE ATTRIBUTES - xml:lang="en" lang="en" --->
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="description" content="#HTMLEditFormat(renderer.getmetadesc())#" />
	<meta name="keywords" content="#HTMLEditFormat(renderer.getmetakeywords())#" />
	<cfif request.contentBean.getCredits() neq ""><meta name="author" content="#HTMLEditFormat(request.contentbean.getCredits())#" /></cfif>
	<meta name="generator" content="Mura CMS #application.configBean.getVersion()#" />
	<!--- <meta name="robots" content="noindex, nofollow" /> ---><!--- use this to discourage search engines from indexing your site. (can be useful if developing on a live server for example) Delete if not needed. --->
	<title>#HTMLEditFormat(request.contentBean.getHTMLTitle())# - #HTMLEditFormat(renderer.getSite().getSite())#</title>

	<link rel="icon" href="#event.getSite().getAssetPath()#/images/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="#event.getSite().getAssetPath()#/images/favicon.ico" type="image/x-icon" />

	<link rel="stylesheet" href="#event.getSite().getAssetPath()#/css/default.css" type="text/css" media="all" />
	<link rel="stylesheet" href="#themePath#/css/typography.css" type="text/css" media="all" />
	<link rel="stylesheet" href="#themePath#/css/site.css" type="text/css" media="all" />
	<link rel="stylesheet" href="#event.getSite().getAssetPath()#/css/print.css" type="text/css" media="print" />
	<cfinclude template="ie_conditional_includes.cfm" />

	<cfset rs=application.feedManager.getFeeds(request.siteID,'Local',true,true) />
	<cfloop query="rs">
	<link rel="alternate" type="application/rss+xml" title="#HTMLEditFormat(renderer.getSite().getSite())# - #rs.name#" href="#XMLFormat('http://#listFirst(cgi.http_host,":")##application.configBean.getContext()#/tasks/feed/?feedID=#rs.feedID#')#" />
	</cfloop>

</head>
</cfoutput>