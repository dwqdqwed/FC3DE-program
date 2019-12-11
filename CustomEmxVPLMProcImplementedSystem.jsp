<%@ page import = "java.util.HashMap" %>
<%@ page import = "matrix.db.*" %>
<%@ page import = "com.matrixone.apps.domain.DomainObject" %>
<%@ page import = "com.dassault_systemes.VPLMJProcessNavUI.VPLMJProcessAdapterUIModel" %>
<%@ page import = "com.matrixone.apps.domain.util.XSSUtil"%>


<%@include file="../emxUIFramesetUtil.inc"%>

<HEAD>
<%@include  file="../emxUICommonHeaderBeginInclude.inc"%>
</HEAD>
<BODY>
<%

	
	HashMap requestMap = UINavigatorUtil.getRequestParameterMap(pageContext);
	String relId = (String) requestMap.get("relId");

	String[] implementedProductID = null;
	if (!relId.equals(""))
	{
		VPLMJProcessAdapterUIModel adapterUIModel = VPLMJProcessAdapterUIModel.getInstance();
		implementedProductID = adapterUIModel.getImplementedPart(context, relId);
	}
	if (implementedProductID == null)
	{
		//String strAlertMessage = i18nNow.getI18nString("emxVPLMProcessEditor.Message.NoImplementedPart", "VPLMProcessEditor", context.getSession().getLanguage());
		String strAlertMessage = MessageUtil.getMessage(context, null, "emxVPLMProcessEditor.Message.NoImplementedPart", null, null, context.getLocale(), "emxVPLMProcessEditorStringResource");
		strAlertMessage = "\u6CA1\u6709\u96F6\u4EF6\u5DE5\u827A";
		%>
		<script  language="javascript"  type="text/javaScript">
		window.alert("<%=XSSUtil.encodeForJavaScript(context,strAlertMessage)%>");  
		top.location.href = "../common/emxCloseWindow.jsp";
		</script>
		<%    
	}
	else
	{
		String imPartId = implementedProductID[1];

		HashMap requestMap1 = new HashMap();
		requestMap1.put("id", imPartId);
		
		String[] initArgs = JPO.packArgs(requestMap1);
		
		String systemList = (String) JPO.invoke(context, "CustomEmxVPMTask", null, "getPPRProcess", initArgs,String.class);
		if (!UIUtil.isNotNullAndNotEmpty(systemList))
		{
		String strAlertMessage = MessageUtil.getMessage(context, null, "emxVPLMProcessEditor.Message.NoImplementedPart", null, null, context.getLocale(), "emxVPLMProcessEditorStringResource");
		strAlertMessage = "\u6CA1\u6709\u96F6\u4EF6\u5DE5\u827A";
		%>
			<script  language="javascript"  type="text/javaScript">
			window.alert("<%=XSSUtil.encodeForJavaScript(context,strAlertMessage)%>");  
			top.location.href = "../common/emxCloseWindow.jsp";
			</script>
		<%    
		}else{
			StringBuffer actionURL = new StringBuffer();
			actionURL.append("../common/emxTree.jsp?AppendParameters=true");
			actionURL.append("&objectId=");
			actionURL.append(systemList);			
			RequestDispatcher rd = request.getRequestDispatcher(actionURL.toString());
			rd.forward(request, response);
		}
	}

	
	//if (isStartedByMe) context.abort();
	%>

</BODY>
