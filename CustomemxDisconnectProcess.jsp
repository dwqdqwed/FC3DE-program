<%@include file = "../common/emxNavigatorTopErrorInclude.inc"%>
<%@include file = "emxNavigatorInclude.inc"%>
<%@include file = "../common/enoviaCSRFTokenValidation.inc"%>
<%@page import="com.matrixone.apps.domain.util.EnoviaResourceBundle"%>


<%
    String objectId  	   = emxGetParameter(request, "objectId"); 
    String[] strTableRowIds = emxGetParameterValues(request, "emxTableRowId");
	DomainObject obj = DomainObject.newInstance(context, objectId);
	
    try {       
        ContextUtil.startTransaction(context,true); 
		for(int i = 0 ; i < strTableRowIds.length ; i++){
			StringList idList = com.matrixone.apps.domain.util.StringUtil.split(strTableRowIds[i], "|");
			if(idList.size() > 1){
				String selId = (String)idList.get(0);
				DomainObject selObj = DomainObject.newInstance(context,selId);
				obj.disconnect(context, new RelationshipType("Custom ERP And MBOM"),true, selObj);
				
			}
		
		}
         ContextUtil.commitTransaction(context);
     } 
    catch(Exception e) 
	{
    	e.printStackTrace();
    	ContextUtil.abortTransaction(context);
	}
%> 

<script language="javascript" type="text/javaScript">
	top.refreshTablePage();
</script>
<%@include file = "../common/emxNavigatorBottomErrorInclude.inc"%>
