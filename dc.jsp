<!DOCTYPE html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.util.*" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.EntityNotFoundException" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilter" %>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery" %>
<%@ page import="javax.jdo.JDOHelper" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="javax.jdo.PersistenceManagerFactory" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
<meta name="viewport" content="width=device-width">
<title>DetailedFind</title>
</head>
<body>
<%
/* start Java Code */
/* ------------------------------------------------------------------------------ */
/*
	get category name from URL line
*/
String categoryName = request.getParameter("categoryName");
/* debug */ System.out.println( "------------------ start ----------------------" );
/* debug */ System.out.println( "categoryName = " + categoryName );
/* debug */ if( categoryName == null)
/* debug */ {
/* debug */ 	System.out.println( "categoryName is null" );
/* debug */ }

/* check if Mobile browser is being used */

String ua = request.getHeader("User-Agent").toLowerCase();
System.out.println( "header: User-Agent " + ua );

if(ua.matches("(?i).*((android|bb\\d+|meego).+mobile|avantgo|bada\\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\\.(browser|link)|vodafone|wap|windows ce|xda|xiino).*")||ua.substring(0,4).matches("(?i)1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\\-(n|u)|c55\\/|capi|ccwa|cdm\\-|cell|chtm|cldc|cmd\\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\\-s|devi|dica|dmob|do(c|p)o|ds(12|\\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\\-|_)|g1 u|g560|gene|gf\\-5|g\\-mo|go(\\.w|od)|gr(ad|un)|haie|hcit|hd\\-(m|p|t)|hei\\-|hi(pt|ta)|hp( i|ip)|hs\\-c|ht(c(\\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\\-(20|go|ma)|i230|iac( |\\-|\\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\\/)|klon|kpt |kwc\\-|kyo(c|k)|le(no|xi)|lg( g|\\/(k|l|u)|50|54|\\-[a-w])|libw|lynx|m1\\-w|m3ga|m50\\/|ma(te|ui|xo)|mc(01|21|ca)|m\\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\\-2|po(ck|rt|se)|prox|psio|pt\\-g|qa\\-a|qc(07|12|21|32|60|\\-[2-7]|i\\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\\-|oo|p\\-)|sdk\\/|se(c(\\-|0|1)|47|mc|nd|ri)|sgh\\-|shar|sie(\\-|m)|sk\\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\\-|v\\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\\-|tdg\\-|tel(i|m)|tim\\-|t\\-mo|to(pl|sh)|ts(70|m\\-|m3|m5)|tx\\-9|up(\\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\\-|your|zeto|zte\\-"))
{
	System.out.println( "header: User-Agent indicate Mobile Browser" );

	/* end Java Code */
	%>
	Mobile Browser
	<br>
	<%
	/* start Java Code */
}

DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

/* ------------------------------------------------------------------------------ */
/*
	get filters selected in the form
*/
System.out.println("ApplyFilterServlet: categoryName = " + categoryName );

if( categoryName != null)
{
	Entity schema;
	try
	{
		Key schemaKey = KeyFactory.createKey("Schema", categoryName);

		schema = datastore.get(schemaKey);			/* get Schema Entity from datastore */
	
		System.out.print( "dc.jsp: ------------------------- fields = " );
		System.out.println( schema.getProperty("Fields").toString() );
		
		Entity item = new Entity(categoryName);
		
		System.out.println( "dc.jsp: filters:" );

		long fields = Long.parseLong( schema.getProperty("Fields").toString() , 10);
		for(int field = 1; field <= fields; field = field+1)
		{
		    String fieldName = "FieldName" + field;
		    
		    String categoryFilterMinName = categoryName + "Min" + field;
		    String categoryFilterMaxName = categoryName + "Max" + field;
		    String categoryFilterCheckboxName = categoryName + "Checkbox" + field;
		    String categoryFilterTextName = categoryName + "Text" + field;
		    
		    String categoryFilterMinValue = request.getParameter( categoryFilterMinName );
		    String categoryFilterMaxValue = request.getParameter( categoryFilterMaxName );
		    String categoryFilterCheckboxValue = request.getParameter( categoryFilterCheckboxName );
		    String categoryFilterTextValue = request.getParameter( categoryFilterTextName );
	
		    categoryFilterMinName = categoryFilterMinName.replaceAll("\\s","_");
		    categoryFilterMaxName = categoryFilterMaxName.replaceAll("\\s","_");
		    categoryFilterCheckboxName = categoryFilterCheckboxName.replaceAll("\\s","_");
		    categoryFilterTextName = categoryFilterTextName.replaceAll("\\s","_");
	
			System.out.print( schema.getProperty( fieldName ) );
		    System.out.print( " = " );
		    System.out.print( categoryFilterMinName );
		    System.out.print( " = " );
		    System.out.print( categoryFilterMinValue );
		    System.out.print( " = " );
		    System.out.print( categoryFilterMaxName );
		    System.out.print( " = " );
		    System.out.print( categoryFilterMaxValue );
		    System.out.print( " = " );
		    System.out.print( categoryFilterCheckboxName );
		    System.out.print( " = " );
		    System.out.println( categoryFilterCheckboxValue );
		    System.out.print( " = " );
		    System.out.print( categoryFilterTextName );
		    System.out.print( " = " );
		    System.out.println( categoryFilterTextValue );
		}
	}
	catch (EntityNotFoundException e) 
	{
		// TODO Auto-generated catch block
		System.out.println( "ApplyFilterServlet: no fields defined for this category" );
	}
}

/*
 	get user name - google login --------------------------------------------------------------------
*/
UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();
String userNickname = "";
if(user != null)
{
	userNickname = userService.getCurrentUser().getNickname();
	/* debug */ System.out.print( "dc: usernickname = " );
	/* debug */ System.out.println( userNickname );
}
/* debug */ System.out.print( "dc: user = " );
/* debug */ System.out.println( user );
boolean superuser = false;
if (user != null)
{
    pageContext.setAttribute("user", user);
	/* end Java Code */
	%>
	<p align="right">
		<span style="float: right">
		<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>
	</p>
	<%
	/* start Java Code */

	/* --------------------------------------------------------------------------------- */
	/* debug */ System.out.println( user.toString() );

	if(userNickname.equals("pklaptop1") )
	{
		superuser = true;
		/* debug */ System.out.println( "superuser" );
	}
	else
	{
		superuser = true; /* temporarily for Enova */
		/* debug */ System.out.println( "not superuser" );
	}
}
else
{
	/* end Java Code */ %>
	<p align="right">
		<span style="float: right">
 	  	<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a>
   	</p>
	<% /* start Java Code */
}

/* ------------------------------- display Categories ---------------------------------------- */

String categoryKind = "Category";

Query query = new Query(categoryKind).addSort("CategoryName", Query.SortDirection.ASCENDING);
/* debug */ System.out.println( "dc: query" );
/* debug */ System.out.println( query );

/* DatastoreService datastore = DatastoreServiceFactory.getDatastoreService(); */

List<Entity> items = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
/* debug */ System.out.println( "dc: items" );
/* debug */ System.out.println( items );

if(items.isEmpty())
{
	/* end Java Code */
	%>
	<p>no Categories in the database</p>
	<%
	/* start Java Code */
}
else
{
	/* end Java Code */
	%>
	<!-- --------------------- Display Categories -------------------- -->
	<form action="/dc.jsp" method="get">
	<div>
	<%
	/* start Java Code */

	for (Entity item : items)
	{
	   	pageContext.setAttribute("categoryName", item.getProperty("CategoryName"));
	   	/*
		   	System.out.print( "dc(for-categories): categoryName = " );
				System.out.println( categoryName );
		*/
		/* end Java Code */
		%>
		<input type="submit" name="categoryName" value="${fn:escapeXml(categoryName)}"/>
		<%
		/* start Java Code */
	}
	/* end Java Code */
	%>
	</div>
	</form>
	<%
	/* start Java Code */
}

/* ---------------------------------- Display Filters --------------------------- */

/* end Java Code */
%>
<div id="menu" style="height:200px;width:190px;float:left;">
<br>

<%
/* start Java Code */

if (categoryName != null)
{
	datastore = DatastoreServiceFactory.getDatastoreService();
	
   	pageContext.setAttribute("categoryName_attribute", categoryName);

	Entity schema;
	try
	{
		Key schemaKey = KeyFactory.createKey("Schema", categoryName);

		schema = datastore.get(schemaKey);		/* get Schema Entity for selected category from datastore */

		/*
		long count = (Long) schema.getProperty("count");
		*/

		/* debug */ System.out.print( "dc: fields = " );
		/* debug */ System.out.println( schema.getProperty("Fields").toString() );

		/* end Java Code */
		%>
		<form action="/dc.jsp" method="post">
		<div>
		<input type="submit" value="Filter ${fn:escapeXml(categoryName_attribute)}"/>
		<br>
		<%
		/* start Java Code */
		
		long fields = Long.parseLong( schema.getProperty("Fields").toString() , 10);
		for(int field = 1; field <= fields; field = field+1)
		{
		    String fieldName = "FieldName" + field;
		    String filterMinMaxName = "FilterMinMax" + field;
		    String filterCheckboxName = "FilterCheckbox" + field;
		    String filterTextName = "FilterText" + field;

		    String categoryFilterMinName = categoryName + "Min" + field;
		    String categoryFilterMaxName = categoryName + "Max" + field;
		    String categoryFilterCheckboxName = categoryName + "Checkbox" + field;
		    String categoryFilterTextName = categoryName + "Text" + field;

		    /*
		    categoryFilterMinName = categoryFilterMinName.replaceAll("\\s","_");
		    categoryFilterMaxName = categoryFilterMaxName.replaceAll("\\s","_");
		    categoryFilterCheckboxName = categoryFilterCheckboxName.replaceAll("\\s","_");
		    categoryFilterTextName = categoryFilterTextName.replaceAll("\\s","_");
		    */

		    /* debug */ System.out.println( schema.getProperty( fieldName ) );

		   	/*
		   	String fieldNameValue = schema.getProperty( fieldName ));
		   	*/
		   	
		    String categoryFilterMinValue = request.getParameter( categoryFilterMinName );
		    String categoryFilterMaxValue = request.getParameter( categoryFilterMaxName );
		    String categoryFilterCheckboxValue = request.getParameter( categoryFilterCheckboxName );
		    String categoryFilterTextValue = request.getParameter( categoryFilterTextName );
	
		   	pageContext.setAttribute("fieldName_attribute", schema.getProperty( fieldName ));
		   	pageContext.setAttribute("categoryFilterMinName_attribute", categoryFilterMinName );
		   	pageContext.setAttribute("categoryFilterMaxName_attribute", categoryFilterMaxName );
		   	pageContext.setAttribute("categoryFilterCheckboxName_attribute", categoryFilterCheckboxName );
		   	pageContext.setAttribute("categoryFilterTextName_attribute", categoryFilterTextName );

		   	pageContext.setAttribute("categoryFilterMinValue_attribute", categoryFilterMinValue );
		   	pageContext.setAttribute("categoryFilterMaxValue_attribute", categoryFilterMaxValue );
		   	pageContext.setAttribute("categoryFilterCheckboxValue_attribute", categoryFilterCheckboxValue );
		   	pageContext.setAttribute("categoryFilterTextValue_attribute", categoryFilterTextValue );

		   	/* checkbox - start */
			String filterCheckboxValue = (String)schema.getProperty( filterCheckboxName );
			
			/* debug */ System.out.print( "filterCheckboxValue: >" );
			/* debug */ System.out.print( schema.getProperty( filterCheckboxName ) );
			/* debug */ System.out.print( "<>" );

			/* debug */ System.out.print( filterCheckboxValue );
			/* debug */ System.out.println( "<" );
			
			if( filterCheckboxValue != null)
			{
			   	if( filterCheckboxValue.equals("Y") )
			   	{
			   		if( categoryFilterCheckboxValue != null)
			   		{
				   		if( categoryFilterCheckboxValue.equals("Y") )
				   		{
					   		/* end Java Code */ 
							%>
							<input type="checkbox" name="${fn:escapeXml(categoryFilterCheckboxName_attribute)}" value="Y" checked>
							<% 
							/* start Java Code */			   		
						}
			   		}
			   		else
			   		{
				   		/* end Java Code */ 
						%>
						<input type="checkbox" name="${fn:escapeXml(categoryFilterCheckboxName_attribute)}" value="Y">
						<% 
						/* start Java Code */
		   			}
			   	}
			}
			/* checkbox - end */
			
			/* end Java Code */
			%>
			${fn:escapeXml(fieldName_attribute)}
			<% 
			/* start Java Code */
			String filterMinMaxValue = (String)schema.getProperty( filterMinMaxName );

			if( filterMinMaxValue != null)
			{
				if( filterMinMaxValue.equals("Y") )
			   	{
					/* end Java Code */ 
					%>
					<br>
					<input type="text" name="${fn:escapeXml(categoryFilterMinName_attribute)}" value="${fn:escapeXml(categoryFilterMinValue_attribute)}" size="4">min
					<br>
					<input type="text" name="${fn:escapeXml(categoryFilterMaxName_attribute)}" value="${fn:escapeXml(categoryFilterMaxValue_attribute)}" size="4">max
					<% 
					/* start Java Code */
			   	}
			}
			
			
			String filterTextValue = (String)schema.getProperty( filterTextName );

			if( filterTextValue != null)
			{
				if( filterTextValue.equals("Y") )
			   	{
					/* end Java Code */ 
					%>
					<br>
					<input type="text" name="${fn:escapeXml(categoryFilterTextName_attribute)}" value="${fn:escapeXml(categoryFilterTextValue_attribute)}" size="4">text
					<% 
					/* start Java Code */
			   	}
			}

			/* end Java Code */ 
			%>
			<br>
			<% 
			/* start Java Code */
		}
		
		/* end Java Code */
		%>
		<input type="submit" value="Filter ${fn:escapeXml(categoryName_attribute)}"/>
		<input type="hidden" name="categoryName" value="${fn:escapeXml(categoryName_attribute)}"/>
		</div>
		</form>
		<%
		/* start Java Code */


	}
	catch (EntityNotFoundException e) 
	{
		// TODO Auto-generated catch block
		/* debug */ System.out.println( "dc: no fields defined for this category" );
	}
}

/* ------------------------------------------------------------------------------ */
/*
	<div id="content" style="height:200px;width:400px;float:left;">
*/
/* end Java Code */
%>
</div>

<div id="content" style="height:10px;width:10px;float:left;">

<%
/* start Java Code */

/* ---------------------------------- Display Items in selected Category --------------------------- */

/* ---------------- list Field Names (table heading) for selected Category --------------------------- */

/* debug */ System.out.println( "dc: display category names" );
/* debug */ System.out.println( "category name: " );
/* debug */ System.out.println( categoryName );

if (categoryName != null)
{
	datastore = DatastoreServiceFactory.getDatastoreService();
	
	Entity schema;
	try
	{
		Key schemaKey = KeyFactory.createKey("Schema", categoryName);

		schema = datastore.get(schemaKey);			/* get Schema Entity from datastore */
	
		/* debug */ System.out.print( "dc: fields = " );
		/* debug */ System.out.println( schema.getProperty("Fields").toString() );
	
		/* end Java Code */ 
		%>
		<table>
		<tr>
		<% 
		/* start Java Code */
		
		long fields = Long.parseLong( schema.getProperty("Fields").toString() , 10);
		for(int field = 1; field <= fields; field = field+1)
		{
		    String fieldName = "FieldName" + field; 
	
		    /* debug */ System.out.println( schema.getProperty( fieldName ) );
			
		   	pageContext.setAttribute("fieldName_attribute", schema.getProperty( fieldName ));
		   	
			/* end Java Code */ 
			%>
			<td>
			${fn:escapeXml(fieldName_attribute)}
			</td>
			<% 
			/* start Java Code */
		}
		
		/* end Java Code */
		%>
		</tr>
		<%
		
		/* start Java Code */
		
		/* debug */ System.out.println( "dc: list items if any" );
		
		/* --------------------------------------------------------------------------------- */
		/* if there are any items for this schema, display them */
		
		String itemKind = categoryName;
	
		/* debug */ System.out.print( "itemKind: " );
		/* debug */ System.out.println( itemKind );
	
	    String fieldName = "FieldName" + 1;
	    
	    /* debug */ System.out.println( schema.getProperty( fieldName ) );
	    /* debug */ System.out.print( "fieldName1: " );
	    /* debug */ System.out.println( schema.getProperty( fieldName ) );
	    /* debug */ System.out.print( "fieldName1: " );
	    /* debug */ System.out.println( schema.getProperty( fieldName ).toString() );

		/* QUERY ---------------------------------------- */
		
		query = new Query(itemKind)
			.addSort(schema.getProperty( fieldName ).toString(), Query.SortDirection.ASCENDING);

		/* debug */ System.out.println( "-------------------------------------------------------" );
		/* debug */ System.out.println( "dc: query" );
		/* debug */ System.out.println( query );
			
		/* DatastoreService datastore = DatastoreServiceFactory.getDatastoreService(); */
		
		items = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
			System.out.println( "dc: items" );
			System.out.println( items );
		
	   	pageContext.setAttribute("fieldName_attribute", categoryName);
	
		if(items.isEmpty())
		{
			/* end Java Code
			%>
			<p>no items in the database for ${fn:escapeXml(fieldName_attribute)} category</p>
			<%
			start Java Code */
		}
		else
		{
			/* display items in category ----------------------------------------------------------------- */
			for (Entity item : items)
			{
				/* for each item, check each field to see if it should be filtered out */
				boolean displayRow = true;
				fields = Long.parseLong( schema.getProperty("Fields").toString() , 10);
				for(int field = 1; field <= fields; field = field+1)
				{
				    fieldName = "FieldName" + field; 
				    /*
			    	if checkbox and value is "Y" then display
			    	else don't display
			    	
			    	if min/max and value is >= min and <= max the display
			    	else don't display
				    */
				    String filterMinMaxName = "FilterMinMax" + field;
				    String filterCheckboxName = "FilterCheckbox" + field;
				    String filterTextName = "FilterText" + field;
	
				    String categoryFilterMinName = categoryName + "Min" + field;
				    String categoryFilterMaxName = categoryName + "Max" + field;
				    String categoryFilterCheckboxName = categoryName + "Checkbox" + field;
				    String categoryFilterTextName = categoryName + "Text" + field;
	
				    /* debug */ System.out.println( "field name = " + schema.getProperty( fieldName ) );
	
				   	/*
				   	String fieldNameValue = schema.getProperty( fieldName ));
				   	*/
				   	
				    String categoryFilterMinValue = request.getParameter( categoryFilterMinName );
				    String categoryFilterMaxValue = request.getParameter( categoryFilterMaxName );
				    String categoryFilterCheckboxValue = request.getParameter( categoryFilterCheckboxName );
				    String categoryFilterTextValue = request.getParameter( categoryFilterTextName );
			

				    if( categoryFilterCheckboxValue != null )
				    {
					    if( categoryFilterCheckboxValue.equals( "Y" ) )
					    {
						    /* debug */ System.out.println( "CHECKBOX!!!" );
					   		String fieldValue = (String)item.getProperty( schema.getProperty( fieldName ).toString() );
							if( fieldValue != null)
							{
								if( fieldValue.equals( "Y" ) )
								{
								    /* debug */ System.out.println( "should display this record !!!" );
								}
								else
								{
								    /* debug */ System.out.println( "should not display this record !!!" );
								    displayRow = false;
								}
							}
							else
							{
								/* no value is entered for this field and checkbox is checked so don't display */
								displayRow = false;
							}
					    }
				    }
				    System.out.println("check min");

				    if( categoryFilterMinValue != null )
				    {
						/* long fieldValue = Long.parseLong( schema.getProperty("fieldName").toString() , 10); */
						System.out.println( "min value - entered into filter = " + categoryFilterMinValue);
						/* System.out.println( "min value - entered into filter = " + fieldValue); */
						
						if( categoryFilterMinValue != "" )
						{
				   			System.out.println( "min value - categoryFilterMinName = " + categoryFilterMinName );
						    System.out.println( "a " + schema.getProperty( fieldName ).toString() );
						    System.out.println( "a (88) >" + item.getProperty( schema.getProperty( fieldName ).toString() ) + "<" );

						    if( item.getProperty( schema.getProperty( fieldName ).toString() ) != "" )
				    		{
						    	System.out.println( "min is not null" );
							    String dbStringMinValue = (String)item.getProperty( schema.getProperty( fieldName ).toString() );
							    System.out.println( "min value - dbStringValue = " + dbStringMinValue );
	
							    if( dbStringMinValue != null )
							    {
								    System.out.println( "dbStringMinValue = >" + dbStringMinValue + "<" );

								    long dbLongValue = Long.parseLong( dbStringMinValue, 10 );
								    System.out.println( "min value - dbLongValue = " + dbLongValue );
								    
								    long filterLongMinValue = Long.parseLong( categoryFilterMinValue, 10 );
		
								    if( dbLongValue < filterLongMinValue )
								    {
										displayRow = false;
								    }
							    }
							    else
							    {
							    	/* don't display items with blank field when filtering on that field */
									displayRow = false;
							    }
							}
						}
				    }
				    System.out.println("check max");
				    if( categoryFilterMaxValue != null )
				    {
						/* long fieldValue = Long.parseLong( schema.getProperty("fieldName").toString() , 10); */
						System.out.println( "max value - entered into filter = " + categoryFilterMaxValue);
						/* System.out.println( "min value - entered into filter = " + fieldValue); */

						if( categoryFilterMaxValue != "" )
						{
				   			System.out.println( "max value - categoryFilterMaxName = " + categoryFilterMaxName );
						    System.out.println( "a " + schema.getProperty( fieldName ).toString() );
						    System.out.println( "a (8) " + item.getProperty( schema.getProperty( fieldName ).toString() ) );

						    if( item.getProperty( schema.getProperty( fieldName ).toString() ) != "" )
						    {
						    	System.out.println( "max is not null" );

							    String dbStringMaxValue = (String)item.getProperty( schema.getProperty( fieldName ).toString() );
							    System.out.println( "max value - dbStringValue = " + dbStringMaxValue );
	
							    if( dbStringMaxValue != null )
							    {
								    long dbLongValue = Long.parseLong( dbStringMaxValue, 10 );
								    System.out.println( "max value - dbLongValue = " + dbLongValue );
								    
								    long filterLongMaxValue = Long.parseLong( categoryFilterMaxValue, 10 );
		
								    if( dbLongValue > filterLongMaxValue )
								    {
										displayRow = false;
								    }
							    }
							    else
							    {
							    	/* don't display items with blank field when filtering on that field */
									displayRow = false;
							    }
							}
						}

				    }
				    System.out.println("check text");

				    if( categoryFilterTextValue != null )
				    {
						/* long fieldValue = Long.parseLong( schema.getProperty("fieldName").toString() , 10); */
						System.out.println( "Text value - entered into filter = " + categoryFilterTextValue);
						/* System.out.println( "Text value - entered into filter = " + fieldValue); */

						if( categoryFilterTextValue != "" )
						{
				   			System.out.println( "Text value - categoryFilterTextName = " + categoryFilterTextName );
						    System.out.println( "a " + schema.getProperty( fieldName ).toString() );
						    System.out.println( "a (8) " + item.getProperty( schema.getProperty( fieldName ).toString() ) );

						    if( item.getProperty( schema.getProperty( fieldName ).toString() ) != "" )
						    {
						    	System.out.println( "text is not null" );

							    String dbStringTextValue = (String)item.getProperty( schema.getProperty( fieldName ).toString() );
							    System.out.println( "Text value - dbStringTextValue = " + dbStringTextValue );
	
							    if( dbStringTextValue != null )
							    {						    	
								    if( !dbStringTextValue.toLowerCase().contains(categoryFilterTextValue.toLowerCase()) )
								    {
										displayRow = false;
								    }
							    }
							    else
							    {
							    	/* don't display items with blank field when filtering on that field */
									displayRow = false;
							    }
						    }
						}

				    }

				}

				if( displayRow )
				{
					/* display */

					/* if not filtered out, then display */
					
					/* for each item, get field names and values of each field name */
					
					/* end Java Code */ 
					%>
					<tr>
					<% 
					/* start Java Code */
							
					fields = Long.parseLong( schema.getProperty("Fields").toString() , 10);
					for(int field = 1; field <= fields; field = field+1)
					{
					    fieldName = "FieldName" + field; 
				
					    /* debug */ System.out.println( schema.getProperty( fieldName ) );
					    /* debug */ System.out.println( item.getProperty( schema.getProperty( fieldName ).toString() ) );
					    
					    if( item.getProperty( schema.getProperty( fieldName ).toString()) != null)
					    {
					   		String fieldValue = (String)item.getProperty( schema.getProperty( fieldName ).toString() );
						    /* debug */ System.out.println( "---> value in: " + fieldName + " = " + schema.getProperty( fieldName ) );
						    /* debug */ System.out.println( "---> value in: " + fieldName + " = " + fieldValue );
					    }
					    else
					    {
						    /* debug */ System.out.println( "---> null value in: " + fieldName );
					    }
					   	pageContext.setAttribute("item_attribute", item.getProperty( schema.getProperty( fieldName ).toString() ));
	
						/*
					   	pageContext.setAttribute("item_attribute", item.getProperty( schema.getProperty( fieldName ).toString() ));
					   	*/
						/* end Java Code */ 
						%>
				
						<td>
						${fn:escapeXml(item_attribute)}
						</td>
						
						<% 
						/* start Java Code */
					}
					/* end Java Code */ 
					%>
					<tr>
					<% 
					/* start Java Code */
				}
			}
		}
		/* end Java Code */
		%>
		<!--  </table> -->
		<%
		/* start Java Code */
		
		/* if user is logged in, give opportunity to add items ------------------------------------ */
		
		if(superuser)
		{
			/* debug */ System.out.print( "dc: user : " );
			/* debug */ System.out.println( user );
			
			pageContext.setAttribute("categoryName_attribute", categoryName); /* set HTML variable */

			/* debug */ System.out.println( "dc: user is logged in" );
			/* end Java Code */
			%>
			<br>
			<form action="/addItem" method="post">
			    <!--  <table> -->
				<% 
				/* start Java Code */
				fields = Long.parseLong( schema.getProperty("Fields").toString() , 10);
				for(int field = 1; field <= fields; field = field+1)
				{
				    fieldName = "FieldName" + field; 
				    /* debug */ System.out.println( schema.getProperty( fieldName ) );
				   	pageContext.setAttribute("fieldName_attribute", schema.getProperty( fieldName ));
				   	pageContext.setAttribute("fieldName", fieldName );
					/* end Java Code */ 
					%>
					<td>
				    <input type="text" name="${fn:escapeXml(fieldName_attribute)}" value=""/>
					</td>
					<input type="hidden" name=fieldName value="${fn:escapeXml(fieldName_attribute)}"/>
					<!--  the line below should probably be removed -->
					<input type="hidden" name="FieldName1" value="${fn:escapeXml(fieldName_attribute)}"/>
					<% 
					/* start Java Code */
				}
				/* end Java Code */
				%>
				</table>
			    <input type="submit" value="Add Item to ${fn:escapeXml(categoryName_attribute)}"/>
			    <input type="hidden" name="categoryName" value="${fn:escapeXml(categoryName_attribute)}"/>
			    	    	
			</form>
			<%
			/* start Java Code */
		}
	}
	catch (EntityNotFoundException e) 
	{
		// TODO Auto-generated catch block
		/* debug */ System.out.println( "dc: no fields defined for this category" );
	}
}

/* ------------------------ Add Field to Field Names (Schema) for Category ---------------------------- */

/* debug */ System.out.println( "dc: add Field Names" );

if (superuser && categoryName != null)
{
	/* if user is logged in and Category is selected, 
			then give opportunity to add fields to Category */

	/* debug */ System.out.print( "dc(categoryName not null): categoryName = " );
	/* debug */ System.out.println( categoryName );

	pageContext.setAttribute("categoryName_attribute", categoryName); /* set HTML variable */

	/* end Java Code */
	%>
	<div id="content" style="height:auto;width;auto;float:left;">
	<div id="content" style="height:10px;width:800px;float:left;">
	<br><br>
	<!-- ----------------------------- Add Field to Category --------------------------- -->
	<form action="/addCategoryField" method="post">
	    <div>
	    	<input type="text" name=fieldValue value=""/>
	    	<input type="checkbox" name=filterMinMax value="Y">min/max
	    	<input type="checkbox" name=filterCheckbox value="Y">checkbox
	    	<input type="checkbox" name=filterText value="Y">text
	    	
	    	<input type="submit" value="Add Field to ${fn:escapeXml(categoryName_attribute)}"/>
	    </div>
	    <input type="hidden" name="categoryName" value="${fn:escapeXml(categoryName_attribute)}"/>
	    <input type="hidden" name="fieldName" value="${fn:escapeXml(fieldName_attribute)}"/>
	    <!-- 
	    <input type="hidden" name="fieldValue" value="${fn:escapeXml(fieldValue)}"/>
	     -->	    
	</form>
	<%
	/* start Java Code */
}

/* debug */ System.out.println( "dc: add Category" );

if (superuser)
{
	/* ------------ if user logged in, give opportunity to add a Category --------------- */
  	/* end Java Code */
  	%>
  	<!-- ----------------------------- Add Category --------------------------- -->
	<form action="/addCategory" method="post">
	    <div>
	    	<input type="text" name="categoryName" value=""/>
	    	<input type="submit" value="Add Category"/>
	    </div>
	    <input type="hidden" name="categoryName" value="${fn:escapeXml(categoryName)}"/>  
	</form>
	<%
	/* start Java Code */
}

/* debug */ System.out.println( "dc: done" );
/* end Java Code */
%>
</div>
</body>
</html>
