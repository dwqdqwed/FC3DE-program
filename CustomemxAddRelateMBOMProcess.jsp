<%--  emxDomainAccessProcess.jsp   - The Collection Memeber delete object processing page
   Copyright (c) 1992-2015 Dassault Systemes.
   All Rights Reserved.
--%>

<%@include file = "emxNavigatorInclude.inc"%>
<%@include file = "emxNavigatorTopErrorInclude.inc"%>
<%@include file = "enoviaCSRFTokenValidation.inc"%>
<%
    PropertyUtil.setGlobalRPEValue(context, DomainAccess.RPE_MEMBER_ADDED_REMOVED, "true");    
	String cmdEventToHandle = "CustomRelateMass";
    String objectId = emxGetParameter(request, "objectId");
    String[] ids = emxGetParameterValues(request, "emxTableRowId");
	DomainObject obj = DomainObject.newInstance(context, objectId);
	RelationshipType relType = new RelationshipType("Custom ERP And MBOM");
	for(int i = 0 ; i < ids.length ; i++){
		//String id = ids[i];
		//System.out.println("into this...id=="+id);
		StringList idList = com.matrixone.apps.domain.util.StringUtil.split(ids[i], "|");
		System.out.println("into this...idList=="+idList);
		if(idList.size() > 0){
			String id = (String)idList.get(0);
			obj.addToObject(context,relType,id);
		}
		
	}
%>
<%@include file = "emxNavigatorBottomErrorInclude.inc"%>

<script>
	var pageToRefresh = getTopWindow().parent.window.opener;
	var cmdEvent = "<%=XSSUtil.encodeForJavaScript(context,(String) cmdEventToHandle)%>";
	if (pageToRefresh) {
		if ("deleteAccess" == cmdEvent){
			getTopWindow().parent.window.location.reload();
		} else {
		getTopWindow().parent.window.opener.location.reload();
		getTopWindow().parent.window.close();
		getTopWindow().close();
		}
	}
	else
	{
		getTopWindow().refreshTablePage();
	}
</script>
